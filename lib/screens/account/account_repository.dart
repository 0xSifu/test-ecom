import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/account/account_response.dart';

abstract class AccountRepository {
  Future<ProfileResponse> getProfile();
  Future<void> deleteAccount();
}

class AccountRepositoryImpl extends AccountRepository {

  final Dio _dio;
  AccountRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<ProfileResponse> getProfile() async {
    final dioResp = await _dio.get("account/profil");
    final res = ProfileResponse.fromMap(dioResp.data);
    return res;
  }

  @override
  Future<void> deleteAccount() async {
    final dioResp = await _dio.get("account/edit_profile/delete");
    return;
  }
}