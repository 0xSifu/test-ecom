import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/brand_screen.dart';
import 'package:ufo_elektronika/widgets/image.dart';

class BrandList extends StatefulWidget {
  const BrandList({super.key});

  @override
  State<BrandList> createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  bool _isLoading = true;
  List _brands = [];

  /* ---------------------------- Dummy fetch data ---------------------------- */
  Future<void> _fetchData() async {
    // Simulate a refresh operation (e.g., fetching updated data)
    await Future.delayed(
      const Duration(milliseconds: 500),
      () {
        setState(() {
          _brands = [
            {
              'image':
                  'https://www.ufoelektronika.com/image/catalog/FOTO BRAND/10(5).png',
              'url': '/category/samono',
            },
            {
              'image':
                  'https://www.ufoelektronika.com/image/catalog/logo brand/LOGO BRAND-01.png',
              'url': '/category/samsung',
            },
            {
              'image':
                  'https://www.ufoelektronika.com/image/catalog/logo brand/LOGO BRAND-25.png',
              'url': '/category/sanken',
            },
            {
              'image':
                  'https://www.ufoelektronika.com/image/catalog/FOTO BRAND/9(4).png',
              'url': '/category/sanyo',
            },
            {
              'image':
                  'https://www.ufoelektronika.com/image/catalog/FOTO BRAND/8(4).png',
              'url': '/category/serta',
            },
          ];
        });

        // set loading to false
        _isLoading = !_isLoading;
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _fetchData();
  }

  Widget loadingShimmer() {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? loadingShimmer()
        : Container(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Official Brands',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(BrandScreen.routeName),
                        child: const Text(
                          'Lihat Semua',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    itemCount: _brands.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: () => Get.toNamed(_brands[index]['url']),
                            child: Container(
                              width: 150,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                  color: const Color(0xFFDEDEDE),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: UEImage2(
                                _brands[index]['image'],
                                height: 80,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
