import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';

class FirebaseService {
  String? Function()? _fcmTokenGetter;
  String? Function()? get fcmTokenGetter => _fcmTokenGetter;

  late final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  late final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;
  late final FirebaseCrashlytics firebaseCrashlytics = FirebaseCrashlytics.instance;
  bool get isInitialized => _isInitialized && _finishInitalized;
  bool _isInitialized = false;
  bool _finishInitalized = false;
  

  Future<void> initializeFlutterFirebase(BuildContext? Function() context) async {
    if (_isInitialized) {
      return;
    }
    _isInitialized = true;
    String? fcmToken;
    _fcmTokenGetter = () => fcmToken;
    FirebaseMessaging.instance.getToken()
      .then((token) {
        fcmToken = token;
        debugPrint("FCM Token: $token");
      });

    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      fcmToken = token;
      debugPrint("FCM Token: $token");
    });

    firebaseAnalytics.setAnalyticsCollectionEnabled(true);

    // Wait for Firebase to initialize
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
        minimumFetchInterval: const Duration(seconds: 30),
        fetchTimeout: const Duration(seconds: 60)));


    final defaults = <String, dynamic>{
      "forceUpdate": "1.0.0",
      "softUpdate": "1.0.0",
      "currentVersion": "1.0.0",
      "signInWithAppleEnabled": true,
      "signInWithFacebookEnabled": true,
      "signInWithGoogleEnabled": true
    };
    await remoteConfig.setDefaults(defaults);
    await remoteConfig.activate();
    await Future.delayed(const Duration(seconds: 1));
    await remoteConfig.fetchAndActivate();
    remoteConfig.onConfigUpdated.listen((configUpdate) {
      debugPrint(configUpdate.updatedKeys.toString());
    });
    
    await FirebaseAnalytics.instance.logAppOpen(callOptions: AnalyticsCallOptions(global: true));
    _finishInitalized = true;
  }

  Future<void> refetchRemoteConfig() async {
    await remoteConfig.activate();
    await Future.delayed(const Duration(seconds: 1));
    await remoteConfig.fetchAndActivate();
  }

  String get baseUrl {
    return remoteConfig.getString("baseUrl");
  }

  String get forceUpdate {
    return remoteConfig.getString("forceUpdate");
  }

  String get softUpdate {
    return remoteConfig.getString("softUpdate");
  }

  String get currentVersion {
    return remoteConfig.getString("currentVersion");
  }

  String get midtransClientKey {
    return remoteConfig.getString("midtransClientKey");
  }

  String get midtransMerchantBaseUrl {
    return remoteConfig.getString("midtransMerchantBaseUrl");
  }

  bool get signInWithAppleEnabled {
    return remoteConfig.getBool("signInWithAppleEnabled");
  }

  bool get signInWithFacebookEnabled {
    return remoteConfig.getBool("signInWithFacebookEnabled");
  }

  bool get signInWithGoogleEnabled {
    return remoteConfig.getBool("signInWithGoogleEnabled");
  }

}
