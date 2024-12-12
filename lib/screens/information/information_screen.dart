import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart' as sizer;
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';
import 'package:ufo_elektronika/screens/information/information_controller.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/image.dart';
import 'package:ufo_elektronika/widgets/tiles/product_tile.dart';
import 'package:visibility_detector/visibility_detector.dart';

class InformationScreen extends GetView<InformationController> {
  static const routeName = "/information";

  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productNoOfColumn = sizer.Device.screenType == sizer.ScreenType.tablet ? (sizer.Device.safeWidth / 200).ceil() : 2;
    return Scaffold(
      appBar: UEAppBar(
        title: null,
        titleWidget: Obx(() {
          return Text(controller.response.value?.headingTitle ?? "");
        }),
        showCart: false, 
        showNotification: false
      ),
      body: Obx(() {
        final response = controller.response.value;
        if (response == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final itemCount = 2 + ((controller.products.length) ~/ productNoOfColumn) + (controller.canLoadMore.value ? 1 : 0);
        return ListView.builder(
          itemCount: itemCount,
          itemBuilder: (context, index) {
            
            if (index == 0) {
              // return Text(response.description ?? "");
              // final width = MediaQuery.sizeOf(context).width;
              // double initialWebViewHeight = 1;
              // bool hasSetupWebView = false;
              // final webviewController = WebViewController();
              // webviewController.setJavaScriptMode(JavaScriptMode.unrestricted);
              // // webviewController.enableZoom(false);
              // return StatefulBuilder(builder: (context, setState) {
              //   if (hasSetupWebView == false) {
              //     hasSetupWebView = true;
              //     webviewController.setNavigationDelegate(NavigationDelegate(
              //       onPageFinished: (url) async {
              //         await webviewController.runJavaScript("""
              //         var flutterViewPort=document.createElement('meta');
              //         flutterViewPort.name = "viewport";
              //         flutterViewPort.content = "width=$width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0";
              //         document.getElementsByTagName('head')[0].appendChild(flutterViewPort);
              //         """);
              //         final height = double.tryParse((await webviewController.runJavaScriptReturningResult(
              //             'document.documentElement.scrollHeight;')).toString());
                      
              //         if (initialWebViewHeight != height && height != null) {
              //           print("New Height $height with width $width");
              //           setState(() {
              //             initialWebViewHeight = height;
              //           });
              //         }
              //       },
              //     ));
              //     webviewController.loadHtmlString(response.description ?? "");
              //   }
              //   return SizedBox(
              //     height: initialWebViewHeight,
              //     width: width,
              //     child: WebViewWidget(
              //       controller: webviewController,
              //     ),
              //   ); 
              // });
              return Html(data: response.description, shrinkWrap: true, style: {
                "img": Style(
                  width: Width(MediaQuery.of(context).size.width - 20)
                )
              });
            }
            else if (index == 1) {
              if (response.banner?.isNotEmpty == true) {
                return UEImage2(response.banner!);
              }
              return Container();
            } else if (controller.canLoadMore.value && index == itemCount - 1) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Center(child: CircularProgressIndicator()),
              );
            } else {

              final recommendationProducts = controller.products;
              int currentRow = (index - 2) * productNoOfColumn;
              final row = Row(
                children: [
                  const SizedBox(width: 15)
                ],
              );

              for (var col = 0; col < productNoOfColumn; col++) {
                if (recommendationProducts.length > currentRow + col) {
                  final product = recommendationProducts[currentRow + col];
                  row.children.add(Expanded(child: VisibilityDetector(
                    key: Key(product.productId), 
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction >= 1 && currentRow + 2 >= recommendationProducts.length) {
                        controller.loadMoreProduct();
                      }
                    },
                    child: NewProducttile(product: product)))
                  );
                } else {
                  row.children.add(Expanded(child: Container()));
                }
                row.children.add(const SizedBox(width: 15));
              }
              return Padding(padding: const EdgeInsets.symmetric(vertical: 7.5), child: row);
            }
          },
        );
      }),
    );
  }
}