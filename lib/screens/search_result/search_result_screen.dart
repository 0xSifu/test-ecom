import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart' as sizer;
import 'package:ufo_elektronika/constants/buttons.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/category/category_param.dart';
import 'package:ufo_elektronika/screens/main/main_controller.dart';
import 'package:ufo_elektronika/screens/main/main_screen.dart';
import 'package:ufo_elektronika/screens/search_result/search_result_controller.dart';
import 'package:ufo_elektronika/screens/search_result/search_result_filter_bottomsheet.dart';
import 'package:ufo_elektronika/screens/search_result/search_result_param.dart';
import 'package:ufo_elektronika/widgets/appbar/action_bar_widget.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar_search_input.dart';
import 'package:ufo_elektronika/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:ufo_elektronika/widgets/tiles/product_tile.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SearchResultScreen extends GetView<SearchResultController> {

  static const routeName = "/search-result";

  final String keyword;
  const SearchResultScreen({super.key, required this.keyword});

  @override
  String? get tag => keyword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UEAppBar(title: null),
      body: Obx(() {
        return CustomScrollView(
          slivers: [

            /* ------------------------------- filter list ------------------------------ */
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              flexibleSpace: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                color: Colors.white,
                child: filterList(context),
              ),
            ),
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              toolbarHeight: 33,
              flexibleSpace: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    Image.asset("assets/icon/search-lightbulb.png", width: 24),
                    const SizedBox(width: 8),
                    const Text("Hasil pencarian untuk "),
                    Text("\"$keyword\"".toUpperCase(), style: const TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),

            /* ------------------------------ product list ------------------------------ */
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.64,
                  crossAxisCount: sizer.Device.screenType == sizer.ScreenType.tablet ? (sizer.Device.safeWidth / 200).ceil() : 2,
                  mainAxisSpacing: 7,
                  crossAxisSpacing: 7,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: controller.products.length,
                  (context, index) {
                    return NewProducttile(
                      product: controller.products[index]
                    );
                  },
                ),
              ),
            ),

            if (controller.loaded.value && controller.products.isEmpty)
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
                        'Tidak ada produk untuk dicantumkan dalam kata kunci ini.',
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
            SliverToBoxAdapter(
              child: controller.canLoadMore != true ? Container() : VisibilityDetector(
                key: const Key("load_mores"), 
                onVisibilityChanged: (visibilityFraction) {
                  if (visibilityFraction.visibleFraction >= 0.1) {
                    controller.loadMore();
                  }
                }, 
                child: const VerticalProductShimmer()
              ),
            ),
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
        child: OutlinedButton(
          style: const ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
          ),
          onPressed: () async {
            final newParam = await showModalBottomSheet<SearchResultParam?>(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              elevation: 0,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
              ),
              builder: (context) {
                return SearchResultFilterBottomsheet(param: controller.param.value);
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
                  style: controller.param.value.sort != e
                      ? AppButton.outlineGray
                      : AppButton.outlineGrayActive,
                  child: Text(e.buttonText),
                )
              ],
            )).toList(),
          ),
        ),
      ),
    ],
  );
}