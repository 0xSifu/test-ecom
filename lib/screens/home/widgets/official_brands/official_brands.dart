import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/home/widgets/official_brands/official_brands_controller.dart';
import 'package:ufo_elektronika/shared/utils/get_view_keep_alive.dart';
import 'package:ufo_elektronika/widgets/image.dart';
import 'package:ufo_elektronika/widgets/shimmer/carousel_shimmer.dart';

class OfficialBrands extends GetViewKeepAlive<OfficialBrandsController> {
  const OfficialBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7, top: 4),
      child: controller.obx((state) {
        if (state == null) return const CarouselShimmer();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 7),
              child: Text(
                'Official Brand Shop'.toUpperCase(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'FuturaLT',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  if (state.banners.length >= 3)
                    GestureDetector(
                      onTap: state.banners[2].link?.isNotEmpty == true ? () => Get.toNamed(state.banners[2].link ?? "/") : null,
                      child: AspectRatio(
                        aspectRatio: 1089/450,
                        child: UEImage2(state.banners[2].image, fit: BoxFit.fitWidth),
                      ),
                    ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      if (state.banners.length > 1)
                        Expanded(
                          child: GestureDetector(
                            onTap: state.banners[0].link?.isNotEmpty == true ? () => Get.toNamed(state.banners[0].link ?? "/") : null,
                            child: UEImage2(state.banners[0].image, fit: BoxFit.fitWidth),
                          )
                        ),
                      const SizedBox(width: 7),
                      if (state.banners.length >= 2)
                        Expanded(
                          child: GestureDetector(
                            onTap: state.banners[1].link?.isNotEmpty == true ? () => Get.toNamed(state.banners[1].link ?? "/") : null,
                            child: UEImage2(state.banners[1].image, fit: BoxFit.fitWidth),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      if (state.banners.length >= 4)
                        Expanded(
                          child: GestureDetector(
                            onTap: state.banners[3].link?.isNotEmpty == true ? () => Get.toNamed(state.banners[3].link ?? "/") : null,
                            child: UEImage2(state.banners[3].image, fit: BoxFit.fitWidth),
                          ),
                        ),
                      const SizedBox(width: 7),
                      if (state.banners.length >= 5)
                        Expanded(
                          child: GestureDetector(
                            onTap: state.banners[4].link?.isNotEmpty == true ? () => Get.toNamed(state.banners[4].link ?? "/") : null,
                            child: UEImage2(state.banners[4].image, fit: BoxFit.fitWidth),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
      onLoading: const CarouselShimmer()),
    );
  }
}
