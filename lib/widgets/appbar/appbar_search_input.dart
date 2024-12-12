import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';
import 'package:ufo_elektronika/screens/product/product_screen.dart';
import 'package:ufo_elektronika/screens/search_result/search_result_screen.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar_repository.dart';

String lastSearch = "";
class AppBarSearchInput extends StatefulWidget {
  const AppBarSearchInput({
    super.key, 
    this.onSubmitted, 
    this.onChanged, 
    this.hintText, 
    this.showOverlay = true
  });
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final bool showOverlay;

  @override
  State<AppBarSearchInput> createState() => _AppBarSearchInputState();
}

class _AppBarSearchInputState extends State<AppBarSearchInput> {
  bool showSearchIcon = true;
  bool isLoading = false;
  Timer? _debounce;
  SearchResponse state = SearchResponse(products: []);
  final repository = AppBarRepositoryImpl(dio: Get.find());
  final TextEditingController searchController = TextEditingController()..text = lastSearch;
  final FocusNode focusNode = FocusNode();
  OverlayEntry? overlayEntry;
  final LayerLink layerLink = LayerLink();
  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      if (mounted) {
        setState(() {
          showSearchIcon = searchController.text.isEmpty;
        });
      }
    });
    if (widget.showOverlay) {
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          bool hasSetupSearchController = false;
          overlayEntry = OverlayEntry(
            builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                void search(String keyword) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 400), () async {
                    if (keyword.isEmpty) {
                      if (context.mounted) {
                        setState(() {
                          state = SearchResponse(products: []);
                        });
                      }
                    } else {
                      try {
                        if (context.mounted) {
                          setState(() {
                            isLoading = true;
                          });
                          final searchResponse = await repository.search(keyword);
                          setState(() {
                            state = searchResponse;
                            isLoading = false;
                          });
                        }
                      } catch (error) {
                        Get.showSnackbar(GetSnackBar(
                          message: error is DioException ? (error.response?.data["error"] ?? "Terjadi kesalahan. Silakan coba lagi") : "Terjadi kesalahan. Silakan coba lagi",
                          duration: const Duration(seconds: 2),
                        ));
                      }
                    }
                  });
                }

                if (hasSetupSearchController == false) {
                  hasSetupSearchController = true;
                  searchController.addListener(() {
                    search(searchController.text);
                  });
                }
                
                return Stack(
                  children: [
                    ModalBarrier(
                      onDismiss: () {
                        focusNode.unfocus();
                        searchController.clear();
                        if (widget.showOverlay) search("");
                        setState(() {
                          state = SearchResponse(products: []);
                        });
                      },
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 30,
                      child: CompositedTransformFollower(
                        offset: Offset((Get.find<RouteObserver>().navigator?.canPop() == true ? -15 :  0), -MediaQuery.paddingOf(context).top+30),
                        link: layerLink,
                        showWhenUnlinked: false,
                        child: SafeArea(
                          child: Material(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: isLoading || state.products.isEmpty ? null : Border.all(color: const Color(0xFF999999))
                              ),
                              child: isLoading ? const Center(child: CircularProgressIndicator()) : SizedBox(
                                  height: min(250, state.products.length * 42),
                                  child: ListView(
                                    children: state.products.map((e) => Container(
                                      color: Colors.white,
                                      child: InkWell(
                                        onTap: () { 
                                          Get.toNamed(ProductScreen.routeName, parameters: {"id": e.productId}, preventDuplicates: false);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(4), 
                                          child: Text(e.name.trim(), 
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontFamily: 'Futura LT',
                                              color: Color(0xFF636363)
                                            ),
                                        ))
                                      ),
                                    )).toList()
                                  ),
                                ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            )
          );
          Overlay.of(context).insert(overlayEntry!);
        } else {
          overlayEntry?.remove();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return  CompositedTransformTarget(
      link: layerLink,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
              ),
              height: 30,
              child: TextField(
                focusNode: focusNode,
                controller: searchController,
                maxLines: 1,
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  widget.onChanged?.call(value);
                },
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    searchController.text = "";
                    overlayEntry?.remove();
                    setState(() {
                      state = SearchResponse(products: []);
                    });
                    lastSearch = value;
                    Get.toNamed(SearchResultScreen.routeName, parameters: {"keyword": value}, preventDuplicates: false);
                  }
                  widget.onSubmitted?.call(value);
                },
                decoration: InputDecoration(
                  isDense: true,
                  hintText: widget.hintText,
                  prefixIcon: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                    ),
                    child: InkWell(
                      onTap: () {
                        final mobileScannerController = MobileScannerController();
                        Get.to(() => Scaffold(
                          appBar: UEAppBar(
                            title: "Scan QRCode",
                            showCart: false,
                            showNotification: false,
                            actions: [
                              InkWell(
                                onTap: () async {
                                  try {
                                    await mobileScannerController.toggleTorch();

                                  } on Exception catch (error) {
                                    // The camera is in use
                                    Get.showSnackbar(const GetSnackBar(
                                      message: "Tidak bisa mengaktif/nonaktifkan flash",
                                      duration: Duration(seconds: 2),
                                    ));
                                  }
                                },
                                child: Image.asset("assets/icon/flash.png", width: 36,),
                              )
                            ],
                          ),
                          body: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned.fill(child: MobileScanner(
                                controller: mobileScannerController,
                                onDetect: (capture) {
                                  final List<Barcode> barcodes = capture.barcodes;
                                  final barcode = barcodes.firstOrNull?.rawValue;
                                  if (barcode != null) {
                                    Get.back(result: barcode);
                                  }
                                  for (final barcode in barcodes) { 
                                    debugPrint('Barcode found! ${barcode.rawValue}');
                                  }
                                },
                              )),
                              Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const Expanded(
                                          flex: 1,
                                          child: SizedBox(),
                                        ),
                                        Expanded(
                                          flex: 10,
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: CustomPaint(
                                              foregroundPainter: BorderPainter(),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: SizedBox(),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF262626).withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(4)
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          FaIcon(FontAwesomeIcons.qrcode, color: Colors.white),
                                          SizedBox(width: 9),
                                          Text("Tempatkan QR Code di dalam frame dan QR\nCode akan terpindai secara otomatis", style: TextStyle(
                                            color: Colors.white,
                                            
                                          ))
                                        ],
                                      ),
                                    )

                                  ],
                                ),
                              )
                            ],
                          ),
                        ))
                        ?.then((barcode) {
                          if (barcode != null) {
                            Future.delayed(const Duration(milliseconds: 800), () {
                              if (int.tryParse(barcode) != null && int.tryParse(barcode)! >= 0) {
                                Get.toNamed(ProductScreen.routeName, parameters: { "id" : barcode }, preventDuplicates: false);
                              } else {
                                final uri = Uri.parse(barcode);
                                Get.toNamed(uri.path, parameters: uri.queryParameters);
                              }
                            });
                          }
                        });
                      },
                      child: Image.asset(
                        'assets/icon/appbar/barcode_scanner.webp',
                      ),
                    ),
                  ),
                  hintStyle: const TextStyle(
                    fontFamily: 'MYRIADPRO',
                    fontSize: 11,
                    color: Color(0xFF636363),
                  ),
                  prefixIconConstraints: const BoxConstraints.tightFor(
                    width: 38,
                    height: 38,
                  ),
                  suffixIcon: showSearchIcon
                      ? const Icon(
                          Icons.search,
                          color: AppColor.primaryColor,
                        )
                      : InkWell(
                          child: const Icon(Icons.close, color: AppColor.primaryColor), // clear text
                          onTap: () {
                            searchController.text = "";
                            focusNode.unfocus();
                            setState(() {
                              state = SearchResponse(products: []);
                            });
                          }
                        ),
                  suffixIconConstraints: const BoxConstraints.tightFor(
                    width: 38,
                    height: 38,
                  ),
                  prefixIconColor: AppColor.grayText,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFe2e2e2),
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFe2e2e2),
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: AppColor.grayText,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


// Creates the white borders
class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const width = 4.0;
    const radius = 4.0;
    const tRadius = 8 * radius;
    final rect = Rect.fromLTWH(
      width,
      width,
      size.width - 2 * width,
      size.height - 2 * width,
    );
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(radius));
    const clippingRect0 = Rect.fromLTWH(
      0,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect1 = Rect.fromLTWH(
      size.width - tRadius,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect2 = Rect.fromLTWH(
      0,
      size.height - tRadius,
      tRadius,
      tRadius,
    );
    final clippingRect3 = Rect.fromLTWH(
      size.width - tRadius,
      size.height - tRadius,
      tRadius,
      tRadius,
    );

    final path = Path()
      ..addRect(clippingRect0)
      ..addRect(clippingRect1)
      ..addRect(clippingRect2)
      ..addRect(clippingRect3);

    canvas.clipPath(path);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = width,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}