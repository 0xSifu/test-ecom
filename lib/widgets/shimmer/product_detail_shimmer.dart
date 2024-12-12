import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailShimmer extends StatelessWidget {
  const ProductDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 200,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 150,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(height: 50),
          Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 150,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 120,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(width: 30),
              Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 120,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 120,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(width: 30),
              Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 120,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 120,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(width: 30),
              Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 120,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
