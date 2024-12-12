import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/address_add_update_controller.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/address_add_update_repository.dart';

class AddressAddUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressAddUpdateRepository>(() => AddressAddUpdateRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => AddressAddUpdateController(repository: Get.find()));
  }
}