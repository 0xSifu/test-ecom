import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:ufo_elektronika/screens/account/account_response.dart';

abstract class UserUpdateRepository {
  Future<ProfileResponse> getProfile();
  Future<ProfileResponse> updateProfile({
    required String email,
    required String name,
    required String nik,
    required String dob,
    required String gender,
    required String fax,
    required String telephone
  });
  Future<ProfileResponse> editProfilePhoto({required File image});
}

class UserUpdateRepositoryImpl extends UserUpdateRepository {

  final Dio _dio;
  UserUpdateRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<ProfileResponse> getProfile() async {
    final dioResp = await _dio.get("account/profil");
    final res = ProfileResponse.fromMap(dioResp.data);
    return res;
  }

  @override
  Future<ProfileResponse> updateProfile({
    required String email, 
    required String name, 
    required String nik, 
    required String dob, 
    required String gender, 
    required String fax, 
    required String telephone
  }) async {
    final map = {
      "email": email,
      "fullname": name,
      "nik": nik,
      "dob": dob,
      "gender": gender,
      "fax": fax,
      "telephone": telephone
    };
    final dioResp = await _dio.post("account/edit_profile", data: FormData.fromMap(map));
    final res = ProfileResponse.fromMap(dioResp.data);
    return res;
  }

  @override
  Future<ProfileResponse> editProfilePhoto({required File image}) async {
    final dioResp = await _dio.post("account/edit_profile/profile_photo", data: FormData.fromMap({
      "photo": await MultipartFile.fromFile(image.path, contentType: MediaType.parse(lookupMimeType(image.path) ?? ""))
    }));
    // final resp = jsonEncode(dioResp.data);
    try {

      final res = ProfileResponse.fromMap(dioResp.data);
      return res;
    } catch (error) {
      throw Exception(dioResp.data);
    }
  }
}