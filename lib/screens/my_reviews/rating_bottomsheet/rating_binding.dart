import 'package:get/get.dart';

import 'package:ufo_elektronika/screens/my_reviews/rating_bottomsheet/rating_controller.dart';
import 'package:ufo_elektronika/screens/my_reviews/rating_bottomsheet/rating_repository.dart';
import 'package:ufo_elektronika/screens/transaction/transactions_response.dart';

class RatingBinding extends Bindings {
  final List<OrderProduct> products;
  final String orderId;
  final String dateAdded;
  RatingBinding({
    required this.products,
    required this.orderId,
    required this.dateAdded,
  });
  
  @override
  void dependencies() {
    Get.lazyPut<RatingRepository>(() => RatingRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => RatingController(repository: Get.find(), products: products, orderId: orderId, dateAdded: dateAdded), tag: orderId);
  }
}
