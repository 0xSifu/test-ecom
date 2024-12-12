import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/constants/buttons.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/enums.dart';
import 'package:ufo_elektronika/screens/category/category_controller.dart';
import 'package:ufo_elektronika/screens/category/category_param.dart';
import 'package:ufo_elektronika/screens/category/filter/filter_bottomsheet.dart';
import 'package:ufo_elektronika/screens/main/main_controller.dart';
import 'package:ufo_elektronika/screens/main/main_screen.dart';
import 'package:ufo_elektronika/widgets/appbar/action_bar_widget.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar_search_input.dart';
import 'package:ufo_elektronika/widgets/image.dart';
import 'package:ufo_elektronika/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:ufo_elektronika/widgets/tiles/product_tile.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:sizer/sizer.dart' as sizer;

class CategoryScreen extends GetView<CategoryController> {
  static const routeName = "/category";
  static const clickAndCollect = "clickAndCollect";
  static const officialBrands = "officialBrands";
  static const brand = "brand";
  final String? id;
  final String? type;
  const CategoryScreen({super.key, required this.id, required this.type});

  @override
  Widget build(BuildContext context) {
    controller.load(categoryId: id, categoryType: type);
    final productNoOfColumn = sizer.Device.screenType == sizer.ScreenType.tablet ? (sizer.Device.safeWidth / 200).ceil() : 2;
    return Scaffold(
      appBar: const UEAppBar(title: null),
      body: Obx(() {
        return CustomScrollView(
          slivers: [
            /* ------------------------------ header image ------------------------------ */
            SliverToBoxAdapter(
              child: Column(
                children: [
                  if (controller.banners.isNotEmpty)
                    UEImage2(controller.banners.firstOrNull?.image ?? "")
                ],
              ),
            ),

            /* ------------------------------- filter list ------------------------------ */
            if (type != clickAndCollect && type != officialBrands && type != brand)
              SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                toolbarHeight: 38,
                flexibleSpace: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: filterList(context),
                ),
              ),

            /* ------------------------------ product list ------------------------------ */
            SliverToBoxAdapter(
              child: Column(
                children: [
                  for (var row = 0; row < (controller.products.length ~/ productNoOfColumn); row++)
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: 10),
                            Expanded(child: Builder(
                              builder: (context) {
                                final rowWidget = Row(children: []);
                                for (var col = 0; col < productNoOfColumn; col++) {
                                  if (controller.products.length > row * productNoOfColumn + col) {
                                    rowWidget.children.add(Expanded(child: NewProducttile(
                                      product: controller.products[row * productNoOfColumn + col],
                                      productTileType: id == "flash_sale" ? ProductTileType.flashSale : null)));
                                  }
                                  else {
                                    rowWidget.children.add(Expanded(child: Container()));
                                  }
                                  rowWidget.children.add(const SizedBox(width: 7));
                                }
                                rowWidget.children.removeLast(); 

                                return rowWidget;
                              },
                            )),
                            const SizedBox(width: 10),
                          ],
                        ),
                        const SizedBox(height: 7),
                      ],
                    )
                ],
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 4/2.5,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: controller.officialBrands.length,
                  (context, index) {
                    final brand = controller.officialBrands[index];
                    return InkWell(
                      onTap: () => brand.href != null ? Get.toNamed(brand.href!) : null,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(6)
                        ),
                        child: UEImage2(brand.image ?? ""),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (controller.loaded.value && controller.products.isEmpty && controller.officialBrands.isEmpty)
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Image.asset('assets/icon/ufomen_sad.webp'),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Tidak ada ${type == officialBrands ? "brand" : "produk"} untuk dicantumkan dalam kategori ini.',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 15),
                    FilledButton(
                      onPressed: () {
                        Get.find<MainController>().tabController.index = 0;
                        while (Get.currentRoute != MainScreen.routeName) {
                          Get.back();
                        }
                      },
                      child: const Text('Lanjutkan'),
                    ),
                  ],
                ),
              ),

            /* ------------------------------ load more ------------------------------ */
            if (type != clickAndCollect && type != officialBrands && type != brand)
              SliverToBoxAdapter(
                child: controller.canLoadMore != true ? Container() : VisibilityDetector(
                  key: const Key("load_mores"), 
                  onVisibilityChanged: (visibilityFraction) {
                    if (visibilityFraction.visibleFraction >= 0.2) {
                      controller.loadMore();
                    }
                  }, 
                  child: const VerticalProductShimmer()
                ),
              ),
            if (type == clickAndCollect || type == officialBrands && type != brand)
              SliverToBoxAdapter(
                child: SafeArea(top: false, child: Container()),
              )
          ],
        );
      }),
    );
  }

  Widget filterList(BuildContext context) => Row(
    children: [
      SizedBox(
        width: 60,
        height: 28,
        child: OutlinedButton(
          style: const ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
          ),
          onPressed: () async {
            final newParam = await showModalBottomSheet<CategoryParam?>(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              elevation: 0,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
              ),
              builder: (context) {
                return FilterBottomSheet(
                  param: controller.currentParam.value, 
                  otherFilters: controller.otherFilters,
                  maxPrice: controller.filterMaxPrice.value,
                );
              },
            );
            if (newParam != null) {
              controller.applyFilter(newParam);
            }
          },
          child: SizedBox(
            height: 20,
            child: (controller.noOfFilterApplied) > 0
                ? Container(
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius:
                          BorderRadius.circular(6),
                    ),
                    child: Text(
                      controller.noOfFilterApplied.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  )
                : Image.asset(
                    'assets/icon/filter.png',
                    color: AppColor.grayText,
                  ),
          ),
        ),
      ),
      Expanded(
        child: SizedBox(
          height: 28,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: Sort.values.map((e) => Row(
                children: [
                  const SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () {
                      controller.sortBy(e);
                    },
                    style: controller.currentParam.value.sort != e
                        ? AppButton.outlineGray
                        : AppButton.outlineGrayActive,
                    child: Text(e.buttonText),
                  )
                ],
              )).toList(),
            ),
          ),
        ),
      ),
    ],
  );
}