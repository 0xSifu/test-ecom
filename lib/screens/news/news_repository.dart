import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/news/news_response.dart';

abstract class NewsRepository {
  Future<NewsResponse> getNews();
}

class NewsRepositoryImpl extends NewsRepository {
  final Dio _dio;
  NewsRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<NewsResponse> getNews() async {
    final dioRes = await _dio.get("informations/blog");
    return NewsResponse.fromMap(dioRes.data);
  }
}