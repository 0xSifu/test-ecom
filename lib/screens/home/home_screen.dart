import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart' as sizer;
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';
import 'package:ufo_elektronika/screens/home/home_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/banner/banner_image_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/bestseller/bestseller_list_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/flash_sale/flash_sale_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/main_banner/main_banner_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/official_brands/official_brands_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/promo_pembayaran/promo_pembayaran.dart';
import 'package:ufo_elektronika/screens/home/widgets/promo_pembayaran/promo_pembayaran_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/promo_popup/promo_popup_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/recommendation_product/recommendation_product.dart';
import 'package:ufo_elektronika/screens/home/widgets/recommendation_product/recommendation_product_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/super_deal/superdeal_list_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/banner/banner_image.dart';
import 'package:ufo_elektronika/screens/home/widgets/bestseller/bestseller_list.dart';
import 'package:ufo_elektronika/screens/home/widgets/flash_sale/flash_sale_list.dart';
import 'package:ufo_elektronika/screens/home/widgets/main_banner/main_banner.dart';
import 'package:ufo_elektronika/screens/home/widgets/main_menu/main_menu.dart';
import 'package:ufo_elektronika/screens/home/widgets/official_brands/official_brands.dart';
import 'package:ufo_elektronika/screens/home/widgets/super_deal/superdeal_list.dart';
import 'package:ufo_elektronika/widgets/appbar/action_bar_widget.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar_search_input.dart';
import 'package:ufo_elektronika/widgets/tiles/product_tile.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final recommendationProductController =
        Get.find<RecommendationProductController>();
    Get.find<PromoPopupController>();

    return Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(34),
            child: controller.obx((state) {
              return const UEAppBar(transparent: false, title: null);
            })),
        body: RefreshIndicator(
          onRefresh: () async {
            Get.find<SuperDealController>().onInit();
            Get.find<OfficialBrandsController>().onInit();
            Get.find<MainBannerController>().onInit();
            Get.find<FlashSaleController>().onInit();
            Get.find<BestSellerController>().onInit();
            Get.find<BannerImageController>().onInit();
            Get.find<PromoPembayaranController>().onInit();
            recommendationProductController.load();
          },
          child: recommendationProductController.obx(
              (recommendations) => main(context, recommendations,
                  scrollController, recommendationProductController),
              onLoading: main(context, null, scrollController,
                  recommendationProductController)),
        ));
  }

  Widget main(
    BuildContext context,
    SuperDealResponse? recommendations,
    ScrollController scrollController,
    RecommendationProductController recommendationProductController,
  ) =>
      controller.obx((homeState) {
        if (homeState == null) {
          return const SafeArea(
              child: Center(child: CircularProgressIndicator()));
        }
        final recommendationNoOfColumn =
            sizer.Device.screenType == sizer.ScreenType.tablet
                ? (sizer.Device.safeWidth / 200).ceil()
                : 2;
        return SafeArea(
          child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                controller: scrollController
                  ..addListener(() {
                    controller.onOffsetChanged(scrollController.offset);
                  }),
                itemCount: HomeSection.values.length +
                    ((recommendations?.products.length ?? 0) ~/
                        recommendationNoOfColumn),
                itemBuilder: (context, index) {
                  if (HomeSection.values.length > index) {
                    final section = HomeSection.values[index];
                    switch (section) {
                      case HomeSection.MainBanner:
                        return const MainBanner();
                      case HomeSection.MainMenu:
                        return const MainMenu();
                      case HomeSection.Banner:
                        return const BannerImage();
                      case HomeSection.FlashSale:
                        return const FlashSaleList();
                      case HomeSection.OfficialBrands:
                        return const OfficialBrands();
                      case HomeSection.SuperDeal:
                        return const SuperDealList();
                      case HomeSection.PromoPembayaran:
                        return const PromoPembayaran();
                      case HomeSection.BestSeller:
                        return const BestSellerList();
                      case HomeSection.Recommendation:
                        return const RecommendationProduct();
                      default:
                        return Text("Not Implemented $section");
                    }
                  }
                  final recommendationProducts =
                      recommendations?.products ?? [];
                  int currentRow = (index - HomeSection.values.length) *
                      recommendationNoOfColumn;
                  // ignore: prefer_const_constructors
                  final row = Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                    ],
                  );

                  for (var col = 0; col < recommendationNoOfColumn; col++) {
                    if (recommendationProducts.length > currentRow + col) {
                      final product = recommendationProducts[currentRow + col];
                      row.children.add(
                          Expanded(child: NewProducttile(product: product)));
                    } else {
                      row.children.add(Expanded(child: Container()));
                    }
                    row.children.add(const SizedBox(width: 7));
                  }
                  row.children.removeLast();
                  row.children.add(const SizedBox(width: 10));
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.5),
                      child: row);
                },
              )),
        );
      });
}

enum HomeSection {
  // ignore: constant_identifier_names
  MainBanner,
  MainMenu,
  Banner,
  FlashSale,
  OfficialBrands,
  SuperDeal,
  PromoPembayaran,
  BestSeller,
  Recommendation
}
