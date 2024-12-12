import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/enums.dart';
import 'package:ufo_elektronika/screens/category/category_screen.dart';
import 'package:ufo_elektronika/screens/home/widgets/bestseller/bestseller_list_controller.dart';
import 'package:ufo_elektronika/shared/utils/get_view_keep_alive.dart';
import 'package:ufo_elektronika/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:ufo_elektronika/widgets/tiles/product_tile.dart';


class BestSellerList extends GetViewKeepAlive<BestSellerController> {
  const BestSellerList({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      if (state == null) return const HorizonProductShimmer();
      return Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 7, bottom: 7),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background/bg-yellow.webp'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                /* ---------------------------------- title --------------------------------- */
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 37),
                        child: Text(
                          'Produk Terlaris'.toUpperCase(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'FuturaLT',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(CategoryScreen.routeName, parameters: { "id": "bestseller" }),
                        child: const Text(
                          'Lihat Semua',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'FuturaLT',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /* ------------------------------ product list ------------------------------ */
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 7,
                  ),
                  child: 
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        for (var product in state.products)
                          Row(
                            children: [
                              SizedBox(
                                width: 155,
                                child: NewProducttile(product: product, productTileType: ProductTileType.bestseller,),
                              ),
                              const SizedBox(width: 8)
                            ],
                          )

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ufomen
          Positioned(
            left: 10,
            top: 0,
            child: SizedBox(
              width: 42,
              child: Image.asset('assets/images/ufomen/ufomen-shot.webp'),
            ),
          ),
        ],
      );
    },
    onLoading: const HorizonProductShimmer());
  }
}