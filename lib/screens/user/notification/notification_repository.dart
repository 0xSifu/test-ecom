import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/user/notification/notification_response.dart';

abstract class NotificationRepository {

  Future<NotificationResponse> getNotifications();

}

class NotificationRepositoryImpl extends NotificationRepository {
  final Dio _dio;
  NotificationRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<NotificationResponse> getNotifications() async {
    final dioResp = await _dio.get("account/notification");
    final res = NotificationResponse.fromMap(dioResp.data);
    return res;
  }
}