import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ufo_elektronika/constants/colors.dart';

class PromoPayment extends StatefulWidget {
  const PromoPayment({super.key});

  @override
  State<PromoPayment> createState() => _PromoPaymentState();
}

class _PromoPaymentState extends State<PromoPayment> {
  bool _isLoading = true;

  /* ---------------------------- Dummy fetch data ---------------------------- */
  Future<void> _fetchData() async {
    // Simulate a refresh operation (e.g., fetching updated data)
    await Future.delayed(
      const Duration(milliseconds: 500),
      () {
        setState(() {});

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
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                // title

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Promo pembayaran'.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FuturaLT',
                    ),
                  ),
                ),

                // content
                SizedBox(
                  height: 108,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      List<String> backgrounds = [
                        'assets/images/background/box-blue.webp',
                        'assets/images/background/box-orange.webp',
                        'assets/images/background/box-ocean.webp'
                      ];

                      return Container(
                        width: 108,
                        height: 108,
                        margin: EdgeInsets.only(left: index == 0 ? 15 : 10),
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                backgrounds[index % backgrounds.length]),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(2.2),
                                  bottomRight: Radius.circular(2.2),
                                ),
                                color: Colors.white,
                              ),
                              child: SizedBox(
                                height: 8.9,
                                child: SvgPicture.asset(
                                    'assets/images/bank/bca.svg'),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'EXTRA DISKON',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 7.3,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'FuturaLT',
                              ),
                            ),
                            const Text(
                              'Hingga',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 5.8,
                                fontFamily: 'MYRIADPRO',
                              ),
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    'Rp',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 7.2,
                                      fontFamily: 'MYRIADPRO',
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2.7),
                                Text(
                                  '500',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.8,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'FuturaLT',
                                  ),
                                ),
                                SizedBox(width: 2.7),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    'RIBU',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 7.2,
                                      fontFamily: 'MYRIADPRO',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Cicilan 12 bulan'.toLowerCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 7.3,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'FuturaLT',
                              ),
                            ),
                            Text(
                              'bunga 0%'.toLowerCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 4.5,
                                fontFamily: 'FuturaLT',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          );
  }
}
