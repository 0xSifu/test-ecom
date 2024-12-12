import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryListShimmer extends StatelessWidget {
  const CategoryListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[100]!,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 15),
              GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: 8,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 100,
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 15),
              for (int i = 0; i < 10; i++)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
