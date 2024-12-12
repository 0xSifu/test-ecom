import 'dart:convert';

import 'package:ufo_elektronika/screens/home/entities/banner_main_response.dart';

class BannerOfficialBrandShopResponse {
    final List<Banner> banners;
    final int module;

    BannerOfficialBrandShopResponse({
        required this.banners,
        required this.module,
    });


  factory BannerOfficialBrandShopResponse.fromMap(Map<String, dynamic> map) {
    return BannerOfficialBrandShopResponse(
      banners: List<Banner>.from(map['banners']?.map((x) => Banner.fromMap(x))),
      module: map['module']?.toInt() ?? 0,
    );
  }

  factory BannerOfficialBrandShopResponse.fromJson(String source) => BannerOfficialBrandShopResponse.fromMap(json.decode(source));
}
