import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/checkout_payment_confirmation/manual/checkout_payment_manual_controller.dart';
import 'package:ufo_elektronika/screens/checkout_payment_confirmation/manual/checkout_payment_manual_repository.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_repository.dart';

class CheckoutPaymentManualBinding extends Bindings {
  final String redirectionUrl;
  CheckoutPaymentManualBinding({required this.redirectionUrl});
  @override
  void dependencies() {
    Get.lazyPut<CheckoutPaymentManualRepository>(() => CheckoutPaymentManualRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => CheckoutPaymentManualController(
      repository: Get.find(), 
      redirectionUrl: redirectionUrl,
      transactionRepository: TransactionRepositoryImpl(dio: Get.find())
    ));
  }
}