import 'package:ufo_elektronika/screens/home/entities/banner_official_brand_shop_response.dart';
import 'package:ufo_elektronika/screens/home/repositories/home_repository.dart';
import 'package:ufo_elektronika/shared/utils/state_controller.dart';

class BannerImageController extends StateController<BannerOfficialBrandShopResponse> {
  final HomeRepository _repository;
  BannerImageController({required HomeRepository repository}): _repository = repository;
  @override
  void onInit() {
    super.onInit();
    futurize(_repository.loadBannerOfficialBrandShop);
  }
}