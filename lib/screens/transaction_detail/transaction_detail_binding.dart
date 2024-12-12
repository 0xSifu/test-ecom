import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_repository.dart';
import 'package:ufo_elektronika/screens/transaction_detail/transaction_detail_controller.dart';
import 'package:ufo_elektronika/screens/transaction_detail/transaction_detail_repository.dart';

class TransactionDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionDetailRepository>(() => TransactionDetailRepositoryImpl(dio: Get.find()));
    Get.lazyPut<TransactionRepository>(() => TransactionRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => TransactionDetailController(repository: Get.find(), transactionRepository: Get.find()));
  }
}