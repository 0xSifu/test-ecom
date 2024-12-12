import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart' as sizer;
import 'package:ufo_elektronika/screens/home/widgets/banner/banner_image_controller.dart';
import 'package:ufo_elektronika/shared/utils/get_view_keep_alive.dart';
import 'package:ufo_elektronika/widgets/image.dart';

class BannerImage extends GetViewKeepAlive<BannerImageController> {
  const BannerImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 7),
      child: controller.obx((state) {
        if (state == null) return const Center(child: CircularProgressIndicator());
        final banners = state.banners;
        if (sizer.Device.screenType == sizer.ScreenType.tablet) {
          return Row(
            children: [
              if (banners.isNotEmpty &&
                    banners.length > 1 &&
                    banners[0].image.isNotEmpty)
                  Expanded(
                    child: GestureDetector(
                      onTap: banners[0].link?.isNotEmpty == true ? () => Get.toNamed(banners[0].link ?? "/") : null,
                      child: Container(
                        // borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                        child: AspectRatio(
                          aspectRatio: 534/279,
                          child: UEImage2(banners[0].image, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 7),
                if (banners.isNotEmpty && banners[1].image.isNotEmpty)
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: banners[1].link?.isNotEmpty == true ? () => Get.toNamed(banners[1].link ?? "/") : null,
                      child: Container(
                        color: Colors.transparent,
                        child: AspectRatio(
                          aspectRatio: 1089/297,
                          child: UEImage2(
                            banners[1].image, fit: BoxFit.fitWidth
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 7),
                if (banners.isNotEmpty &&
                    banners.length > 2 &&
                    banners[2].image.isNotEmpty)
                  Expanded(
                    child: GestureDetector(
                      onTap: banners[2].link?.isNotEmpty == true ? () => Get.toNamed(banners[2].link ?? "/") : null,
                      child: Container(
                        // borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                        child: AspectRatio(
                          aspectRatio: 534/279,
                          child: UEImage2(banners[2].image, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
            ],
          );
        }
        return Column(
          children: [
            if (banners.isNotEmpty && banners[1].image.isNotEmpty)
              GestureDetector(
                onTap: banners[1].link?.isNotEmpty == true ? () => Get.toNamed(banners[1].link ?? "/") : null,
                child: Container(
                  color: Colors.transparent,
                  child: AspectRatio(
                    aspectRatio: 1089/297,
                    child: UEImage2(
                      banners[1].image, fit: BoxFit.fitWidth
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (banners.isNotEmpty &&
                    banners.length > 1 &&
                    banners[0].image.isNotEmpty)
                  Expanded(
                    child: GestureDetector(
                      onTap: banners[0].link?.isNotEmpty == true ? () => Get.toNamed(banners[0].link ?? "/") : null,
                      child: Container(
                        // borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                        child: AspectRatio(
                          aspectRatio: 534/279,
                          child: UEImage2(banners[0].image, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 7),
                if (banners.isNotEmpty &&
                    banners.length > 2 &&
                    banners[2].image.isNotEmpty)
                  Expanded(
                    child: GestureDetector(
                      onTap: banners[2].link?.isNotEmpty == true ? () => Get.toNamed(banners[2].link ?? "/") : null,
                      child: Container(
                        // borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                        child: AspectRatio(
                          aspectRatio: 534/279,
                          child: UEImage2(banners[2].image, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
      onLoading: _loadingShimmer()
      ),
    );
  }
}

Widget _loadingShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[200]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Container(
            height: 100,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  height: 100,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  height: 100,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
