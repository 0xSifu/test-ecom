import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_repository.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_list_response.dart';

enum VoucherClaimSource {
  user, cart, checkout
}

extension VoucherClaimSourceValue on VoucherClaimSource {
  String? get rawValue {
    switch (this) {
      case VoucherClaimSource.user:
      return null;
      case VoucherClaimSource.cart:
      return "cart";
      case VoucherClaimSource.checkout:
      return "checkout";
    }
  }
}

class VoucherController extends GetxController {

  final VoucherRepository _repository;
  VoucherController({required VoucherRepository repository}): _repository = repository;

  final vouchers = RxList<Coupon>([]);
  final selectedVoucher = Rx<Coupon?>(null);
  final searchedVoucher = "".obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
     _repository.getVouchers()
      .then((value) {
        isLoading.value = false;
        vouchers.value = value.coupon;
      })
      .catchError((error) {
        isLoading.value = false;
        Get.showSnackbar(const GetSnackBar(
          message: "Ada kesalahan dalam mengambil data. Silakan coba lagi.",
          duration: Duration(seconds: 3),
        ));
        return error;
      });
  }

  void search({String? paymentMethod}) {
    if (searchedVoucher.isNotEmpty) {
      _repository.claimBySearch(code: searchedVoucher.value, paymentMethod: paymentMethod)
      .then((value) {
        if (value["error"] != null) {
          Get.showSnackbar(GetSnackBar(
            message: value["error"],
            duration: const Duration(seconds: 3),
          ));
        }
        return value;
      })
      .catchError((error) {
        Get.showSnackbar(const GetSnackBar(
          message: "Ada kesalahan dalam mengambil data. Silakan coba lagi.",
          duration: Duration(seconds: 3),
        ));
      });
    }
  }

  void claim({required VoucherClaimSource source, String? paymentMethod}) {
    if (selectedVoucher.value != null) {
      _repository.claim(code: selectedVoucher.value!.code!, source: source, paymentMethod: paymentMethod)
      .then((value) {
        if (value.error != null) {
          Get.showSnackbar(GetSnackBar(
            message: value.error,
            duration: const Duration(seconds: 2),
          ));
        } else if (value.success != null) {
          if (source == VoucherClaimSource.cart) {
            Get.back(result: true);
          }
          Get.showSnackbar(GetSnackBar(
            message: value.success,
            duration: const Duration(seconds: 2),
          ));
        }
        return value;
      })
      .catchError((error) {
        Get.showSnackbar(GetSnackBar(
          message: error is DioException ? error.response?.data["error"] : "Ada kesalahan dalam mengambil data. Silakan coba lagi.",
          duration: const Duration(seconds: 2),
        ));
        return error;
      });
    }
  }

  void removeVoucher() {
    _repository.removeActiveCoupon()
      .then((value) {
        if (value["error"] != null) {
          Get.showSnackbar(GetSnackBar(
            message: value["error"],
            duration: const Duration(seconds: 2),
          ));
        } else if (value["success"] != null) {
          Get.back(result: true);
          selectedVoucher.value = null;
          Get.showSnackbar(GetSnackBar(
            message: value["success"],
            duration: const Duration(seconds: 2),
          ));
        }
        return value;
      })
      .catchError((error) {
        Get.showSnackbar(GetSnackBar(
          message: error is DioException ? "${error.response?.data is Map ? error.response?.data["error"] : error.response?.data}" : "Ada kesalahan dalam mengambil data. Silakan coba lagi.",
          duration: const Duration(seconds: 2),
        ));
        return error;
      });

  }
}