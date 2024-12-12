

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ufo_elektronika/screens/login/login_response.dart';

class AuthorizationInterceptor extends InterceptorsWrapper {
  final FlutterSecureStorage _secureStorage;
  final Function()? _onUnauthorized;
  AuthorizationInterceptor({
    required FlutterSecureStorage secureStorage,
    required Function()? onUnauthorized
  }): _secureStorage = secureStorage, _onUnauthorized = onUnauthorized;
  
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final loginData = await LoginResponse.getLoginData(_secureStorage);
      if (loginData != null) {
        final token = loginData.token;
        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }
      }
    } catch (error, stacktrace) {
      FirebaseCrashlytics.instance.recordError(error, stacktrace);
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    super.onResponse(response, handler);
    if (response.statusCode == 401 && !response.requestOptions.uri.toString().contains("account/register") && !response.requestOptions.uri.toString().contains("account/forgotten")) {
      _onUnauthorized?.call();
    }
    // if (response.statusCode == HttpStatus.found) {
    //   final location = response.headers.value("location");
    //   if (location != null) {
    //     // final newResponse = 
    //   }
    // } else {
    //   super.onResponse(response, handler);
    //   if (response.statusCode == 401 && !response.requestOptions.uri.toString().contains("account/register")) {
    //     _onUnauthorized?.call();
    //   }
    // }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    if (err.response?.statusCode == 401 
        && err.response?.requestOptions.uri.toString().contains("account/register") == false
        && err.response?.requestOptions.uri.toString().contains("account/forgotten") == false) {
      _onUnauthorized?.call();
    }
  }
  
}
