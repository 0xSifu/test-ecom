import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/home/widgets/recommendation_product/recommendation_product_controller.dart';
import 'package:ufo_elektronika/shared/utils/get_view_keep_alive.dart';
import 'package:visibility_detector/visibility_detector.dart';

class RecommendationProduct extends GetViewKeepAlive<RecommendationProductController> {
  const RecommendationProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Text('Rekomendasi Untuk Kamu'.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'FuturaLT',
            color: AppColor.primaryColor,
          ),
        ),
      );
    },
    onLoading: VisibilityDetector(
      key: const Key("recommendation"), 
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction >= 0.2) {
          controller.load();
        }
      },
      child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 7.5),
              child: Text('Rekomendasi Untuk Kamu'.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'FuturaLT',
                  color: AppColor.primaryColor,
                ),
              ),
            ),
            Column(
              children: [1, 2, 3, 4, 5].map((e) => Row(
                children: [
                  const SizedBox(width: 15),
                  Expanded(child: productShimmer),
                  const SizedBox(width: 15),
                  Expanded(child: productShimmer),
                  const SizedBox(width: 15),
                ],
              )).toList()
            )
          ],
        )
      )
    );
  }

  Widget get productShimmer => Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        width: 150,
        height: 230,
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 15,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 15,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
      ),
    ),
  );

}