import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HorizonProductShimmer extends StatelessWidget {
  const HorizonProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(vertical: 15),
      color: Colors.white,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Row(
            children: [
              SizedBox(width: index == 0 ? 15 : 10),
              Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.grey[100]!,
                child: SizedBox(
                  width: 150,
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
            ],
          );
        },
      ),
    );
  }
}
