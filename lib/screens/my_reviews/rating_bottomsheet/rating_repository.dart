import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/my_reviews/rating_bottomsheet/rating_request.dart';
import 'package:ufo_elektronika/screens/my_reviews/rating_bottomsheet/rating_response.dart';

abstract class RatingRepository {
  Future<RatingResponse> rate(RatingRequest request);
} 

class RatingRepositoryImpl extends RatingRepository {
  final Dio _dio;
  RatingRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<RatingResponse> rate(RatingRequest request) async {
    final map = await request.toMap();
    final dioResp = await _dio.post("/product/product_review/add", data: FormData.fromMap(
      map
    ));
    final resp = jsonEncode(dioResp.data);
    return RatingResponse.fromMap(dioResp.data);
  }
}