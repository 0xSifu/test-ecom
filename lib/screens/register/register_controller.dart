import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/main/main_controller.dart';
import 'package:ufo_elektronika/screens/register/register_repository.dart';

class RegisterController extends GetxController {

  final RegisterRepository _repository;
  RegisterController({required RegisterRepository repository}): _repository = repository;

  var name = "".obs;
  var phone = "".obs;
  var email = "".obs;
  var password = "".obs;
  var passwordConfirmation = "".obs;
  var agreeToTnC = false.obs;
  var isSigningIn = false.obs;
  var passwordIsVisible = false.obs;

  
  void signInWithFacebook() async {
    try {
      isSigningIn.value = true;
      final res = await _repository.signInWithFacebook();
      if (res.error != null) {
        Get.showSnackbar(GetSnackBar(
          message: res.error,
          duration: const Duration(seconds: 2),
        ));
        isSigningIn.value = false;
        return;
      }
      await Get.find<MainController>().replaceUser(res);
      Get.back(result: true);
    } catch (error) {
      isSigningIn.value = false;
      Get.showSnackbar(GetSnackBar(
        message: error is DioException ? (error as DioException?)?.response?.data["error"].toString() : error.toString(),
        duration: const Duration(seconds: 3),
      ));
    }
  }

  void signInWithGoogle() async {
    try {
      isSigningIn.value = true;
      final res = await _repository.signInWithGoogle();
      if (res.error != null) {
        Get.showSnackbar(GetSnackBar(
          message: res.error,
          duration: const Duration(seconds: 2),
        ));
        isSigningIn.value = false;
        return;
      }
      await Get.find<MainController>().replaceUser(res);
      Get.back(result: true);
    } catch (error) {
      isSigningIn.value = false;
      Get.showSnackbar(GetSnackBar(
        message: error is DioException ? (error as DioException?)?.response?.data["error"].toString() : error.toString(),
        duration: const Duration(seconds: 3),
      ));
    }
  }

  void signInWithApple() async {
    try {
      isSigningIn.value = true;
      final res = await _repository.signInWithApple();
      if (res.error != null) {
        Get.showSnackbar(GetSnackBar(
          message: res.error,
          duration: const Duration(seconds: 2),
        ));
        isSigningIn.value = false;
        return;
      }
      await Get.find<MainController>().replaceUser(res);
      Get.back(result: true);
    } catch (error) {
      isSigningIn.value = false;
      Get.showSnackbar(GetSnackBar(
        message: error is DioException ? (error as DioException?)?.response?.data["error"].toString() : error.toString(),
        duration: const Duration(seconds: 3),
      ));
    }
  }

  void signInWithEmail() async {
    try {
      isSigningIn.value = true;
      final res = await _repository.register(email.value, password.value, passwordConfirmation.value, name.value, phone.value);
      if (res.success != null) {
        await Get.find<MainController>().replaceUser(res);
        Get.back(result: true);
      }
      if (res.error != null) {
        Get.showSnackbar(GetSnackBar(
          message: res.error,
          duration: const Duration(seconds: 2),
        ));
        isSigningIn.value = false;
        return;
      }
    } catch (error) {
      isSigningIn.value = false;
      Get.showSnackbar(GetSnackBar(
        message: error is DioException ? (error as DioException?)?.response?.data["error"].toString() : error.toString(),
        duration: const Duration(seconds: 3),
      ));
    }

  }
  
}