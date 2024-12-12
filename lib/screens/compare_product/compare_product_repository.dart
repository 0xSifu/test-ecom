import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/compare_product/compare_product_add_response.dart';
import 'package:ufo_elektronika/screens/compare_product/compare_product_list_response.dart';

abstract class CompareProductRepository {
  Future<ProductCompareAddResponse> addToCompareProduct({required String productId});
  Future<ProductCompareAddResponse> removeFromCompareProduct({required String productId});
  Future<ProductCompareListResponse> getCompareProductList();
}

class CompareProductRepositoryImpl extends CompareProductRepository {
  final Dio _dio;
  CompareProductRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<ProductCompareAddResponse> addToCompareProduct({required String productId}) async {
    final dioResp = await _dio.post("product/compare/add", data: FormData.fromMap({
      "product_id": productId
    }));
    final resp = jsonEncode(dioResp.data);
    return ProductCompareAddResponse.fromMap(dioResp.data);
  }

  @override
  Future<ProductCompareAddResponse> removeFromCompareProduct({required String productId}) async {
    final dioResp = await _dio.post("product/compare&remove=$productId");
    final resp = jsonEncode(dioResp.data);
    return ProductCompareAddResponse.fromMap(dioResp.data);
  }

  @override
  Future<ProductCompareListResponse> getCompareProductList() async {
    final dioResp = await _dio.get("product/compare");
    final resp = jsonEncode(dioResp.data);
    final res = ProductCompareListResponse.fromMap(dioResp.data);
    return res;
  }

}