import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/category/category_param.dart';
import 'package:ufo_elektronika/screens/search_result/search_result_param.dart';
import 'package:ufo_elektronika/screens/search_result/search_result_response.dart';

abstract class SearchResultRepository {
  Future<SearchResultResponse> search({required SearchResultParam param});
}

class SearchResultRepositoryImpl extends SearchResultRepository {
  final Dio _dio;
  SearchResultRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<SearchResultResponse> search({required SearchResultParam param}) async {
    String path = "home/search&search=${param.keyword}&page=${param.page}";

    if (param.sort != null) {
      path += "&sort=${param.sort!.param}";
    }
    if (param.order != null) {
      path += "&order=${param.order}";
    }
    if (param.categories != null && param.categories!.isNotEmpty) {
      path += "&filter_category=${param.categories!.map((e) => e.categoryId).join(",")}";
    }

    if (param.minPrice != null) {
      path += "&filter_min_price=${param.minPrice}";
    }
    if (param.maxPrice != null) {
      path += "&filter_max_price=${param.maxPrice}";
    }
    final dioResp = await _dio.get(path);
    // print(jsonEncode(dioResp.data));
    final resp = SearchResultResponse.fromMap(dioResp.data);
    return resp;
  }
}