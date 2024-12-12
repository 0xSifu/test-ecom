import 'package:get/get.dart';

import 'package:ufo_elektronika/screens/refund/refund_controller.dart';
import 'package:ufo_elektronika/screens/refund/refund_repository.dart';

class RefundBinding extends Bindings {
  final String orderId;
  RefundBinding({
    required this.orderId,
  });
  
  @override
  void dependencies() {
    Get.lazyPut<RefundRepository>(() => RefundRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => RefundController(repository: Get.find(), orderId: orderId));
  }
}
