import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class VerticalProductShimmer extends StatelessWidget {
  const VerticalProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: 6,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.8,
          crossAxisCount: screenWidth > 700 ? 4 : 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 100,
              margin: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
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
          );
        },
      ),
    );
  }
}
