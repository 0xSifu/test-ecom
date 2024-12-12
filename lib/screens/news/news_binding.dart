import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/news/news_controller.dart';
import 'package:ufo_elektronika/screens/news/news_repository.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsRepository>(() => NewsRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => NewsController(repository: Get.find()));
  }
}