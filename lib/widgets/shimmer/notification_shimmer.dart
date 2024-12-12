import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80,
                      height: 15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
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
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          );
        },
      ),
    );
  }
}
