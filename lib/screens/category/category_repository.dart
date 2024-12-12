import 'package:dio/dio.dart';
import 'package:ufo_elektronika/models/product_filter.dart';
import 'package:ufo_elektronika/screens/category/category_param.dart';
import 'package:ufo_elektronika/screens/category/category_response.dart';
import 'package:ufo_elektronika/screens/category/filter/brand_category_response.dart';
import 'package:ufo_elektronika/screens/category/official_brand_response.dart';
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';

abstract class CategoryRepository {
  Future<CategoryResponse> getCategory(CategoryParam param);
  Future<List<ProductFilter>> getAllBrands({required String categoryId});
  Future<List<Product>> getClickAndCollect();
  Future<OfficialBrandsResponse> getOfficialBrands();
  Future<List<Product>> getBrand({required String manufacturerId});
}

class CategoryRepositoryImpl extends CategoryRepository {
  final Dio _dio;
  CategoryRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<CategoryResponse> getCategory(CategoryParam param) async {
    String path = "home/categories&path=${param.categoryId}&page=${param.currentPage}";
    if (param.sort != null) {
      path += "&sort=${param.sort!.param}";
    }
    if (param.order != null) {
      path += "&order=${param.order}";
    }
    if (param.minPrice != null) {
      path += "&filter_min_price=${param.minPrice?.toInt()}";
    }
    if (param.maxPrice != null) {
      path += "&filter_max_price=${param.maxPrice?.toInt()}";
    }
    if (param.brands != null && param.brands!.isNotEmpty) {
      path += "&filter_brand=${param.brands!.map((e) => e.id).join(",")}";
    }
    if (param.filters != null && param.filters!.isNotEmpty) {
      path += "&filter=${param.filters!.map((e) => e.filterId).join(",")}";
    }
    final dioResp = await _dio.get(path);
    final res = CategoryResponse.fromMap(dioResp.data);
    return res;
  }

  @override
  Future<List<ProductFilter>> getAllBrands({required String categoryId}) async {
    final dioResp = await _dio.get("/categories/brand/brand_category&category_id=$categoryId");
    final res = FilterBrandCategoryResponse.fromMap(dioResp.data);
    final allBrands = res.manufacturer.map((e) => ProductFilter(id: e.manufacturerId ?? "", name: e.name ?? "")).toList();
    return allBrands;
  }

  @override
  Future<List<Product>> getClickAndCollect() async {
    final dioResp = await _dio.get("/home/product/click_and_collect");
    return List.from(dioResp.data["products"].map((e) => Product.fromMap(e)));
  }

  @override
  Future<OfficialBrandsResponse> getOfficialBrands() async {
    return OfficialBrandsResponse.fromMap((await _dio.get("categories/brand ")).data);
  }

  @override
  Future<List<Product>> getBrand({required String manufacturerId}) async {
    final dioResp = await _dio.get("/categories/brand/info&manufacturer_id=$manufacturerId");
    return List.from(dioResp.data["products"].map((e) => Product.fromMap(e)));
  }
}