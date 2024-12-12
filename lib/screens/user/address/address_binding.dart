import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/user/address/address_controller.dart';
import 'package:ufo_elektronika/screens/user/address/address_repository.dart';

class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressRepository>(() => AddressRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => AddressController(repository: Get.find()));
  }
}