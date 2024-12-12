import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/user/notification/notification_repository.dart';
import 'package:ufo_elektronika/screens/user/notification/notification_response.dart';
import 'package:ufo_elektronika/shared/utils/state_controller.dart';

class NotificationController extends StateController<NotificationResponse> {
  final NotificationRepository _repository;
  NotificationController({required NotificationRepository repository}): _repository = repository;

  final notifType = NotificationType.transaction.obs;

  @override
  void onInit() {
    super.onInit();
    futurize(_repository.getNotifications);
  }
}