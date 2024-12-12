import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/forgot_password/forgot_password_controller.dart';
import 'package:ufo_elektronika/screens/forgot_password/forgot_password_repository.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordRepository>(() => ForgotPasswordRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => ForgotPasswordController(repository: Get.find()));
  }
}