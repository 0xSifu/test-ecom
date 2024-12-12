import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/search_result/search_result_controller.dart';
import 'package:ufo_elektronika/screens/search_result/search_result_repository.dart';

class SearchResultBinding extends Bindings {
  final String keyword;
  SearchResultBinding({required this.keyword});

  @override
  void dependencies() {
    Get.lazyPut<SearchResultRepository>(() => SearchResultRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => SearchResultController(repository: Get.find(), keyword: keyword), tag: keyword);
  }
}