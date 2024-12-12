

import 'package:ufo_elektronika/models/product_filter.dart';
import 'package:ufo_elektronika/screens/category/category_response.dart';

enum Sort {
  populer, terbaru, terlaris
}

extension SortParam on Sort {
  String get param {
    switch (this) {
      case Sort.populer: return "rating";
      case Sort.terbaru: return "p.date_added";
      case Sort.terlaris: return "total_sales";
    }
  }

  String get buttonText {
    switch (this) {
      case Sort.populer: return "Populer";
      case Sort.terbaru: return "Terbaru";
      case Sort.terlaris: return "Terlaris";
    }
  }
}

class CategoryParam {
  final String categoryId;
  final int currentPage;
  final Sort? sort;
  final String? order;
  final double? minPrice;
  final double? maxPrice;
  final List<ProductFilter>? brands;
  final List<CategoryFiltersListDetail>? filters;

  CategoryParam({
    required this.categoryId,
    required this.currentPage,
    this.sort,
    this.order,
    this.minPrice,
    this.maxPrice,
    this.brands,
    this.filters
  });

  CategoryParam copyWith({
    String? categoryId,
    int? currentPage,
    Sort? sort,
    String? order,
    double? minPrice,
    double? maxPrice,
    List<ProductFilter>? brands,
    List<CategoryFiltersListDetail>? filters
  }) {
    return CategoryParam(
      categoryId: categoryId ?? this.categoryId,
      currentPage: currentPage ?? this.currentPage,
      sort: sort ?? this.sort,
      order: order ?? this.order,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      brands: brands ?? this.brands,
      filters: filters ?? this.filters
    );
  }

  CategoryParam reset() {
    return CategoryParam(currentPage: currentPage, categoryId: categoryId);
  }

  CategoryParam resetSort() {
    return CategoryParam(categoryId: categoryId, currentPage: 1, sort: null, order: null, minPrice: minPrice, maxPrice: maxPrice, brands: brands);
  }
}