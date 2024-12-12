import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ufo_elektronika/screens/account/account_response.dart';
import 'package:ufo_elektronika/screens/login/login_response.dart';
import 'package:ufo_elektronika/screens/user/update/user_update_repository.dart';

class UserUpdateController extends GetxController {
  final UserUpdateRepository _repository;
  final FlutterSecureStorage _secureStorage;
  UserUpdateController({required UserUpdateRepository repository, required FlutterSecureStorage secureStorage}): _repository = repository, _secureStorage = secureStorage;

  final name = "".obs;
  final email = "".obs;
  final phone = "".obs;
  final nik = "".obs;
  final gender = "F".obs;
  final emailIsReadOnly = false.obs;
  final dob = DateTime.now().subtract(const Duration(days: 365 * 18)).obs;
  final profileImageFile = Rx<File?>(null);
  final profile = Rx<ProfileResponse?>(null);
  final isSubmitting = false.obs;

  final biometricLoginIsEnabled = false.obs;
  final biometricAvailable = false.obs;
  final auth = LocalAuthentication();

  @override
  void onInit() {
    super.onInit();
    loadProfile();
    setupBiometric();
  }

  void setupBiometric() async {

    auth.getAvailableBiometrics()
      .then((biometrics) {
        biometricAvailable.value = biometrics.firstWhereOrNull((e) => e == BiometricType.face || e == BiometricType.fingerprint) != null;
      });

    
    final loginData = await LoginResponse.getLoginData(_secureStorage);
    biometricLoginIsEnabled.value = loginData != null;
      

    biometricLoginIsEnabled.listen((enabled) async {
      if (enabled) {
        final loginData = await LoginResponse.getLoginData(_secureStorage);
        await LoginResponse.setLoginDataForBiometric(_secureStorage, loginData);
      } else {
        await LoginResponse.setLoginDataForBiometric(_secureStorage, null);
      }
    });
  }

  void loadProfile() {
    _repository.getProfile()
      .then((value) {
        profile.value = value;
        name.value = value.fullname ?? "";
        email.value = value.email ?? "";
        emailIsReadOnly.value = value.email?.isNotEmpty == true;
        phone.value = value.telephone ?? "";
        nik.value = value.nik ?? "";
        gender.value = value.gender == "1" ? "F" : "M";
        dob.value = DateFormat("yyyy-MM-dd").tryParse(value.dob ?? "") ?? dob.value;
      })
      .catchError((error) {
        Get.showSnackbar(GetSnackBar(
          message: error is DioException ? error.response?.data["error"] : error.toString(),
          duration: const Duration(seconds: 2),
        ));
        return error;
      });
  }

  void submit() async {
    isSubmitting.value = true;

    if (profileImageFile.value != null) {
      try {
        await _repository.editProfilePhoto(image: profileImageFile.value!);
      } catch (error) {
        isSubmitting.value = false;
        Get.showSnackbar(GetSnackBar(
          message: error is DioException ? error.response?.data["error"] : error.toString(),
          duration: const Duration(seconds: 2),
        ));
        return;
      }
    }
    _repository.updateProfile(
      email: email.value, 
      name: name.value, 
      nik: nik.value, 
      dob: DateFormat("yyyy-MM-dd").format(dob.value), 
      gender: gender.value == "F" ? "1" : "0", 
      fax: "", 
      telephone: phone.value
    )
    .then((value) {
      isSubmitting.value = false;
      Get.showSnackbar(GetSnackBar(
        message: value.error ?? value.success,
        duration: const Duration(seconds: 2),
      ));
      return value;
    })
    .catchError((error) {
      isSubmitting.value = false;
      Get.showSnackbar(GetSnackBar(
        message: error is DioException ? error.response?.data["error"] : error.toString(),
        duration: const Duration(seconds: 2),
      ));
      return error;
    });
  }


}