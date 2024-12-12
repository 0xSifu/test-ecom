import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/enums.dart';
import 'package:ufo_elektronika/screens/category/category_screen.dart';
import 'package:ufo_elektronika/screens/home/widgets/flash_sale/flash_sale_controller.dart';
import 'package:ufo_elektronika/shared/utils/get_view_keep_alive.dart';
import 'package:ufo_elektronika/widgets/common/flash_sale_timer.dart';
import 'package:ufo_elektronika/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:ufo_elektronika/widgets/tiles/product_tile.dart';
import 'package:sizer/sizer.dart' as sizer;

class FlashSaleList extends GetViewKeepAlive<FlashSaleController> {
  const FlashSaleList({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      if (state == null) return const HorizonProductShimmer();
      if (state.flashSale.isEmpty) {
        return const SizedBox(height: 0);
      }
      return Container(
        padding: const EdgeInsets.only(bottom: 6),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('assets/images/background/bg-blue-sky.webp'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 24,
                        alignment: Alignment.topLeft,
                        child:
                            Image.asset('assets/icon/flash-sale.webp'),
                      ),

                      const SizedBox(width: 15),

                      // countdown
                      FlashSaleTimer(
                        hours: (state.flashSaleDate?.hour ?? 0) - DateTime.now().hour,
                        minutes: (state.flashSaleDate?.minute ?? 0) - DateTime.now().minute,
                        seconds: (state.flashSaleDate?.second ?? 0) - DateTime.now().second,
                        onCountdownEnd: () => {
                          
                        },
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(CategoryScreen.routeName, parameters: {"id": "flash_sale"}),
                    child: const Text(
                      'Lihat Semua',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'FuturaLT',
                        color: Color(0xFF636363),
                      ),
                    ),
                  )
                ],
              ),
            ),

            // products
            Padding(
              padding: const EdgeInsets.only(
                bottom: 3,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 10),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var product in state.flashSale)
                      Row(
                        children: [
                          SizedBox(
                            width: 155,
                            child: NewProducttile(
                              product: product,
                              productTileType: ProductTileType.flashSale,
                            ),
                          ),
                          const SizedBox(width: 8)
                        ],
                      )
                  ],
                ),
              )
            ),
          ],
        ),
      );
    });
  }
}