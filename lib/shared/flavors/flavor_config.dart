// ignore: constant_identifier_names
enum Flavor { DEV, ALPHA, BETA, PRODUCTION }

class FlavorValues {
  FlavorValues(
      {required this.baseUrl,
      required this.webVapidKey,
      required this.webRecaptchaSiteKey,
      required this.webGoogleSignInClientId,
      required this.midtransClientKey,
      required this.midtransMerchantBaseUrl,
      required this.facebookAppId,
      required this.iosAppId
      });
  final String baseUrl;
  final String webVapidKey;
  final String webRecaptchaSiteKey;
  final String webGoogleSignInClientId;
  final String midtransClientKey;
  final String midtransMerchantBaseUrl;
  final String facebookAppId;
  final String iosAppId;
  //Add other flavor specific values, e.g database name
}

extension StringUtils on Flavor {
  String get description {
    switch (this) {
      case Flavor.DEV:
        return "DEV";
      case Flavor.ALPHA:
        return "ALPHA";
      case Flavor.BETA:
        return "BETA";
      case Flavor.PRODUCTION:
        return "PRODUCTION";
    }
  }
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final FlavorValues values;
  static FlavorConfig? _instance;

  factory FlavorConfig(
      {required Flavor flavor,
      required FlavorValues values}) {
    _instance ??=
        FlavorConfig._internal(flavor, flavor.description, values);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.values);

  static FlavorConfig get instance {
    return _instance!;
  }

  static bool isProduction() => _instance!.flavor == Flavor.PRODUCTION;
  static bool isDevelopment() => _instance!.flavor == Flavor.DEV;
  // static bool isAlpha() => _instance!.flavor == Flavor.ALPHA;
  // static bool isBeta() => _instance!.flavor == Flavor.BETA;
}
