import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/compare_product/compare_product_controller.dart';
import 'package:ufo_elektronika/screens/compare_product/compare_product_repository.dart';

class CompareProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompareProductRepository>(() => CompareProductRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => CompareProductController(repository: Get.find()));
  }
}