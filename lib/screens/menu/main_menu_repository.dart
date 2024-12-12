import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/menu/menu_response.dart';

abstract class MainMenuRepository {
  Future<MenuResponse> getMenus();
}

class MainMenuRepositoryImpl extends MainMenuRepository {
  final Dio _dio;
  MainMenuRepositoryImpl({required Dio dio}): _dio = dio;
  
  @override
  Future<MenuResponse> getMenus() async {
    final dioResp = await _dio.get("categories/menu");
    final resp = MenuResponse.fromMap(dioResp.data);
    return resp;
  }
}