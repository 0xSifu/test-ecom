import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';
import 'package:ufo_elektronika/screens/wishlist/wishlist_controller.dart';
import 'package:ufo_elektronika/screens/wishlist/wishlist_screen.dart';

class WishlistIcon extends GetView<WishlistController> {
  const WishlistIcon({super.key, required this.product});

  /// data product
  final Product product;


  void addToWishlist(Product product, BuildContext context) async {
    // Hide the current snackbar before showing a new one
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (await controller.checkWIshlist(product.productId)) {
      if (await controller.removeFromWishlist(product.productId) == false) {
        return;
      }

      // show snack bar notification
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Barang telah dihapus dari wishlist.',
          duration: Duration(seconds: 2),
        )
      );
    } else {
      if (await controller.addToWishlist(product.productId) == false) {
        return;
      }

      // show snack bar notification
      Get.showSnackbar(
        GetSnackBar(
          message: 'Berhasil ditambahkan ke wishlist!',
          duration: const Duration(seconds: 2),
          mainButton: TextButton(onPressed: () { 
            Get.toNamed(WishlistScreen.routeName);
          }, child: const Text("Lihat")),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => addToWishlist(product, context),
      child: Obx(() {
        final wishlisted = controller.wishlist.value?.products.firstWhereOrNull((element) => element.productId == product.productId) != null;
        return wishlisted ? Stack(
            clipBehavior: Clip.none,
            children: [
              const SizedBox(
                width: 30,
                height: 30,
              ),
              Positioned(
                top: -20,
                left: -20,
                child: Lottie.asset(
                  'assets/lottie/icon/love.json',
                  repeat: false,
                  width: 70,
                  height: 70,
                ),
              ),
            ],
          )
          : const Icon(
              Icons.favorite_outline,
              size: 30,
            );
      }),
    );
  }
}
