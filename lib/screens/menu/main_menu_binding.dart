import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/menu/main_menu_controller.dart';
import 'package:ufo_elektronika/screens/menu/main_menu_repository.dart';

class MainMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainMenuRepository>(() => MainMenuRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => MainMenuController(repository: Get.find()));
  }
}