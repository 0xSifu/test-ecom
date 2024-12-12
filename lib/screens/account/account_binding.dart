import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/account/account_controller.dart';
import 'package:ufo_elektronika/screens/account/account_repository.dart';
import 'package:ufo_elektronika/screens/user/ufopoint/ufopoint_repository.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {    
    Get.lazyPut<AccountRepository>(() => AccountRepositoryImpl(dio: Get.find()));
    Get.lazyPut<UfoPointRepository>(() => UfoPointRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => AccountController(repository: Get.find(), ufoPointRepository: Get.find(), secureStorage: Get.find()));
  }
}