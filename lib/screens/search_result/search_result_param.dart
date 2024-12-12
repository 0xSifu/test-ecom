import 'package:ufo_elektronika/screens/category/category_param.dart';
import 'package:ufo_elektronika/screens/search_result/search_result_response.dart';

class SearchResultParam {
  final String keyword;
  final int page;
  final int? minPrice;
  final int? maxPrice;
  final int? maxPriceForFilter;
  final List<Category>? categories;
  final List<Category> categoriesForFilter;
  final Sort? sort;
  final String? order;

  SearchResultParam({
    required this.keyword,
    this.page = 1,
    this.minPrice,
    this.maxPrice,
    this.maxPriceForFilter,
    this.categories,
    this.categoriesForFilter = const [],
    this.sort,
    this.order
  });
  

  SearchResultParam resetSort() {
    return SearchResultParam(
      keyword: keyword, 
      page: 1, 
      sort: null, 
      order: null, 
      minPrice: minPrice, 
      maxPrice: maxPrice,
      categories: categories,
      maxPriceForFilter: maxPriceForFilter,
      categoriesForFilter: categoriesForFilter
    );
  }

  SearchResultParam copyWith({
    String? keyword,
    int? page,
    int? minPrice,
    int? maxPrice,
    int? maxPriceForFilter,
    List<Category>? categories,
    List<Category>? categoriesForFilter,
    Sort? sort,
    String? order,
  }) {
    return SearchResultParam(
      keyword: keyword ?? this.keyword,
      page: page ?? this.page,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      maxPriceForFilter: maxPriceForFilter ?? this.maxPriceForFilter,
      categories: categories ?? this.categories,
      categoriesForFilter: categoriesForFilter ?? this.categoriesForFilter,
      sort: sort ?? this.sort,
      order: order ?? this.order,
    );
  }
}
