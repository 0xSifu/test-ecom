import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/user/address/address_repository.dart';
import 'package:ufo_elektronika/screens/user/address/address_response.dart';

class AddressController extends GetxController {
  final AddressRepository _repository;
  AddressController({required AddressRepository repository}): _repository = repository;

  final address = Rx<AddressResponse?>(null);

  @override
  void onInit() {
    super.onInit();
    loadAddress();
  }

  void loadAddress() {
    _repository.getAddress()
      .then((value) => address.value = value)
      .catchError((error) {
        Get.showSnackbar(GetSnackBar(
          message: error is DioException ? error.response?.data["error"] : error.toString(),
          duration: const Duration(seconds: 2),
        ));
        return error;
      });
  }

  void deleteAddress(String addressId) {
    Get.showOverlay(
      asyncFunction: () async {
        try {
          final result = await _repository.removeAddress(addressId);
          
          Get.showSnackbar(GetSnackBar(
            message: result["error"] ?? result["success"],
            duration: const Duration(seconds: 2),
          ));
          loadAddress();
        } catch (error) {
          Get.showSnackbar(GetSnackBar(
            message: error is DioException ? error.response?.data["error"] : error.toString(),
            duration: const Duration(seconds: 2),
          ));
        }
      },
      loadingWidget: const Center(child: CircularProgressIndicator())
    );
  }
}