import 'package:flutter/material.dart';
import 'package:ufo_elektronika/widgets/shimmer/image_with_label_shimmer.dart';

class PromoMenu extends StatefulWidget {
  const PromoMenu({super.key});

  @override
  State<PromoMenu> createState() => _PromoMenuState();
}

class _PromoMenuState extends State<PromoMenu> {
  bool _isLoading = true;
  List _menus = [];

  /* ---------------------------- Dummy fetch data ---------------------------- */
  Future<void> _fetchData() async {
    // Simulate a refresh operation (e.g., fetching updated data)
    await Future.delayed(
      const Duration(milliseconds: 500),
      () {
        setState(() {
          _menus = [
            {
              'image': 'assets/icon/menu-promo/free-gift.webp',
              'label': 'Clearance Sale Up To 70%',
              'url': '/category/sale',
            },
            {
              'image': 'assets/icon/menu-promo/sale.webp',
              'label': 'Free Gift',
              'url': '/category/free-gift',
            },
            {
              'image': 'assets/icon/menu-promo/ufo-pro.webp',
              'label': 'Garansi UFO PRO',
              'url': '/category/garansi-ufo-pro',
            },
            {
              'image': 'assets/icon/menu-promo/free-gift.webp',
              'label': 'Clearance Sale Up To 70%',
              'url': '/category/sale',
            },
            {
              'image': 'assets/icon/menu-promo/sale.webp',
              'label': 'Free Gift',
              'url': '/category/free-gift',
            },
            {
              'image': 'assets/icon/menu-promo/ufo-pro.webp',
              'label': 'Garansi UFO PRO',
              'url': '/category/garansi-ufo-pro',
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

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const ImageWithLabelShimmer()
        : Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15),
            color: const Color(0xFFcae4f9),
            child: SizedBox(
              height: 95,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: _menus.length,
                itemBuilder: (context, index) => Row(
                  children: [
                    if (index == 0) const SizedBox(width: 15),
                    Container(
                      padding: const EdgeInsets.only(right: 7),
                      child: Column(
                        children: [
                          Container(
                            width: 116,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.asset(_menus[index]['image']),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _menus[index]['label'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF0060af),
                              fontSize: 9,
                              fontFamily: 'MYRIADPRO',
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (index == _menus.length - 1) const SizedBox(width: 15),
                  ],
                ),
              ),
            ),
          );
  }
}
