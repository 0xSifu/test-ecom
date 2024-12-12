import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';
import 'package:ufo_elektronika/screens/home/widgets/recommendation/recommendation_repository.dart';
import 'package:ufo_elektronika/shared/utils/state_controller.dart';

class RecommendationController extends StateController<SuperDealResponse> {

  final RecommendationRepository _repository;
  RecommendationController({required RecommendationRepository repository}): _repository = repository;

  @override
  void onInit() {
    super.onInit();
    futurize(_repository.getRecommendation);
  }
}