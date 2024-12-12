import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/information/information_response.dart';

abstract class InformationRepository {
  Future<InformationResponse> getInformation({required String id, int? page});
  Future<InformationResponse> getNotification({required String id, int? page});
}

class InformationRepositoryImpl extends InformationRepository {
  final Dio _dio;
  InformationRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<InformationResponse> getInformation({required String id, int? page}) async {
    String endpoint = "informations/information/index&information_id=$id";
    if (page != null) {
      endpoint += "&page=$page";
    }
    final dioResp = await _dio.get(endpoint);
    return InformationResponse.fromMap(dioResp.data);
  }

  @override
  Future<InformationResponse> getNotification({required String id, int? page}) async {
    String endpoint = "informations/information/index&notification_id=$id";
    if (page != null) {
      endpoint += "&page=$page";
    }
    final dioResp = await _dio.get(endpoint);
    return InformationResponse.fromMap(dioResp.data);
  }
}