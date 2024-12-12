import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/user/ufopoint/ufopoint_controller.dart';
import 'package:ufo_elektronika/screens/user/ufopoint/ufopoint_repository.dart';

class UfoPointBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UfoPointRepository>(() => UfoPointRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => UfoPointController(repository: Get.find()));
  }
}