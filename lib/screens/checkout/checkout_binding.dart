import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/checkout/checkout_controller.dart';
import 'package:ufo_elektronika/screens/checkout/checkout_repository.dart';
import 'package:ufo_elektronika/screens/user/address/address_repository.dart';
import 'package:ufo_elektronika/screens/user/update/user_update_repository.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_repository.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutRepository>(() => CheckoutRepositoryImpl(dio: Get.find()));
    Get.lazyPut<AddressRepository>(() => AddressRepositoryImpl(dio: Get.find()));
    Get.lazyPut<VoucherRepository>(() => VoucherRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => CheckoutController(
      repository: Get.find(), 
      addressRepository: Get.find(),
      voucherRepository: Get.find(),
      userUpdateRepository: UserUpdateRepositoryImpl(dio: Get.find()),
      midtransProvider: Get.find()
    ));
  }
}