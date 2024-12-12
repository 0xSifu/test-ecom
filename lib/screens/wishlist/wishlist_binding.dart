import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/home/widgets/recommendation/recommendation_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/recommendation/recommendation_repository.dart';
import 'package:ufo_elektronika/screens/wishlist/wishlist_repository.dart';

class WishlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WishlistRepository>(() => WishlistRepositoryImpl(dio: Get.find()));
    Get.lazyPut<RecommendationRepository>(() => RecommendationRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => RecommendationController(repository: Get.find()));
  }
}