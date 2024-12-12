import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/home/widgets/recommendation/recommendation_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/recommendation/recommendation_repository.dart';

class RecommendationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecommendationRepository>(() => RecommendationRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => RecommendationController(repository: Get.find()));
  }
}