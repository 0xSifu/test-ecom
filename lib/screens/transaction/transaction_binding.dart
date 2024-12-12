import 'package:get/get.dart';

import 'package:ufo_elektronika/screens/transaction/transaction_controller.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_repository.dart';

class TransactionBinding extends Bindings {
  final String? tag;
  TransactionBinding({
    this.tag
  });
  
  @override
  void dependencies() {
    Get.put<TransactionRepository>(TransactionRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => TransactionController(repository: Get.find()), tag: tag);
  }
}
