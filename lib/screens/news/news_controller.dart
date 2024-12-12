import 'package:ufo_elektronika/screens/news/news_repository.dart';
import 'package:ufo_elektronika/screens/news/news_response.dart';
import 'package:ufo_elektronika/shared/utils/state_controller.dart';

class NewsController extends StateController<NewsResponse> {

  final NewsRepository _repository;
  NewsController({required NewsRepository repository}): _repository = repository;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() {
    futurize(_repository.getNews);
  }
}