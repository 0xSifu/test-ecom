import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';
import 'package:ufo_elektronika/screens/home/repositories/home_repository.dart';
import 'package:ufo_elektronika/shared/utils/state_controller.dart';

class RecommendationProductController extends StateController<SuperDealResponse?> {
  final HomeRepository _repository;
  RecommendationProductController({required HomeRepository repository}): _repository = repository;

  void load() {
    futurize(_repository.loadRecommendationProduct);
  }
}