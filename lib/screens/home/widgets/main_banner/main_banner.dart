import 'package:flutter/material.dart';
import 'package:ufo_elektronika/models/carousel_model.dart';
import 'package:ufo_elektronika/screens/home/widgets/main_banner/main_banner_controller.dart';
import 'package:ufo_elektronika/shared/utils/get_view_keep_alive.dart';
import 'package:ufo_elektronika/widgets/common/carousel_widget.dart';
import 'package:ufo_elektronika/widgets/shimmer/carousel_shimmer.dart';

class MainBanner extends GetViewKeepAlive<MainBannerController> {
  const MainBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: controller.obx((state) {
        if (state == null) {
          return const CarouselShimmer();
        }
        return CarouselWidget(
          autoPlay: true,
          boxFit: BoxFit.fitHeight,
          list: state.banners
              .map((e) => CarouselModel(image: e.image, url: e.link ?? "/"))
              .toList(),
        );
      },
          onLoading: const CarouselShimmer(),
          onError: (error) => Text(error.toString())),
    );
  }
}
