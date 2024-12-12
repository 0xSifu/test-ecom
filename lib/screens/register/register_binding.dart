import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/register/register_controller.dart';
import 'package:ufo_elektronika/screens/register/register_repository.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterRepository>(() => RegisterRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => RegisterController(repository: Get.find()));
  }
}