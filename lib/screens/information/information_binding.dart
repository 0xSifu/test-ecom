import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/information/information_controller.dart';
import 'package:ufo_elektronika/screens/information/information_repository.dart';

class InformationBinding extends Bindings {
  final String? id;
  final String? notificationId;
  InformationBinding({required this.id, required this.notificationId});
  @override
  void dependencies() {
    Get.lazyPut<InformationRepository>(() => InformationRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => InformationController(repository: Get.find(), id: id, notificationId: notificationId));
  }
}