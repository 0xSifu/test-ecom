import 'package:get/get.dart';

import 'package:ufo_elektronika/screens/my_reviews/my_reviews_controller.dart';
import 'package:ufo_elektronika/screens/my_reviews/my_reviews_repository.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_controller.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_repository.dart';

class MyReviewsBinding extends Bindings {
  final String transactionControllerTag;
  MyReviewsBinding({
    required this.transactionControllerTag,
  });
  
  @override
  void dependencies() {
    Get.lazyPut<MyReviewsRepository>(() => MyReviewsRepositoryImpl(dio: Get.find()));
    Get.lazyPut<TransactionRepository>(() => TransactionRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => MyReviewsController(repository: Get.find(), transactionRepository: Get.find()));
    Get.lazyPut(() => TransactionController(repository: Get.find()), tag: transactionControllerTag);
  }
}
