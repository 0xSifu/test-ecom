
import 'dart:io';
import 'dart:math';

import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/enums.dart';
import 'package:ufo_elektronika/screens/cart/cart_controller.dart';
import 'package:ufo_elektronika/screens/product/entities/product_detail_response.dart';
import 'package:ufo_elektronika/screens/product/product_controller.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:video_player/video_player.dart';
import 'package:ufo_elektronika/widgets/common/flash_sale_timer.dart';
import 'package:ufo_elektronika/widgets/common/modal_bottom_sheet_default.dart';
import 'package:ufo_elektronika/widgets/common/rating_bar.dart';
import 'package:ufo_elektronika/widgets/common/read_more_text.dart';
import 'package:ufo_elektronika/widgets/image.dart';
import 'package:ufo_elektronika/widgets/product_detail/product_images.dart';
import 'package:ufo_elektronika/widgets/product_detail/wishlist_icon.dart';
import 'package:ufo_elektronika/widgets/shimmer/product_detail_shimmer.dart';
import 'package:ufo_elektronika/widgets/tiles/product_tile.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:sizer/sizer.dart' as sizer;

class ProductScreen extends GetView<ProductController> {
  static const routeName = "/product";
  final String productId;
  final String bindingIdentifier; // Used to add another identifier so when binder (GetX) try to initiate controller it will initate diff controller
  const ProductScreen({super.key, required this.productId, required this.bindingIdentifier});
  @override
  String? get tag => "$productId$bindingIdentifier";

  CartController get _cartController => Get.find();

  // add to cart
  void addToCart() async {
    if (!controller.eligibleToAddToCart) return;
    final product = controller.state!;
    
    await _cartController.addToCart(
      product: product.toProduct, 
      options: controller.optionValues, 
      quantity: controller.quantity.value,
      garansiUfo: controller.warrantyChecked.value ? product.garansiPrice : null
    );
  }

  void showSpecBottomSheet(BuildContext context, ProductDetailResponse product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
      ),
      builder: (context) {
        return ModalBottomSheetDefault(
          title: 'Spesifikasi',
          child: (scrollController) => SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  ...product.attributeGroups.map((e) => e.attribute.map((e) => Column(
                    children: [
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              e.name ?? "",
                              style: const TextStyle(
                                fontFamily: "FuturaLT",
                                color: Color(0xFF333333)
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(e.text ?? "", 
                              style: const TextStyle(
                                fontFamily: "FuturaLT",
                                color: Color(0xFF333333)
                              )
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                    ],
                  ))).toList().flattened,
                  const SizedBox(height: 15)
                ]
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final qtyController = TextEditingController()..text = controller.quantity.string;
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: const UEAppBar(title: null),
      body: controller.obx((state) {
        if (state == null) return const ProductDetailShimmer();
        final product = state;
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(color: const Color(0xFFEEEEEE)),
                        borderRadius: BorderRadius.circular(6)
                      ),
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 13),
                      padding: const EdgeInsets.all(7),
                      child: Column(
                        children: [
                                
                          /* --------------------------------- images --------------------------------- */
                          Container(
                            color: Colors.white,
                            child: ProductImages(
                              productImages: product.images.map((e) => e.thumb ?? "").toList(),
                              carouselController: controller.carouselController,
                              onPageChanged: (index, reason) {
                                controller.selectedCarouselIndex.value = index;
                              },
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: product.images.indexed.map<Widget>((e) => Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        controller.carouselController.animateToPage(e.$1);
                                        controller.selectedCarouselIndex.value = e.$1;
                                      },
                                      child: Obx(() {
                                        return Container(
                                          decoration: BoxDecoration(
                                            border: controller.selectedCarouselIndex.value == e.$1 ? Border.all(color: AppColor.primaryColor) : null,
                                            borderRadius: BorderRadius.circular(6)
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(6),
                                            child: UEImage2(e.$2.popup ?? ""),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  const SizedBox(width: 7),
                                ],
                              ),
                            )).toList() + (product.images.length < 5 ? List.generate(4-product.images.length, (e) => 0).map((e) => Expanded(child: Container())).toList() : [Container()]),
                          ),
                          const SizedBox(height: 5),
                          Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /* ---------------------------------- title --------------------------------- */
                                  SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 40),
                                      child: Text(
                                        product.headingTitle ?? "",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: AppColor.primaryColor,
                                          fontFamily: "MYRIADPRO"
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),

                                  
                                  /* ------------------------------ detail produk ----------------------------- */
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        const Text("Kode barang: ", style: TextStyle(color: Color(0xFFADADAD))),
                                        Text(product.sku?.isNotEmpty == true ? "${product.sku}" : "${product.model}", style: const TextStyle(color: Color(0xFFADADAD)))
                                      ]),
                                      Row(children: [
                                        const Text("Reward Points: ", style: TextStyle(color: Color(0xFFADADAD))),
                                        Text("${product.reward}", style: const TextStyle(color: Color(0xFFADADAD)))
                                      ]),
                                    ],
                                  ),

                                  /* --------------------------------- rating --------------------------------- */
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Penilaian (${product.reviews})", style: const TextStyle(color: Color(0xFFADADAD))),
                                      const SizedBox(width: 5),
                                      RatingBar(
                                        rating: product.rating?.toDouble() ?? 0,
                                        size: 22,
                                      ),
                                      // const SizedBox(width: 7),
                                      // Text(
                                      //   "${product.rating != null ? product.rating.toString() : 0}",
                                      //   style: const TextStyle(
                                      //     color: Color(0xFFADADAD),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(product.salesQty ?? "0", style: const TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.bold)),
                                            const SizedBox(width: 3),
                                            const Text("Terjual", style: TextStyle(color: Color(0xFFADADAD))),
                                            const SizedBox(width: 10),
                                            Container(
                                              width: 1,
                                              height: 18,
                                              color: Colors.black12,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(product.stock ?? "0", style: const TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.bold)),
                                            const SizedBox(width: 3),
                                            const Text("Unit Tersisa", style: TextStyle(color: Color(0xFFADADAD))),
                                          ],
                                        ),
                                        const SizedBox(width: 15),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 7),


                                  /* ---------------------------------- Flash sale ---------------------------- */
                                  if (product.flashSaleDate != null)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 7),
                                      child: SizedBox(
                                        height: 60,
                                        child: Stack(
                                          children: [
                                            Positioned.fill(child: Container(
                                              decoration: BoxDecoration(
                                                gradient: const LinearGradient(colors: [
                                                  Color(0xFFE94E0F),
                                                  Color(0xFFFED100)
                                                ]),
                                                borderRadius: BorderRadius.circular(6)
                                              ),
                                            )),
                                            Positioned.fill(child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: Row(
                                                children: [
                                                  Image.asset('assets/icon/flash-sale.webp', width: 100),
                                                  const Spacer(),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Text("Waktu Tersisa", style: TextStyle(color: Colors.white, fontFamily: "Futura LT")),
                                                      FlashSaleTimer(
                                                        seconds: product.flashSaleDate!.second - DateTime.now().second, 
                                                        minutes: product.flashSaleDate!.minute - DateTime.now().minute, 
                                                        hours: product.flashSaleDate!.hour - DateTime.now().hour
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ))
                                          ],
                                        ),
                                      ),
                                    ),

                                  /* ---------------------------------- price --------------------------------- */
                                  Text(
                                    controller.finalPrice,
                                    style: const TextStyle(
                                      color: Color(0xFFfbaa1a),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  if (product.special != null || product.flashSalePrice != null)
                                    Row(
                                      children: [
                                        Text(
                                          product.price ?? "",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Color(0xFFD0D0D0),
                                            decorationColor: Color(0xFFD0D0D0)
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.red.shade100,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            '${product.discSp?.toStringAsFixed(0)}%',
                                            style: TextStyle(
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.fontSize,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red.shade600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (product.hemat != null)
                                    Column(
                                      children: [
                                        const SizedBox(height: 5),
                                        Stack(
                                          children: [
                                            Positioned.fill(child: Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                gradient: LinearGradient(colors: [
                                                  Color(0xFFE94E0F),
                                                  Color(0xFFFED100)
                                                ])
                                              ),
                                            )),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                              child: Text("HEMAT ${product.hemat}", 
                                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                ],
                              ),
                              
                                      
                              Positioned(
                                right: 0,
                                top: -3,
                                child: WishlistIcon(product: product.toProduct),
                              )
                            ],
                          ),
                          const SizedBox(height: 6),
                          Column(
                            children: [

                              /* ------------------------------- Garansi ---------------------------------- */
                              if (product.garansiPrice != null && product.garansiName != null)
                                Column(
                                  children: [
                                    const SizedBox(height: 7),
                                    InkWell(
                                      onTap: () {
                                        controller.warrantyChecked.value = !controller.warrantyChecked.value;
                                    },
                                      child: Row(
                                        children: [
                                          Image.asset("assets/icon/ufo-protection.png", height: 50, width: 50),
                                          Checkbox(
                                            value: controller.warrantyChecked.value == true, 
                                            onChanged: (checked) => controller.warrantyChecked.value = checked == true
                                          ),
                                          const Text("Garansi UFO PRO ", style: TextStyle(color: AppColor.primaryColor, fontSize: 12)),
                                          Text(product.garansiName ?? "", style: const TextStyle(fontSize: 12)),
                                          const Text(" + ", style: TextStyle(fontSize: 12)),
                                          Text("Rp${NumberFormat('#,###').format(product.garansiPrice)}", style: const TextStyle(fontSize: 12)),
                                          const SizedBox(width: 4),
                                          SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              onPressed: () { 
                                                Get.toNamed("https://www.ufoelektronika.com/garansi-ufo-pro");
                                              }, 
                                              icon: const Icon(Icons.info), 
                                              color: AppColor.primaryColor,
                                              iconSize: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              

                              /* ------------------------------- Stock ----------------------------------------- */
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  const Text("Ketersediaan Stok", style: TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.bold, fontSize: 16, fontFamily: "FuturaLT")),
                                  const SizedBox(height: 5),
                                  if (product.stockWarehouse.isEmpty)
                                    Builder(
                                      builder: (context) {
                                        final quantity = int.tryParse(product.qty ?? "0") ?? 0;
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Row(
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Icon(Icons.circle, color: quantity >= 10 ? AppColor.primaryColor : quantity == 0 ? Colors.red : AppColor.primaryColor),
                                                  Icon(Icons.check, color: quantity >= 10 ? AppColor.yellow : quantity == 0 ? Colors.white : AppColor.yellow, size: 14)
                                                ],
                                              ),
                                              const SizedBox(width: 4),
                                              const Expanded(
                                                child: Text("Stok"),
                                              ),
                                              const SizedBox(width: 2),
                                              Text(quantity >= 10 ? "Tersedia" : quantity == 0 ? "Habis" : "Sisa $quantity item", style: TextStyle(color: quantity >= 10 ? AppColor.primaryColor : quantity == 0 ? Colors.grey : Colors.red))
                                            ],
                                          )
                                        );
                                      },
                                    ),
                                  ...product.stockWarehouse.map((e) {
                                    final quantity = int.tryParse(e.quantity ?? "0") ?? 0;
                                      return InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Row(
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Icon(Icons.circle, color: quantity >= 10 ? AppColor.yellow : quantity == 0 ? Colors.red : AppColor.primaryColor),
                                                  Icon(Icons.check, color: quantity >= 10 ? AppColor.primaryColor : quantity == 0 ? Colors.white : AppColor.yellow, size: 20)
                                                ],
                                              ),
                                              const SizedBox(width: 2),
                                              Expanded(
                                                child: Text(e.name ?? ""),
                                              ),
                                              const SizedBox(width: 2),
                                              Text(quantity >= 10 ? "Tersedia" : quantity == 0 ? "Habis" : "Sisa $quantity item", style: TextStyle(color: quantity >= 10 ? AppColor.primaryColor : quantity == 0 ? Colors.grey : Colors.red))
                                            ],
                                          )
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),

                              /* -------------------------------------- Options ------------------------------ */
                              Column(
                                children: [
                                  
                                  ...product.options.map((productOption) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 7, key: controller.optionValueKeys[productOption]),
                                        Text(productOption.name ?? ""),
                                        Stack(
                                          alignment: Alignment.centerLeft,
                                          children: [
                                            Transform.scale(scaleY: 0.9, child: DropdownButtonFormField(
                                              isExpanded: true,
                                              isDense: true,
                                              padding: EdgeInsets.zero,
                                              itemHeight: kMinInteractiveDimension,
                                              value: controller.optionValues[productOption],
                                              decoration: const InputDecoration(
                                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFEEEEEE)), gapPadding: 0),
                                                border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFEEEEEE)), gapPadding: 0),
                                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFEEEEEE)), gapPadding: 0),
                                                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                              ),
                                              items: productOption.productOptionValue.map((e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(e.name ?? ""),
                                              )).toList(), 
                                              onChanged: (selectedOptionValue) {
                                                if (selectedOptionValue != null) {
                                                  controller.optionValues[productOption] = selectedOptionValue;
                                                }
                                            })),
                                            if (controller.optionValues[productOption] == null)
                                              const Padding(
                                                padding: EdgeInsets.only(left: 13),
                                                child: Text("Pilih"),
                                              )
                                          ],
                                        ),
                                        if (controller.optionValueErrors[productOption] != null)
                                          Text(controller.optionValueErrors[productOption]!, style: const TextStyle(color: Colors.red))
                                      ],
                                    );
                                  }),
                                ],
                              ),


                              /* ----------------------------------- Total Quantity ---------------------------- */
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  const Text("Jumlah"),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(border: Border.all(color: const Color(0xFFEEEEEE))),
                                        child: SizedBox(
                                          width: 30,
                                          height: 40,
                                          child: Material(
                                            child: InkWell(
                                              onTap: () { 
                                                controller.quantity.value = max(controller.quantity.value - 1, 1);
                                                qtyController.text = controller.quantity.string;
                                              }, 
                                              child: const Icon(Icons.remove, color: AppColor.primaryColor)
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: const BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: Color(0xFFEEEEEE)))),
                                          child: TextField(
                                            textAlign: TextAlign.center,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                                              isDense: true
                                            ),
                                            controller: qtyController,
                                            keyboardType: TextInputType.number,
                                            onChanged: (text) {
                                              controller.quantity.value = int.tryParse(text) ?? 1;
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(border: Border.all(color: const Color(0xFFEEEEEE))),
                                        child: SizedBox(
                                          width: 30,
                                          height: 40,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                final stock = int.tryParse(product.stock ?? "");
                                                if (stock != null) {
                                                  controller.quantity.value = min(stock, controller.quantity.value + 1);
                                                } else {
                                                  controller.quantity.value = controller.quantity.value + 1;
                                                }
                                                qtyController.text = controller.quantity.string;
                                              }, 
                                              child: const Icon(Icons.add, color: AppColor.primaryColor)
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  if (controller.quantity.value > (int.tryParse(product.stock ?? "") ?? 0))
                                    const Text("Stok tidak mencukupi", style: TextStyle(color: Colors.red, fontSize: 12))
                                ],
                              ),
                              
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 7),
                    
                    /* ------------------------------ Spesifikasi ----------------------------- */
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(color: const Color(0xFFEEEEEE)),
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15, top: 9, bottom: 9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'SPESIFIKASI',
                                    style: TextStyle(
                                      fontFamily: "FuturaLT",
                                      fontSize: 16,
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold
                                    )
                                ),
                                GestureDetector(
                                  onTap: () => showSpecBottomSheet(context, product),
                                  child: const Row(
                                    children: [
                                      Text(
                                        'Lihat Semua',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.primaryColor,
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: AppColor.primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 7),
                    
                    
                    /* ------------------------------ detail produk ----------------------------- */
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(color: const Color(0xFFEEEEEE)),
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 15, right: 15, top: 9, bottom: 0),
                            child: Text(
                              'DESKRIPSI PRODUK',
                              style: TextStyle(
                                fontFamily: "FuturaLT",
                                fontSize: 16,
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ),
                          const Divider(color: Color(0xFFEFEFEF),),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ReadMoreText(text: product.description ?? ''),
                          ),
                          const SizedBox(height: 7),
                        ],
                      ),
                    ),

                    /* ------------------------------ Video produk ----------------------------- */
                    if (product.video?.isNotEmpty == true && controller.youtubePlayerController != null)
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            YoutubePlayer(
                              controller: controller.youtubePlayerController!,
                              showVideoProgressIndicator: false,
                              onReady: () {

                              },
                            ),
                            // AspectRatio(
                            //   aspectRatio: controller.videoAspectRatio.value,
                            //   child: VideoPlayer(controller.videoPlayerController),
                            // )
                          ],
                        ),
                      ),

                    /* ---------------------------- penilaian produk ---------------------------- */
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(color: const Color(0xFFEEEEEE)),
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'PENILAIAN PRODUK',
                                    style: TextStyle(
                                      fontFamily: "FuturaLT",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primaryColor
                                    )
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text('Penilaian (${product.reviews})'),
                                      const SizedBox(width: 10),
                                      RatingBar(
                                        rating: product.rating?.toDouble() ?? 0,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                  if (product.listReview.isNotEmpty)
                                  const Divider(color: Color(0xFFEFEFEF),)
                                ],
                              ),
                              // if (product.listReview1.isNotEmpty || product.listReview2.isNotEmpty || product.listReview3.isNotEmpty || product.listReview4.isNotEmpty || product.listReview5.isNotEmpty)
                              //   GestureDetector(
                              //     onTap: () => context
                              //         .push("/product/${widget.url}/review"),
                              //     child: const Row(
                              //       children: [
                              //         Text(
                              //           'Lihat Semua',
                              //           style: TextStyle(
                              //             fontSize: 14,
                              //             fontWeight: FontWeight.bold,
                              //             color: AppColor.primaryColor,
                              //           ),
                              //         ),
                              //         Icon(
                              //           Icons.chevron_right,
                              //           color: AppColor.primaryColor,
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                            ],
                          ),
                          if (product.listReview.isNotEmpty)
                            /* -------------------------------- penilaian ------------------------------- */
                            productReviews(product),
                          // const ProducctReview(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 7),

                    // Related Products  
                    const Text(
                      'PRODUK TERKAIT',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "FuturaLT",
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 10,
                      ),
                      child: Builder(
                        builder: (context) {
                          final productNoOfColumn = sizer.Device.screenType == sizer.ScreenType.tablet ? (sizer.Device.safeWidth / 200).ceil() : 2;
                          return Column(
                            children: [
                              for (var row = 0; row < (product.productsRelated.length ~/ productNoOfColumn); row++)
                                Column(
                                  children: [
                                    Builder(
                                      builder: (context) {
                                        final rowWidget = Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [],
                                        );

                                        for (var col = 0; col < productNoOfColumn; col++) {
                                          if (product.productsRelated.length > row*productNoOfColumn+col) {
                                            rowWidget.children.add(Expanded(child: NewProducttile(product: product.productsRelated[row*productNoOfColumn+col])));
                                          } else {
                                            rowWidget.children.add(Expanded(child: Container()));
                                          }
                                          rowWidget.children.add(const SizedBox(width: 7));
                                        }

                                        return rowWidget;
                                      },
                                    ),
                                    const SizedBox(height: 7),
                                  ],
                                )
                            ],
                          );
                        },
                      )
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3), //color of shadow
                    spreadRadius: 2, //spread radius
                    blurRadius: 8, // blur radius
                    offset: const Offset(0, 2), // changes position of shadow
                    //first paramerter of offset is left-right
                    //second parameter is top to down
                  ),
                  //you can set more BoxShadow() here
                ],
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                            ),
                          ),
                          onPressed: controller.addToCompareProduct,
                          child: Image.asset("assets/icon/compare-product.png", width: 18,),
                        ),
                      ),
                      const SizedBox(width: 6),
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                            ),
                          ),
                          onPressed: () {
                            AppinioSocialShare appinioSocialShare = AppinioSocialShare();
                            showModalBottomSheet(
                              context: context, 
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero
                              ),
                              builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.symmetric(horizontal: BorderSide(color: const Color(0xFF636363).withOpacity(0.2)))
                                ),
                                child: Wrap(
                                  children: [
                                    SizedBox(
                                      child: SafeArea(
                                        child: Container(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 45,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(25),
                                                            color: AppColor.yellow
                                                          ),
                                                          width: 43,
                                                          height: 43,
                                                          child: IconButton(
                                                            onPressed: () async {
                                                              Navigator.pop(context);
                                                              try {
                                                                final apps = await appinioSocialShare.getInstalledApps();
                                                                if (apps["facebook"] == true) {
                                                                  if (Platform.isAndroid) await appinioSocialShare.android.shareToFacebook(product.share ?? "", []);
                                                                  if (Platform.isIOS) await appinioSocialShare.iOS.shareToFacebook(product.share ?? "", []);
                                                                } else {
                                                                  Get.showSnackbar(const GetSnackBar(
                                                                    message: "Silakan install Facebook terlebih dahulu",
                                                                    duration: Duration(seconds: 2),
                                                                  ));
                                                                }
                                                              } catch (error) {
                                                                Get.showSnackbar(GetSnackBar(
                                                                  message: error.toString(),
                                                                  duration: const Duration(seconds: 2),
                                                                ));
                                                              }

                                                            }, 
                                                            icon: const FaIcon(FontAwesomeIcons.facebookF, color: AppColor.primaryColor, size: 24),
                                                            color: AppColor.yellow,
                                                          ),
                                                        ),
                                                        const Text("Facebook", style: TextStyle(color: Color(0xFF636363), fontSize: 9))
                                                      ],
                                                    )
                                                  ),
                                                  SizedBox(
                                                    width: 45,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(25),
                                                            color: AppColor.yellow
                                                          ),
                                                          width: 43,
                                                          height: 43,
                                                          child: IconButton(onPressed: () async {
                                                            Navigator.pop(context);
                                                            try {
                                                              final apps = await appinioSocialShare.getInstalledApps();
                                                              if (apps["whatsapp"] == true) {
                                                                if (Platform.isAndroid) await appinioSocialShare.android.shareToWhatsapp(product.share ?? "", null);
                                                                if (Platform.isIOS) await appinioSocialShare.iOS.shareToWhatsapp(product.share ?? "");
                                                              } else {
                                                                Get.showSnackbar(const GetSnackBar(
                                                                  message: "Silakan install Whatsapp terlebih dahulu",
                                                                  duration: Duration(seconds: 2),
                                                                ));
                                                              }
                                                            } catch (error) {
                                                              Get.showSnackbar(GetSnackBar(
                                                                message: error.toString(),
                                                                duration: const Duration(seconds: 2),
                                                              ));
                                                            }
                                                          }, icon: const FaIcon(FontAwesomeIcons.whatsapp, color: AppColor.primaryColor, size: 26)),
                                                        ),
                                                        const Text("Whatsapp", style: TextStyle(color: Color(0xFF636363), fontSize: 9))
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 45,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(25),
                                                            color: AppColor.yellow
                                                          ),
                                                          width: 43,
                                                          height: 43,
                                                          child: IconButton(onPressed: () async {
                                                            Navigator.pop(context);
                                                            try {
                                                              final apps = await appinioSocialShare.getInstalledApps();
                                                              if (apps["telegram"] == true) {
                                                                if (Platform.isAndroid) await appinioSocialShare.android.shareToTelegram(product.share ?? "", null);
                                                                if (Platform.isIOS) await appinioSocialShare.iOS.shareToTelegram(product.share ?? "");
                                                              } else {
                                                                Get.showSnackbar(const GetSnackBar(
                                                                  message: "Silakan install Telegram terlebih dahulu",
                                                                  duration: Duration(seconds: 2),
                                                                ));
                                                              }
                                                            } catch (error) {
                                                              Get.showSnackbar(GetSnackBar(
                                                                message: error.toString(),
                                                                duration: const Duration(seconds: 2),
                                                              ));
                                                            }
                                                          }, icon: const FaIcon(FontAwesomeIcons.telegram, color: AppColor.primaryColor, size: 26))
                                                        ),
                                                        const Text("Telegram", style: TextStyle(color: Color(0xFF636363), fontSize: 9))
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 45,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(25),
                                                            color: AppColor.yellow
                                                          ),
                                                          width: 43,
                                                          height: 43,
                                                          child: IconButton(onPressed: () async {
                                                            Navigator.pop(context);
                                                            try {
                                                              final apps = await appinioSocialShare.getInstalledApps();
                                                              if (apps["messenger"] == true) {
                                                                if (Platform.isAndroid) await appinioSocialShare.android.shareToMessenger(product.share ?? "");
                                                                if (Platform.isIOS)  await appinioSocialShare.iOS.shareToMessenger(product.share ?? "");
                                                              } else {
                                                                Get.showSnackbar(const GetSnackBar(
                                                                  message: "Silakan install Messenger terlebih dahulu",
                                                                  duration: Duration(seconds: 2),
                                                                ));
                                                              }
                                                            } catch (error) {
                                                              Get.showSnackbar(GetSnackBar(
                                                                message: error.toString(),
                                                                duration: const Duration(seconds: 2),
                                                              ));
                                                            }
                                                          }, icon: const FaIcon(FontAwesomeIcons.facebookMessenger, color: AppColor.primaryColor, size: 26))
                                                        ),
                                                        const Text("Messenger", style: TextStyle(color: Color(0xFF636363), fontSize: 9))
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 45,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(25),
                                                            color: AppColor.yellow
                                                          ),
                                                          width: 43,
                                                          height: 43,
                                                          child: IconButton(onPressed: () async {
                                                            Navigator.pop(context);
                                                            final Email email = Email(
                                                              body: product.share ?? "",
                                                              isHTML: false,
                                                            );

                                                            await FlutterEmailSender.send(email);
                                                          }, icon: const Icon(Icons.mail, color: AppColor.primaryColor, size: 26))
                                                        ),
                                                        const Text("Email", style: TextStyle(color: Color(0xFF636363), fontSize: 9))
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 45,
                                                    height: 70,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(25),
                                                            color: AppColor.yellow
                                                          ),
                                                          width: 43,
                                                          height: 43,
                                                          child: IconButton(onPressed: () async {
                                                            Navigator.pop(context);
                                                            await Clipboard.setData(ClipboardData(text: product.share ?? ""));
                                                            Get.showSnackbar(const GetSnackBar(
                                                              message: "Berhasil menyalin tautan",
                                                              duration: Duration(seconds: 2),
                                                            ));
                                                            // copied successfully
                                                          }, icon: const FaIcon(FontAwesomeIcons.link, color: AppColor.primaryColor, size: 23))
                                                        ),
                                                        const Text("Salin Tautan", textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF636363), fontSize: 9))
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 45,
                                                    height: 70,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(25),
                                                            color: AppColor.yellow
                                                          ),
                                                          width: 43,
                                                          height: 43,
                                                          child: IconButton(onPressed: () async {
                                                            Navigator.pop(context);
                                                            if (Platform.isAndroid) await appinioSocialShare.android.shareToSystem(product.share ?? "", product.share ?? "", null);
                                                            if (Platform.isIOS) await appinioSocialShare.iOS.shareToSystem(product.share ?? "");
                                                          }, icon: const FaIcon(FontAwesomeIcons.ellipsis, color: AppColor.primaryColor, size: 26))
                                                        ),
                                                        const Text("Lainnya", style: TextStyle(color: Color(0xFF636363), fontSize: 9))
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 45),
                                                  const SizedBox(width: 45),
                                                  const SizedBox(width: 45),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                          },
                          child: Image.asset("assets/icon/share.png", width: 18,),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              padding: EdgeInsets.zero
                            ),
                            onPressed: (product.realStock ?? 0) == 0 ? null : () {
                              
                              if (!controller.eligibleToAddToCart) return;
                              _cartController.addToCart(
                                product: product.toProduct, 
                                options: controller.optionValues, 
                                quantity: controller.quantity.value,
                                garansiUfo: controller.warrantyChecked.value ? product.garansiPrice : null,
                                isBuyNow: true
                              );
                            },
                            child: const Text(
                              'BELI SEKARANG',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: FilledButton.icon(
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFFFED100),
                              padding: EdgeInsets.zero
                            ),
                            onPressed: (product.realStock ?? 0) == 0 ? null : addToCart,
                            icon: const FaIcon(FontAwesomeIcons.cartPlus, size: 18, color: AppColor.primaryColor),
                            label: const Text(
                              'KERANJANG',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryColor
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
      onLoading: const ProductDetailShimmer()
      )
    );
  }

  String formatTimeDifference(DateTime date) {
    Duration difference = DateTime.now().difference(date);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} detik lalu';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam lalu';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} hari lalu';
    } else if (difference.inDays < 365) {
      final months = difference.inDays ~/ 30;
      return '$months bulan lalu';
    } else {
      final years = difference.inDays ~/ 365;
      return '$years tahun lalu';
    }
  }

  Widget productReview(ListReview review) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.author ?? "",
                  style: const TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.bold, fontSize: 13),
                ),
                // const Text('7 terbantu')
              ],
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            RatingBar(
              rating: review.rating ?? 0,
              size: 18,
            ),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 3),
        Text(formatTimeDifference(review.dateAdded ?? DateTime.now())),
        const SizedBox(height: 3),
        Row(
          children: [
            for (var image in [review.reviewImage, review.image, review.image1, review.image2])
              if (image != null && image.isNotEmpty && image.contains("http"))
                Image.network(image, width: 80, height: 80)
          ],
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            for (var video in [review.reviewVideo, review.video1, review.video2])
              if (video != null && video.isNotEmpty && video.contains("http"))
                Builder(
                  builder: (context) {
                    final controller = VideoPlayerController.networkUrl(Uri.parse(video));
                    bool isInitialized = false;
                    
                    return StatefulBuilder(
                      builder: (context, setState) {
                        if (!isInitialized) {
                          isInitialized = true;
                          controller.initialize().then((_) {
                            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                            setState(() {});
                          });
                        }
                        return SizedBox(
                          width: 100,
                          height: 80,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Center(
                                  child: AspectRatio(
                                    aspectRatio: controller.value.aspectRatio,
                                    child: VideoPlayer(controller),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        controller.value.isPlaying
                                            ? controller.pause()
                                            : controller.play();
                                      });
                                    }, 
                                    icon: Icon(
                                      controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                    )
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                )
          ],
        ),
        Text(
          review.text ?? "",
        ),

        /* ------------------------------ review images ----------------------------- */
        // Padding(
        //   padding: const EdgeInsets.only(top: 15),
        //   child: Row(
        //     children: [
        //       for (String reviewImage in reviewImages)
        //         GestureDetector(
        //           onTap: () => showImagePopup(context),
        //           child: Padding(
        //             padding: const EdgeInsets.only(right: 10),
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.circular(5),
        //               child: SizedBox(
        //                 width: 40,
        //                 height: 50,
        //                 child: UEImage2(
        //                   reviewImage,
        //                   fit: BoxFit.cover,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //     ],
        //   ),
        // ),

        /* ---------------------------------- reply --------------------------------- */
        // Column(
        //   children: [
        //     const SizedBox(height: 15),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       children: [
        //         GestureDetector(
        //           onTap: () => setState(() {
        //             _replyCollapsed = !_replyCollapsed;
        //           }),
        //           child: Row(
        //             children: [
        //               Text(!_replyCollapsed
        //                   ? 'Tutup Balasan'
        //                   : 'Lihat Balasan'),
        //               Icon(!_replyCollapsed
        //                   ? Icons.expand_less
        //                   : Icons.expand_more),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //     if (!_replyCollapsed)
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           /* --------------------------------- dummy 1 -------------------------------- */
        //           Container(
        //             margin: const EdgeInsets.only(top: 10),
        //             padding: const EdgeInsets.only(
        //               left: 15,
        //               top: 10,
        //               bottom: 10,
        //             ),
        //             decoration: const BoxDecoration(
        //               border: Border(
        //                 left: BorderSide(
        //                   color: Colors.black12,
        //                   style: BorderStyle.solid,
        //                 ),
        //               ),
        //             ),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Row(
        //                   children: [
        //                     Text(
        //                       'Ufoelektronika',
        //                       style: Theme.of(context).textTheme.titleSmall,
        //                     ),
        //                     const SizedBox(width: 5),
        //                     Container(
        //                       padding: const EdgeInsets.symmetric(
        //                         vertical: 2,
        //                         horizontal: 5,
        //                       ),
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(5),
        //                         color: AppColor.primaryColor,
        //                       ),
        //                       child: const Text(
        //                         'Pejual',
        //                         style: TextStyle(
        //                           fontSize: 12,
        //                           fontWeight: FontWeight.bold,
        //                           color: Colors.white,
        //                         ),
        //                       ),
        //                     ),
        //                     const SizedBox(width: 5),
        //                     const Text('1 bulan lalu'),
        //                   ],
        //                 ),
        //                 const SizedBox(height: 10),
        //                 const Text(
        //                     'Terima kasih telah berbelanja di Ufoelektronika'),
        //               ],
        //             ),
        //           ),

        //           /* --------------------------------- dummy 2 -------------------------------- */
        //           Container(
        //             margin: const EdgeInsets.only(top: 10),
        //             padding: const EdgeInsets.only(
        //               left: 15,
        //               top: 10,
        //               bottom: 10,
        //             ),
        //             decoration: const BoxDecoration(
        //               border: Border(
        //                 left: BorderSide(
        //                   color: Colors.black12,
        //                   style: BorderStyle.solid,
        //                 ),
        //               ),
        //             ),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Row(
        //                   children: [
        //                     Text(
        //                       'Rachel',
        //                       style: Theme.of(context).textTheme.titleSmall,
        //                     ),
        //                     const SizedBox(width: 5),
        //                     const Text('1 bulan lalu'),
        //                   ],
        //                 ),
        //                 const SizedBox(height: 10),
        //                 const Text('Sy akan beli lagi'),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //   ],
        // ),
      ],
    ),
  );

  Widget productReviews(ProductDetailResponse product) => Column(
    children: [
      ...product.listReview.map((e) => productReview(e))
    ],
  );

  Future<String> copyImage(String filename) async {
    final tempDir = await getTemporaryDirectory();
    ByteData bytes = await rootBundle.load("assets/icon/$filename");
    final assetPath = '${tempDir.path}/$filename';
    File file = await File(assetPath).create();
    await file.writeAsBytes(bytes.buffer.asUint8List());
    return file.path;
  }
}
