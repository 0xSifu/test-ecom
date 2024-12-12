import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/cart/cart_controller.dart';
import 'package:ufo_elektronika/screens/cart/cart_screen.dart';
import 'package:ufo_elektronika/screens/login/login_response.dart';
import 'package:ufo_elektronika/screens/login/login_screen.dart';
import 'package:ufo_elektronika/screens/user/notification/notification_screen.dart';
import 'package:ufo_elektronika/screens/wishlist/wishlist_screen.dart';

class ActionBarWidget extends StatelessWidget {
  const ActionBarWidget({
    super.key,
    this.showNotification = true,
    this.showCart = true,
    this.transparentBackground = false,
  });

  /// show notifivation icon
  final bool showNotification;

  /// show cart icon
  final bool showCart;

  /// transparent background
  final bool transparentBackground;

  @override
  Widget build(BuildContext context) {

    return Transform.translate(
      offset: const Offset(0, -2),
      child: Container(
        margin: const EdgeInsets.only(right: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (showCart)
              Padding(
                padding: const EdgeInsets.only(left: 0, top: 5, bottom: 5, right: 7),
                child: GestureDetector(
                  onTap: () async {
                    if (await LoginResponse.getLoginData(const FlutterSecureStorage()) == null) {
                      Get.toNamed(LoginScreen.routeName)
                      ?.then((value) {
                        if (value == true) {
                          Get.toNamed(CartScreen.routeName);
                        }
                      });
                      return;
                    }
                    Get.toNamed(CartScreen.routeName);
                  },
                  child: Obx(() => Badge(
                      label: Center(
                        child: Text(
                          Get.find<CartController>().totalCartItem.toString(),
                          style: const TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 9
                          ),
                        ),
                      ),
                      backgroundColor: AppColor.yellow,
                      isLabelVisible: Get.find<CartController>().totalCartItem > 0 ? true : false,
                      child: SizedBox(
                        height: 30,
                        child: Image.asset(!transparentBackground
                            ? 'assets/icon/appbar/cart_default.png'
                            : 'assets/icon/appbar/cart_white.png', width: 24, color: transparentBackground ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            if (showNotification)
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 5, bottom: 5),
                child: GestureDetector(
                  onTap: () async {
                    if (await LoginResponse.getLoginData(const FlutterSecureStorage()) == null) {
                      Get.toNamed(LoginScreen.routeName)
                        ?.then((value) {
                          if (value == true) {
                            Get.toNamed(NotificationScreen.routeName);
                          }
                        });
                        return;
                    }
                    Get.toNamed(NotificationScreen.routeName);
                  },
                  child: Badge(
                    label: const Center(
                      child: Text(
                        '2',
                        style: TextStyle(
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                    backgroundColor: AppColor.yellow,
                    isLabelVisible: 0 > 0 ? true : false,
                    child: SizedBox(
                      height: 30,
                      child: Image.asset(!transparentBackground
                          ? 'assets/icon/appbar/bel_default.png'
                          : 'assets/icon/appbar/bel_white.png', width: 24, color: transparentBackground ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
