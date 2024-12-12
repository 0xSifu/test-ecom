import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/forgot_password/forgot_password_repository.dart';

class ForgotPasswordController extends GetxController {
  final ForgotPasswordRepository _repository;
  ForgotPasswordController({required ForgotPasswordRepository repository}): _repository = repository;

  var email = "".obs;
  var isSubmitting = false.obs;
  final errorMessage = "".obs;

  void submit() async {
    if (email.isEmpty) {
      errorMessage.value = "Email wajib diisi";
      return;
    } else {
      errorMessage.value = "";
    }
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      isSubmitting.value = true;
      final value = await _repository.forgotPassword(email.value);
      isSubmitting.value = false;
      if (value["error"] != null && value["error"]?.toString().isNotEmpty == true) {
        Get.showSnackbar(GetSnackBar(
          message: value["error"]?.toString(),
          duration: const Duration(seconds: 3),
        ));
      } else if (value["success"] != null && value["success"]?.toString().isNotEmpty == true) {
        Get.back();
        Future.delayed(const Duration(milliseconds: 300), () {
          Get.showSnackbar(GetSnackBar(
            message: value["success"]?.toString(),
            duration: const Duration(seconds: 3),
          ));
        });
      } else {
        Get.back(result: "OK");
        Future.delayed(const Duration(milliseconds: 300), () {
          Get.showSnackbar(const GetSnackBar(
            message: "Link reset password akan dikirim jika akun sudah terdaftar",
            duration: Duration(seconds: 2),
          ));
        });
      }

    } catch (error) {
      isSubmitting.value = false;
      Get.showSnackbar(GetSnackBar(
        message: error is DioException ? (error as DioException?)?.response?.data["error"] : error.toString(),
        duration: const Duration(seconds: 2),
      ));
    }
  }
}