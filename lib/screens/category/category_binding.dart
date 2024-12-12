import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/category/category_controller.dart';
import 'package:ufo_elektronika/screens/category/category_repository.dart';
import 'package:ufo_elektronika/screens/category/filter/filter_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryRepository>(() => CategoryRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => CategoryController(repository: Get.find()));
    Get.lazyPut(() => FilterController(repository: Get.find()));
  }
}