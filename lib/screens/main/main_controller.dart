
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/bottom_nav_settings.dart';
import 'package:ufo_elektronika/screens/login/login_response.dart';
import 'package:ufo_elektronika/screens/login/login_screen.dart';
import 'package:ufo_elektronika/screens/main/main_screen.dart';

class MainController extends GetxController {
  var lastIndex = 0;
  final tabs = BottomNavSettings().bottomNavMenus;
  final currentUser = Rx<LoginResponse?>(null);
  final tabController = CupertinoTabController();

  final FlutterSecureStorage _secureStorage;
  final FirebaseAnalytics _firebaseAnalytics;
  final FirebaseCrashlytics _firebaseCrashlytics;
  MainController({
    required FlutterSecureStorage secureStorage,
    required FirebaseAnalytics firebaseAnalytics,
    required FirebaseCrashlytics firebaseCrashlytics
  }): _secureStorage = secureStorage,
  _firebaseAnalytics = firebaseAnalytics,
  _firebaseCrashlytics = firebaseCrashlytics;
  

  @override
  void onInit() {
    super.onInit();
    LoginResponse.getLoginData(_secureStorage).then((value) {
      currentUser.value = value;
    });
  }

  void changeCurrentIndex(int index) {
    if (currentUser.value == null && (index == 2)) {
      Get.toNamed(LoginScreen.routeName)
        ?.then((value) {
          Future.delayed(const Duration(milliseconds: 300), () {
            if (value == true) {
              tabController.index = index;
            }
          });
        });
      tabController.index = lastIndex;
      return;
    }
    lastIndex = index;
    tabController.index = index;
  }

  Future replaceUser(LoginResponse response) async {
    await LoginResponse.setLoginData(_secureStorage, response);
    if (response.data?.customerId != null) {
      _firebaseAnalytics.setUserId(id: response.data!.customerId!, callOptions: AnalyticsCallOptions(global: true));
      _firebaseCrashlytics.setUserIdentifier(response.data!.customerId!);
    }
    if (response.data?.email != null) {
      _firebaseAnalytics.setUserProperty(name: "email", value: response.data?.email);
      _firebaseCrashlytics.setCustomKey("email", response.data!.email!);
    }
    currentUser.value = response;
  }

  Future signOut() async {
    await LoginResponse.setLoginData(_secureStorage, null);
    currentUser.value = null;
    while (Get.currentRoute != MainScreen.routeName) {
      Get.back();
    }
    lastIndex = 0;
    tabController.index = 0;
  }

  void unauthorized() async {
    while (Get.currentRoute != MainScreen.routeName) {
      Get.back();
      // print(Get.currentRoute);
    }
    // Get.showSnackbar(const GetSnackBar(
    //   message: "Sesi kamu sudah habis. Silakan login kembali",
    //   duration: Duration(seconds: 2),
    // ));
    signOut();
    lastIndex = 0;
    tabController.index = 0;
  }
}