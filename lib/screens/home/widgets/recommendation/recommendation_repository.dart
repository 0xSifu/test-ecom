import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';

abstract class RecommendationRepository {
  Future<SuperDealResponse> getRecommendation();
}

class RecommendationRepositoryImpl extends RecommendationRepository {
  final Dio _dio;
  RecommendationRepositoryImpl({required Dio dio}): _dio = dio;
  
  @override
  Future<SuperDealResponse> getRecommendation() async {
    final dioRes = await _dio.get("home/recomended");
    final res = SuperDealResponse.fromMap(dioRes.data);
    return res;
  }
}