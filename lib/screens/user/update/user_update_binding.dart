import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/user/update/user_update_controller.dart';
import 'package:ufo_elektronika/screens/user/update/user_update_repository.dart';

class UserUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserUpdateRepository>(() => UserUpdateRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => UserUpdateController(repository: Get.find(), secureStorage: Get.find()));
  }
}