import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/home/entities/banner_main_response.dart';
import 'package:ufo_elektronika/screens/home/entities/banner_official_brand_shop_response.dart';
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';
import 'package:ufo_elektronika/screens/home/widgets/promo_pembayaran/promo_pembayaran_response.dart';

abstract class HomeRepository {
  Future<BannerMainResponse> loadBannerMain();
  Future<BannerOfficialBrandShopResponse> loadBannerOfficialBrandShop();
  Future<FlashSaleResponse> loadFlashSale();
  Future<BannerOfficialBrandShopResponse> loadOfficialBrands();
  Future<SuperDealResponse> loadSuperDeal();
  Future<SuperDealResponse> loadBestSeller();
  Future<SuperDealResponse> loadRecommendationProduct();
  Future<PromoPembayaranResponse> loadPromoPembayaran();
  Future<PopUpResponse> loadPopup();
}

class HomeRepositoryImpl extends HomeRepository {

  final Dio _dio;
  HomeRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<BannerMainResponse> loadBannerMain() async {
    
    final dioRes = await _dio.get("home/banner_main");
    final res = BannerMainResponse.fromMap(dioRes.data);
    return res;
  }

  @override
  Future<BannerOfficialBrandShopResponse> loadBannerOfficialBrandShop() async {
    final dioRes = await _dio.get("home/banner_official_brand_shop");
    final res = BannerOfficialBrandShopResponse.fromMap(dioRes.data);
    return res;
  }
  
  @override
  Future<FlashSaleResponse> loadFlashSale() async {
    final dioRes = await _dio.get("home/flash_sale");
    final res = FlashSaleResponse.fromMap(dioRes.data);
    return res;
  }

  @override
  Future<BannerOfficialBrandShopResponse> loadOfficialBrands() async {
    final dioRes = await _dio.get("home/banner_official_brand");
    final res = BannerOfficialBrandShopResponse.fromMap(dioRes.data);
    return res;
  }

  @override
  Future<SuperDealResponse> loadSuperDeal() async {
    final dioRes = await _dio.get("home/super_deal");
    final res = SuperDealResponse.fromMap(dioRes.data);
    return res;
  }

  @override
  Future<SuperDealResponse> loadBestSeller() async {
    final dioRes = await _dio.get("home/bestseller");
    final res = SuperDealResponse.fromMap(dioRes.data);
    return res;
  }

  @override
  Future<SuperDealResponse> loadRecommendationProduct() async {
    final dioRes = await _dio.get("home/recomended");
    final res = SuperDealResponse.fromMap(dioRes.data);
    return res;
  }

  @override
  Future<PromoPembayaranResponse> loadPromoPembayaran() async {
    final dioRes = await _dio.get("informations/promo_pembayaran");
    final res = PromoPembayaranResponse.fromMap(dioRes.data);
    return res;
  }

  @override
  Future<PopUpResponse> loadPopup() async {
    final dioResp = await _dio.get("home/popup");
    final res = PopUpResponse.fromMap(dioResp.data);
    return res;
  }

}