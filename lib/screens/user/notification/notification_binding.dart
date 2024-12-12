import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/user/notification/notification_controller.dart';
import 'package:ufo_elektronika/screens/user/notification/notification_repository.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationRepository>(() => NotificationRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => NotificationController(repository: Get.find()));
  }
}