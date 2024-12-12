import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/cart/cart_controller.dart';
import 'package:ufo_elektronika/screens/compare_product/compare_product_controller.dart';
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';
import 'package:ufo_elektronika/screens/main/main_controller.dart';
import 'package:ufo_elektronika/screens/main/main_screen.dart';
import 'package:ufo_elektronika/screens/product/product_screen.dart';
import 'package:ufo_elektronika/widgets/appbar/action_bar_widget.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/common/rating_bar.dart';
import 'package:ufo_elektronika/widgets/image.dart';
import 'package:ufo_elektronika/widgets/tiles/product_tile.dart';

class CompareProductScreen extends GetView<CompareProductController> {
  static String routeName = "/compare-product";
  const CompareProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const UEAppBar(
        title: null
      ),
      body: controller.obx((state) {
        if (state == null) return const Center(child: CircularProgressIndicator());
        final itemCount = state.products?.length ?? 0;
        return RefreshIndicator.adaptive(
          onRefresh: () async {
            controller.onInit();
          },
          child: itemCount == 0 ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: Image.asset('assets/icon/ufomen_sad.webp'),
                ),
                const SizedBox(height: 10),
                Text(
                  'Wah, produk perbandingan kamu kosong',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 15),
                FilledButton(
                  onPressed: () {
                    Get.find<MainController>().tabController.index = 0;
                    while (Get.currentRoute != MainScreen.routeName) {
                      Get.back();
                    }
                  },
                  child: const Text('PILIH SEKARANG'),
                ),
              ],
            ),
          ) : ListView.builder(
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final products = state.products ?? [];
              Product product = products[index];

              final attributes = state.attributeGroups?.attributes?.entries;
              final basicAttributes = {
                "DESKRIPSI PRODUK": product.description,
                "MODEL": product.model,
                "BRAND": product.manufacturer,
                "KETERSEDIAAN": product.availability,
                "PENILAIAN": product.reviews
              };
              if (attributes != null) {
                for (var attrGroup in attributes) {
                  for (var attr in attrGroup.value["attribute"].entries) {
                    basicAttributes[attr.value["name"].toString().toUpperCase()] = product.attribute?[attr.key] ?? "";
                  }
                }
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(ProductScreen.routeName, parameters: {"id": product.productId}, preventDuplicates: false);
                  },
                  child: Column(
                    children: [
                      if (index == 0)
                        const Column(
                          children: [
                            Text("BANDINGKAN PRODUK", style: TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.bold, fontSize: 16)),
                            SizedBox(height: 7,)
                          ],
                        ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: UEImage2(product.thumb),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.name.trim().toUpperCase(), 
                                    style: const TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.bold)
                                  ),
                                  Text(product.priceFlashSale ?? product.special ?? product.price, 
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(0xFFFBAA1A)
                                    )
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(product.reviews ?? "", style: const TextStyle(color: Color(0xFFADADAD), fontSize: 11)),
                                        const SizedBox(width: 5),
                                        RatingBar(
                                          rating: product.rating.toDouble(),
                                          size: 22,
                                        ),
                                        const SizedBox(width: 7),
                                        Text(
                                          product.rating.toString(),
                                          style: const TextStyle(
                                            color: Color(0xFFADADAD),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: FilledButton.icon(
                                          style: FilledButton.styleFrom(
                                            backgroundColor: const Color(0xFFFED100),
                                            padding: EdgeInsets.zero
                                          ),
                                          onPressed: () { 
                                            Get.find<CartController>().addToCart(product: product, options: {});
                                          }, 
                                          icon: const FaIcon(FontAwesomeIcons.cartShopping, color: AppColor.primaryColor, size: 18),
                                          label: const Text("KERANJANG", style: TextStyle(color: AppColor.primaryColor))
                                        ),
                                      ),
                                      IconButton.filled(
                                        onPressed: () { 
                                          controller.removeProduct(product);
                                        }, 
                                        style: IconButton.styleFrom(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                          backgroundColor: const Color(0xFFFD4D4D)
                                        ),
                                        icon: const FaIcon(FontAwesomeIcons.trashCan, size: 20)
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      for (var basicAttr in basicAttributes.entries)
                        Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15), 
                                    child: Text(basicAttr.key, 
                                      style: const TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryColor, fontFamily: "FuturaLT"))
                                  ),
                                  const Divider(height: 1),
                                  if (basicAttr.value != null)
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Html(
                                        data: basicAttr.value
                                      ),
                                    )
                                ],
                              ),
                            ),
                            const SizedBox(height: 6)
                          ],
                        ),
                      const SizedBox(height: 6)
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}