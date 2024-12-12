import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_controller.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_repository.dart';

class VoucherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoucherRepository>(() => VoucherRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => VoucherController(repository: Get.find()));
  }
}