import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/login/login_response.dart';

abstract class ForgotPasswordRepository {
  Future<dynamic> forgotPassword(String email);
}

class ForgotPasswordRepositoryImpl extends ForgotPasswordRepository {

  final Dio _dio;
  ForgotPasswordRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<dynamic> forgotPassword(String email) async{
    final dioResp = await _dio.post("account/forgotten", data: FormData.fromMap({
      "email": email
    }));
    return dioResp.data;
  }
}