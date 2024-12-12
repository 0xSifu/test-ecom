import 'package:dio/dio.dart';


abstract class MyReviewsRepository {
  // Future<MyReviewsResponse> getMyReviews();
}

class MyReviewsRepositoryImpl extends MyReviewsRepository {
  final Dio _dio;
  MyReviewsRepositoryImpl({required Dio dio}): _dio = dio;

  // @override
  // Future<MyReviewsResponse> getMyReviews() async {
  //   final dioRes = await _dio.get("informations/blog");
  //   return MyReviewsResponse.fromMap(dioRes.data);
  // }
}