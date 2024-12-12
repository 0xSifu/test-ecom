import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';

abstract class AppBarRepository {
  Future<SearchResponse> search(String keyword);
}

class AppBarRepositoryImpl extends AppBarRepository {
  final Dio _dio;
  AppBarRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<SearchResponse> search(String keyword) async {
    final dioRes = await _dio.get("https://www.ufoelektronika.com/index.php?route=product/json&search=$keyword");
    final n = List.from(jsonDecode(dioRes.data)).map((e) => Product.fromMap(e)).toList();
    return SearchResponse(products: n);
  }
}