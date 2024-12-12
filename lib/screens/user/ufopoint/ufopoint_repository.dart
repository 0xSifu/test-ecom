import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/user/ufopoint/ufopoint_response.dart';

abstract class UfoPointRepository {

  Future<UfoPointResponse> getUfoPoints();
  Future<dynamic> claim(String code);

}

class UfoPointRepositoryImpl extends UfoPointRepository {
  final Dio _dio;
  UfoPointRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<UfoPointResponse> getUfoPoints() async {
    final dioResp = await _dio.get("account/ufopoint");
    final res = UfoPointResponse.fromMap(dioResp.data);
    return res;
  }

  @override
  Future<dynamic> claim(String code) async {
    final dioResp = await _dio.post("account/ufopoint/tukar_point", data: FormData.fromMap({
      "code": code
    }));
    return dioResp.data;
  }
}