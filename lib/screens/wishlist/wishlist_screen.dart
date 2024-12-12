import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/cart/cart_controller.dart';
import 'package:ufo_elektronika/screens/main/main_controller.dart';
import 'package:ufo_elektronika/screens/wishlist/wishlist_controller.dart';
import 'package:ufo_elektronika/widgets/appbar/action_bar_widget.dart';
import 'package:ufo_elektronika/screens/home/widgets/recommendation/recomendation_product.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:ufo_elektronika/widgets/tiles/wishlist_tile.dart';
import 'package:visibility_detector/visibility_detector.dart';

class WishlistScreen extends GetView<WishlistController> {
  static const routeName = "/wishlist";
  const WishlistScreen({super.key});

  Widget loadingShimmer() {
    return const Column(
      children: [
        VerticalProductShimmer(),
        SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Obx(() => Scaffold(
      backgroundColor: const Color(0xFFfafafa),
      appBar: const UEAppBar(
        title: 'Wishlist',
        showNotification: false
      ),
      body: VisibilityDetector(
        key: const Key("wishlist"), 
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction >= 0.9) {
            controller.refreshWishlist();
          }
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: controller.wishlist.value == null
          ? loadingShimmer()
          : Column(
              children: [
                const SizedBox(height: 10),
                if (controller.wishlist.value != null && controller.wishlist.value!.products.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 10,
                    ),
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 100,
                          child:
                              Image.asset('assets/icon/ufomen_love.webp'),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Wah, daftar keinginan kamu kosong.',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 15),
                        FilledButton(
                          onPressed: () {
                            Get.find<MainController>().tabController.index = 0;
                            Get.offAllNamed("/main");
                          },
                          child: const Text('Belanja Sekarang'),
                        ),
                      ],
                    ),
                  ),

                /* ------------------------------ wishlist list ----------------------------- */
                if (controller.wishlist.value != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.wishlist.value!.products.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.6,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return WishlistTile(
                          product: controller.wishlist.value!.products[index],
                          onDelete: () { controller.removeFromWishlist(controller.wishlist.value!.products[index].productId); },
                          onATC: () async {
                            await Get.find<CartController>().addToCart(product: controller.wishlist.value!.products[index], options: {});
                          },
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 10),

                /* -------------------------- kemungkinan kamu suka ------------------------- */
                const RecomendationProduct(
                  header: Text(
                    'Kemungkinan Kamu Suka',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
        )
      )
    ));
  }
}
