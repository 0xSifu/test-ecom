import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart' as sizer;

class CarouselShimmer extends StatelessWidget {
  const CarouselShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(),
      color: Colors.white,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[100]!,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AspectRatio(
            aspectRatio: sizer.Device.screenType == sizer.ScreenType.tablet ? 2064/663 : 1179/600,
            child: Container(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
