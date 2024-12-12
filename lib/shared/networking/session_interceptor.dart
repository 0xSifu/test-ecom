
import 'dart:io';

import 'package:dio/dio.dart';

class SessionInterceptor extends InterceptorsWrapper {
  static String? customSession;
  
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (customSession != null) {
      final prevSession = options.headers[HttpHeaders.cookieHeader];
      final newSession = prevSession != null && prevSession.toString().isNotEmpty ? "$prevSession; $customSession;" : customSession;
      options.headers[HttpHeaders.cookieHeader] = newSession;
    }
    super.onRequest(options, handler);
  }
  
}
