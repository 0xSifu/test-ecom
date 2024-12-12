import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/login/login_controller.dart';
import 'package:ufo_elektronika/screens/login/login_repository.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginRepository>(() => LoginRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => LoginController(repository: Get.find(), secureStorage: Get.find()));
  }
}