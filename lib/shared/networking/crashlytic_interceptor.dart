import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticInterceptor extends InterceptorsWrapper {

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    if (response.statusCode != 200) {
      FirebaseCrashlytics.instance.recordError(Exception([response.requestOptions.uri.toString(), response.statusCode, response.statusMessage, jsonEncode(response.data)]), StackTrace.current);
    }
  } 

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    if (err.response?.statusCode != 200) {
      FirebaseCrashlytics.instance.recordError(err, err.stackTrace);
    }
  }
}