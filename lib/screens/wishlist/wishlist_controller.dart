import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/login/login_response.dart';
import 'package:ufo_elektronika/screens/login/login_screen.dart';
import 'package:ufo_elektronika/screens/wishlist/wishlist_repository.dart';
import 'package:ufo_elektronika/screens/wishlist/wishlist_response.dart';

class WishlistController extends GetxController {
  final WishlistRepository _repository;
  final FlutterSecureStorage _secureStorage;
  WishlistController({required WishlistRepository repository, required FlutterSecureStorage secureStorage}): _repository = repository, _secureStorage = secureStorage;

  final wishlist = Rx<WishlistResponse?>(null);

  @override
  void onInit() {
    super.onInit();
    refreshWishlist();
  }

  void refreshWishlist() async {
    if (await LoginResponse.getLoginData(_secureStorage) == null) {
      return;
    }
    _repository.getWishlist()
      .then((value) {
        wishlist.value = value;
      })
      .catchError((error) {
        Get.showSnackbar(GetSnackBar(
          message: error is DioException ? error.response?.data["error"] : error.toString(),
          duration: const Duration(seconds: 2),
        ));
      });
  }

  Future<bool> addToWishlist(String productId) async {
    if (await LoginResponse.getLoginData(_secureStorage) == null) {
      final value = await Get.toNamed(LoginScreen.routeName);
      if (value == true) {
        return await addToWishlist(productId);
      }
      return false;
    }
    return _repository.addWishlist(productId)
      .then((value) {
        Get.showSnackbar(const GetSnackBar(
          message: "Barang telah ditambahkan ke wishlist",
          duration: Duration(seconds: 2),
        ));
        return _repository.getWishlist();
      })
      .then((value) {
        wishlist.value = value;
        return true;
      })
      .catchError((error) {
        Get.showSnackbar(GetSnackBar(
          message: error is DioException ? error.response?.data["error"] : error.toString(),
          duration: const Duration(seconds: 2),
        ));
        return false;
      });
  }

  Future<bool> removeFromWishlist(String productId) async {
    return _repository.removeWishlist(productId)
      .then((value) {
        Get.showSnackbar(const GetSnackBar(
          message: "Barang telah dihapus dari wishlist",
          duration: Duration(seconds: 2),
        ));
        return _repository.getWishlist();
      })
      .then((value) {
        wishlist.value = value;
        return true;
      })
      .catchError((error) {
        Get.showSnackbar(GetSnackBar(
          message: error is DioException ? error.response?.data["error"] : error.toString(),
          duration: const Duration(seconds: 2),
        ));
        return false;
      });
  }

  Future<bool> checkWIshlist(String productId) async {
    if (await LoginResponse.getLoginData(_secureStorage)== null) {
      return false;
    }
    try {
      final wishlists = await _repository.getWishlist();
      wishlist.value = wishlists;
      return wishlists.products.firstWhereOrNull((element) => element.productId == productId) != null;
    } catch (error) {
      return false;
    }
  }
}