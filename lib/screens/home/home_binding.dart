import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/home/home_controller.dart';
import 'package:ufo_elektronika/screens/home/repositories/home_repository.dart';
import 'package:ufo_elektronika/screens/home/widgets/banner/banner_image_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/bestseller/bestseller_list_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/flash_sale/flash_sale_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/main_banner/main_banner_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/official_brands/official_brands_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/promo_pembayaran/promo_pembayaran_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/promo_popup/promo_popup_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/recommendation_product/recommendation_product_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/super_deal/superdeal_list_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/youtube_live/youtube_live_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
      Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl(dio: Get.find()));
      Get.lazyPut(() => HomeController());
      Get.lazyPut(() => MainBannerController(repository: Get.find()));
      Get.lazyPut(() => BannerImageController(repository: Get.find()));
      Get.lazyPut(() => FlashSaleController(repository: Get.find()));
      Get.lazyPut(() => OfficialBrandsController(repository: Get.find()));
      Get.lazyPut(() => YoutubeLiveController(repository: Get.find()));
      Get.lazyPut(() => SuperDealController(repository: Get.find()));
      Get.lazyPut(() => PromoPembayaranController(repository: Get.find()));
      Get.lazyPut(() => BestSellerController(repository: Get.find()));
      Get.lazyPut(() => RecommendationProductController(repository: Get.find()));
      Get.lazyPut(() => PromoPopupController(repository: Get.find()));
  }
}