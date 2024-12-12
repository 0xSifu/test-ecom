import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/product/entities/product_detail_response.dart';

abstract class ProductRepository {
  Future<ProductDetailResponse> getProduct(String productId);
}

class ProductRepositoryImpl extends ProductRepository {
  final Dio _dio;
  ProductRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<ProductDetailResponse> getProduct(String productId) async {
    final dioResp = await _dio.get("home/product&product_id=$productId");
    final resp = jsonEncode(dioResp.data);
    final res = ProductDetailResponse.fromMap(dioResp.data);
    return res;
  }
}