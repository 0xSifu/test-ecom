import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';
import 'package:ufo_elektronika/screens/home/repositories/home_repository.dart';
import 'package:ufo_elektronika/shared/utils/state_controller.dart';


class FlashSaleController extends StateController<FlashSaleResponse> {
  final HomeRepository _repository;
  FlashSaleController({required HomeRepository repository}): _repository = repository;
  @override
  void onInit() {
    super.onInit();
    futurize(_repository.loadFlashSale);
  }
}