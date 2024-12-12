import 'dart:convert';

class BannerMainResponse {
    final List<Banner> banners;
    final int module;
    final String liveYoutube;
    final int? liveYoutubeStatus;

    BannerMainResponse({
        required this.banners,
        required this.module,
        required this.liveYoutube,
        this.liveYoutubeStatus,
    });

  factory BannerMainResponse.fromMap(Map<String, dynamic> map) {
    return BannerMainResponse(
      banners: List<Banner>.from(map['banners']?.map((x) => Banner.fromMap(x))),
      module: map['module']?.toInt() ?? 0,
      liveYoutube: map['live_youtube'] ?? '',
      liveYoutubeStatus: map['live_youtube_status']?.toInt(),
    );
  }

  factory BannerMainResponse.fromJson(String source) => BannerMainResponse.fromMap(json.decode(source));
}

class Banner {
    final String title;
    final String description;
    final String video;
    final String? link;
    final String image;

    Banner({
        required this.title,
        required this.description,
        required this.video,
        required this.link,
        required this.image,
    });


  factory Banner.fromMap(Map<String, dynamic> map) {
    return Banner(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      video: map['video'] ?? '',
      link: map['link'],
      image: map['image'] ?? '',
    );
  }

  factory Banner.fromJson(String source) => Banner.fromMap(json.decode(source));
}
