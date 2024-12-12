import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ufo_elektronika/app.dart';
import 'package:ufo_elektronika/shared/flavors/flavor_config.dart';


FirebaseOptions get defaultOptions {
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return const FirebaseOptions(
        apiKey: 'AIzaSyBhZM4JR8XhEsKohVbNLsLlKp66lV1fP0Q',
        appId: '1:991573388326:android:8d43b56ce5280b1157cae7',
        messagingSenderId: '991573388326',
        projectId: 'ufoe-85428',
        storageBucket: 'ufoe-85428.appspot.com',
      );
    case TargetPlatform.iOS:
      return const FirebaseOptions(
        apiKey: 'AIzaSyASFirLNBe0tA_06FHkO8xJdAydg1-41ZU',
        appId: '1:991573388326:ios:7cd5bb3b89d1ff1157cae7',
        messagingSenderId: '991573388326',
        projectId: 'ufoe-85428',
        storageBucket: 'ufoe-85428.appspot.com',
        androidClientId: '991573388326-82m0eb3l6mi1k7jvnqdahh6u53lu21b1.apps.googleusercontent.com',
        iosClientId: '991573388326-j1p2o5kh312es6qgnnrr4t5c020hotmv.apps.googleusercontent.com',
        iosBundleId: 'com.ufoelektronika.consumer.dev',
      );
    default:
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for this platform - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
  }
}

void main() {
  FlavorConfig(
      flavor: Flavor.DEV,
      values: FlavorValues(
          baseUrl: "https://lab.gosit.us/ufoe/index.php?route=api/v1/",
          webVapidKey: "BIdaz_MgeXSRVI-M632k-ake-Ob1GOutVJluCzXedeIJ9N0EfmtA5NccrnKIABYdO7UWRjFYcCAX5uuNJNZ9lNA",
          webRecaptchaSiteKey: "6LeA1ZwnAAAAAL3_zzA9KDGx80MpYfefygwlkmAB",
          webGoogleSignInClientId: '183413921081-opc34ppue2mnscebga3pb70vj6d30rl8.apps.googleusercontent.com',
          midtransClientKey: "SB-Mid-client-v__bX5x3-RApqJ6h",
          midtransMerchantBaseUrl: "https://ufoelektronika.com",
          facebookAppId: "909124830060804",
          iosAppId: "6503633863"
          ));

  HttpOverrides.global = MyHttpOverrides();
          
  runZonedGuarded(() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: defaultOptions);
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
    runApp(
      const MyApp(),
    );
  }, (error, stack) {
    if (!kIsWeb) {
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    debugPrint("$error $stack");
  });
}

 class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}