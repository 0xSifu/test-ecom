import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/constants/buttons.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/widgets/appbar/action_bar_widget.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar_search_input.dart';
import 'package:ufo_elektronika/widgets/common/modal_bottom_sheet_default.dart';
import 'package:ufo_elektronika/widgets/image.dart';
import 'package:ufo_elektronika/widgets/layouts/default_layout.dart';

class BrandScreen extends StatefulWidget {
  static const routeName = "/brand";
  const BrandScreen({super.key});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  final _scrollController = ScrollController();

  // filter
  Map<String, dynamic> order = {
    'sort': null,
    'order': null,
  };
  List brands = [];
  int page = 1;
  bool hasMoreData = true;

  Future<void> _fetchData() async {
    // Simulate a refresh operation (e.g., fetching updated data)
    await Future.delayed(
      const Duration(milliseconds: 300),
      () {
        setState(() {
          // dummy fetch data
          brands = [
            {
              'name': 'Samono',
              'image':
                  'https://www.ufoelektronika.com/image/catalog/FOTO BRAND/10(5).png',
              'url': '/category/samono',
            },
            {
              'name': 'Samsung',
              'image':
                  'https://www.ufoelektronika.com/image/catalog/logo brand/LOGO BRAND-01.png',
              'url': '/category/samsung',
            },
            {
              'name': 'Sanken',
              'image':
                  'https://www.ufoelektronika.com/image/catalog/logo brand/LOGO BRAND-25.png',
              'url': '/category/sanken',
            },
            {
              'name': 'Sanyo',
              'image':
                  'https://www.ufoelektronika.com/image/catalog/FOTO BRAND/9(4).png',
              'url': '/category/sanyo',
            },
            {
              'name': 'Serta',
              'image':
                  'https://www.ufoelektronika.com/image/catalog/FOTO BRAND/8(4).png',
              'url': '/category/serta',
            },
            {
              'name': 'TOSHIBA',
              'image':
                  'https://www.ufoelektronika.com/image/catalog/logo%20brand/LOGO%20BRAND-19.png',
              'url': '/category/TOSHIBA',
            },
            {
              'name': 'XIAOMI',
              'image':
                  'https://www.ufoelektronika.com/image/catalog/FOTO%20BRAND/1(5).png',
              'url': '/category/XIAOMI',
            },
            {
              'name': 'VIVO',
              'image':
                  'https://www.ufoelektronika.com/image/catalog/FOTO BRAND/3(8).png',
              'url': '/category/VIVO',
            },
            {
              'name': 'WASSER',
              'image':
                  'https://www.ufoelektronika.com/image/catalog/FOTO BRAND/2(7).png',
              'url': '/category/WASSER',
            },
            {
              'name': 'Samono',
              'image':
                  'https://www.ufoelektronika.com/image/catalog/FOTO BRAND/10(5).png',
              'url': '/category/samono',
            },
            {
              'name': 'Samsung',
              'image':
                  'https://www.ufoelektronika.com/image/catalog/logo brand/LOGO BRAND-01.png',
              'url': '/category/samsung',
            },
            {
              'name': 'Sanken',
              'image':
                  'https://www.ufoelektronika.com/image/catalog/logo brand/LOGO BRAND-25.png',
              'url': '/category/sanken',
            },
            {
              'name': 'Sanyo',
              'image':
                  'https://www.ufoelektronika.com/image/catalog/FOTO BRAND/9(4).png',
              'url': '/category/sanyo',
            },
            {
              'name': 'Serta',
              'image':
                  'https://www.ufoelektronika.com/image/catalog/FOTO BRAND/8(4).png',
              'url': '/category/serta',
            },
            {
              'name': 'TOSHIBA',
              'image':
                  'https://www.ufoelektronika.com/image/catalog/logo%20brand/LOGO%20BRAND-19.png',
              'url': '/category/TOSHIBA',
            },
            {
              'name': 'XIAOMI',
              'image':
                  'https://www.ufoelektronika.com/image/catalog/FOTO%20BRAND/1(5).png',
              'url': '/category/XIAOMI',
            },
            {
              'name': 'VIVO',
              'image':
                  'https://www.ufoelektronika.com/image/catalog/FOTO BRAND/3(8).png',
              'url': '/category/VIVO',
            },
            {
              'name': 'WASSER',
              'image':
                  'https://www.ufoelektronika.com/image/catalog/FOTO BRAND/2(7).png',
              'url': '/category/WASSER',
            },
          ];

          page++;
        });

        // Scroll to the top after resetting the list
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  Future<void> _loadMoreData() async {
    // Simulate a refresh operation (e.g., fetching updated data)
    await Future.delayed(
      const Duration(milliseconds: 500),
      () {
        setState(() {
          // dummy fetch data
          if (page < 10) {
            brands.addAll([
              {
                'name': 'Samono',
                'image':
                    'https://www.ufoelektronika.com/image/catalog/FOTO BRAND/10(5).png',
                'url': '/category/samono',
              },
              {
                'name': 'Samsung',
                'image':
                    'https://www.ufoelektronika.com/image/catalog/logo brand/LOGO BRAND-01.png',
                'url': '/category/samsung',
              },
              {
                'name': 'Sanken',
                'image':
                    'https://www.ufoelektronika.com/image/catalog/logo brand/LOGO BRAND-25.png',
                'url': '/category/sanken',
              },
              {
                'name': 'Sanyo',
                'image':
                    'https://www.ufoelektronika.com/image/catalog/FOTO BRAND/9(4).png',
                'url': '/category/sanyo',
              },
              {
                'name': 'Serta',
                'image':
                    'https://www.ufoelektronika.com/image/catalog/FOTO BRAND/8(4).png',
                'url': '/category/serta',
              },
              {
                'name': 'TOSHIBA',
                'image':
                    'https://www.ufoelektronika.com/image/catalog/logo%20brand/LOGO%20BRAND-19.png',
                'url': '/category/TOSHIBA',
              },
              {
                'name': 'XIAOMI',
                'image':
                    'https://www.ufoelektronika.com/image/catalog/FOTO%20BRAND/1(5).png',
                'url': '/category/XIAOMI',
              },
              {
                'name': 'VIVO',
                'image':
                    'https://www.ufoelektronika.com/image/catalog/FOTO BRAND/3(8).png',
                'url': '/category/VIVO',
              },
              {
                'name': 'WASSER',
                'image':
                    'https://www.ufoelektronika.com/image/catalog/FOTO BRAND/2(7).png',
                'url': '/category/WASSER',
              },
            ]);

            page++;
          } else {
            hasMoreData = false;
          }
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();

    // fetch data when scroll
    _scrollController.addListener(() {
      if (hasMoreData) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.position.pixels;
        double screenHeight = MediaQuery.of(context).size.height;
        double threshold = screenHeight * 0.4; // 40% of screen height

        if (maxScroll - currentScroll <= threshold) {
          // Almost reach the bottom, load more data
          _loadMoreData();
        }
      }
    });

    _fetchData();
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  // urutkan
  orderBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 0,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => ModalBottomSheetDefault(
          title: 'Status Pesanan',
          closeButtonLeft: true,
          child: (scrollController) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        order = {
                          'sort':
                              order['sort'] == 'name' && order['order'] == 'asc'
                                  ? null
                                  : 'name',
                          'order':
                              order['sort'] == 'name' && order['order'] == 'asc'
                                  ? null
                                  : 'asc',
                        };

                        page = 1;
                        hasMoreData = true;
                      });

                      _fetchData();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColor.grayBorderBottom,
                          ),
                          bottom: BorderSide(
                            color: AppColor.grayBorderBottom,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nama Brand A - Z',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (order['sort'] == 'name' &&
                              order['order'] == 'asc')
                            const Icon(
                              Icons.check,
                              color: AppColor.primaryColor,
                            ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        order = {
                          'sort': order['sort'] == 'name' &&
                                  order['order'] == 'desc'
                              ? null
                              : 'name',
                          'order': order['sort'] == 'name' &&
                                  order['order'] == 'desc'
                              ? null
                              : 'desc',
                        };

                        page = 1;
                        hasMoreData = true;
                      });

                      _fetchData();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColor.grayBorderBottom,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nama Brand Z - A',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (order['sort'] == 'name' &&
                              order['order'] == 'desc')
                            const Icon(
                              Icons.check,
                              color: AppColor.primaryColor,
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UEAppBar(
        title: null,
        searchHint: "Cari Brand", 
        onSearchSubmitted: (value) {
          setState(() {
            page = 1;
            hasMoreData = true;
          });

          _fetchData();
        },
      ),
      body: DefaultLayout(
        child: Column(
          children: [
            // filter
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              color: Colors.white,
              child: Row(
                children: [
                  OutlinedButton(
                    style: order['sort'] == 'manufacturer_id' &&
                            order['order'] == 'desc'
                        ? AppButton.outlineGrayActive
                        : AppButton.outlineGray,
                    onPressed: () {
                      setState(() {
                        order = {
                          'sort': order['sort'] == 'manufacturer_id' &&
                                  order['order'] == 'desc'
                              ? null
                              : 'manufacturer_id',
                          'order': order['sort'] == 'manufacturer_id' &&
                                  order['order'] == 'desc'
                              ? null
                              : 'desc',
                        };

                        page = 1;
                        hasMoreData = true;
                      });

                      _fetchData();
                    },
                    child: const Text('Terbaru'),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    style: order['sort'] == 'name' &&
                            (order['order'] == 'asc' ||
                                order['order'] == 'desc')
                        ? AppButton.outlineGrayActive
                        : AppButton.outlineGray,
                    onPressed: () => orderBottomSheet(context),
                    child: Row(
                      children: [
                        Text(order['sort'] == 'name'
                            ? order['order'] == 'asc'
                                ? 'Nama Brand A - Z'
                                : 'Nama Brand Z - A'
                            : 'Urutkan'),
                        const SizedBox(width: 5),
                        const SizedBox(
                          width: 20,
                          child: Icon(
                            Icons.expand_more,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // brand list
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      // brand items
                      GridView.builder(
                        itemCount: brands.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Get.toNamed(brands[index]['url']),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              color: Colors.white,
                              child: UEImage2(brands[index]['image']),
                            ),
                          );
                        },
                      ),

                      // indicator
                      if (hasMoreData)
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      if (!hasMoreData)
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text('Sudah Tidak Ada Brand Lagi'),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
