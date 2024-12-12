import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ufo_elektronika/screens/login/login_repository.dart';
import 'package:ufo_elektronika/screens/login/login_response.dart';
import 'package:ufo_elektronika/screens/main/main_controller.dart';

class LoginController extends GetxController {

  final LoginRepository _repository;
  final FlutterSecureStorage _secureStorage;
  LoginController({required LoginRepository repository, required FlutterSecureStorage secureStorage}): _repository = repository, _secureStorage = secureStorage;

  var isSigningIn = false.obs;
  var email = "".obs;
  var password = "".obs;
  var passwordVisible = false.obs;
  bool get isSignInEnabled => email.value.isNotEmpty && password.value.isNotEmpty;
  final auth = LocalAuthentication();
  final biometricsAvailable = RxList<BiometricType>();

  @override
  void onInit() {
    super.onInit();
    auth.getAvailableBiometrics().then((biometrics) async {
      final loginData = await LoginResponse.getLoginDataForBiometric(_secureStorage);
      if (loginData != null) {
        biometricsAvailable.value = biometrics;
      }
    });
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

  void signInWithEmail() async {
    try {
      isSigningIn.value = true;
      final res = await _repository.signInWithEmailAndPassword(email.value, password.value);
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
  
  void signInWithBiometric() async {
    final didAuthenticate = await auth.authenticate(localizedReason: "Autentikasi untuk login",
          options: const AuthenticationOptions(useErrorDialogs: false, biometricOnly: true, stickyAuth: true));
    if (didAuthenticate) {
      final loginData = await LoginResponse.getLoginDataForBiometric(_secureStorage);
      if (loginData != null) {
        await Get.find<MainController>().replaceUser(loginData);
        Get.back(result: true);
      }
    }
  }
}