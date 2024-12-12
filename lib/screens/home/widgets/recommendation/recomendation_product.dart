import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/home/widgets/recommendation/recommendation_controller.dart';
import 'package:ufo_elektronika/widgets/common/product_list.dart';
import 'package:ufo_elektronika/widgets/shimmer/vertical_product_shimmer.dart';


class RecomendationProduct extends GetView<RecommendationController> {
  const RecomendationProduct({
    super.key,
    this.header,
    this.headerHeight = 40,
    this.showButton = false,
  });

  /// header
  final Widget? header;

  /// header height
  final double headerHeight;

  /// show show more product
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => Stack(
      children: [
        if (header != null)
          Positioned(
            child: Container(
              height: 50,
              padding: const EdgeInsets.all(7),
              decoration: const BoxDecoration(
                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [
                //     Colors.white, // Top color with 80% opacity
                //     Color.fromRGBO(255, 255, 255,
                //         0), // Bottom color with 20% opacity
                //   ],
                // ),
              ),
              alignment: Alignment.topCenter,
              child: header,
            ),
          ),
        Padding(
          padding: EdgeInsets.only(
              top: header != null ? headerHeight : 0),
          child: Column(
            children: [
              ProductList(
                products: state?.products ?? [],
              ),
              if (showButton == true)
                Column(
                  children: [
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: FilledButton(
                          onPressed: () =>
                              Get.toNamed('/category/recomended'),
                          child: const Text(
                            'Lihat Selengkapnya',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
            ],
          ),
        ),
      ],
    ),
    onLoading: const VerticalProductShimmer());
  }
}
