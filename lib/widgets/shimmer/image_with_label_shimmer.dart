import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageWithLabelShimmer extends StatelessWidget {
  const ImageWithLabelShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      color: Colors.white,
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: index == 0 ? 15 : 10),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.grey[100]!,
                child: SizedBox(
                  width: 80,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
