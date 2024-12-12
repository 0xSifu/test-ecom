import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HeaderInterceptor extends InterceptorsWrapper {
  final PackageInfo packageInfo;
  final String? deviceId;
  final String? Function()? fcmTokenGetter;
  final BuildContext? Function() contextGetter;
  HeaderInterceptor({
    required this.packageInfo,
    required this.deviceId,
    required this.contextGetter,
    required this.fcmTokenGetter,
  });
  
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      options.headers["X-Device-ID"] = deviceId;

      final platform = Platform.isIOS ? 'iOS' : Platform.isAndroid ? 'Android' : throw Exception();
      final xDevice = '$platform || ${Platform.operatingSystemVersion} || ${packageInfo.version} || ufo-elektronika-consumer';
      options.headers["X-Device"] = xDevice;
      
      options.headers["X-Device-Push-Notification-Token"] = fcmTokenGetter?.call();
    } catch (error, stacktrace) {
      FirebaseCrashlytics.instance.recordError(error, stacktrace);
    }
    super.onRequest(options, handler);
  }
  
}
