import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/account/account_repository.dart';
import 'package:ufo_elektronika/screens/account/account_response.dart';
import 'package:ufo_elektronika/screens/login/login_response.dart';
import 'package:ufo_elektronika/screens/main/main_controller.dart';
import 'package:ufo_elektronika/screens/main/main_screen.dart';
import 'package:ufo_elektronika/screens/user/ufopoint/ufopoint_repository.dart';

class AccountController extends GetxController {

  final AccountRepository _repository;
  final UfoPointRepository _ufoPointRepository;
  final FlutterSecureStorage _secureStorage;
  AccountController({
    required AccountRepository repository, 
    required UfoPointRepository ufoPointRepository,
    required FlutterSecureStorage secureStorage,
  }): 
  _repository = repository,
  _ufoPointRepository = ufoPointRepository,
  _secureStorage = secureStorage;

  final profile = Rx<ProfileResponse?>(null);
  final totalPoints = "".obs;
  final isLoggedIn = false.obs;

  List<Map<String, String?>> accountDeletionReasons = [
    {
      "reason": "Saya Meninggalkan Sementara"
    },
    {
      "reason": "Saya tidak menemukan barang yang saya cari"
    },
    {
      "reason": "Saya Mempunyai Banyak Akun"
    },
    {
      "reason": "Alasan Lainnya",
      "notes": "akun akan di nonaktifkan, transaksi dan lainnya akan disembunyikan dan tidak akan terhapus sampai anda melakukan \"Hapus Akun\""
    }
  ];
  late final accountDeletionReasonIndex = Rx<int?>(null);

  @override
  void onInit() {
    super.onInit();
    refreshProfile();
  }

  void refreshProfile() {

    LoginResponse.listenToLoginDataChanged(_secureStorage, (loginData) {
      isLoggedIn.value = loginData != null;
      if (loginData != null) {
        _repository.getProfile()
          .then((value) => profile.value = value)
          .catchError((error) {
            Get.showSnackbar(GetSnackBar(
              message: error is DioException ? error.response?.data["error"] : error.toString(),
              duration: const Duration(seconds: 2),
            ));
            return error;
          });

        _ufoPointRepository.getUfoPoints()
          .then((value) {
            totalPoints.value = value.totalPoints ?? "";
          })
          .catchError((error) {

          });
      }
    });
  }
  
  void deleteAccount() {
    Get.showOverlay(
      asyncFunction: () async {
        try {
          await _repository.deleteAccount();
          
          while (Get.currentRoute != MainScreen.routeName) {
            Get.back();
          }
          Get.showSnackbar(const GetSnackBar(
            message: "Berhasil",
            duration: Duration(seconds: 2),
          ));
          Get.find<MainController>().signOut();
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