import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/models/product_filter.dart';
import 'package:ufo_elektronika/screens/category/category_param.dart';
import 'package:ufo_elektronika/screens/category/category_repository.dart';
import 'package:ufo_elektronika/screens/category/category_response.dart';

class FilterController extends GetxController {
  final CategoryRepository _repository;
  FilterController({required CategoryRepository repository}): _repository = repository;

  final param = Rx<CategoryParam>(CategoryParam(categoryId: "", currentPage: 1));
  final allBrands = RxList<ProductFilter>([]);
  final filterKeyword = "".obs;
  final allOtherFilters = RxList<CategoryFiltersListDetail>();

  TextEditingController searchBrandController = TextEditingController();
  FocusNode brandTextFieldFocusNode = FocusNode();
  bool hasSetupBrandTextFieldFocusNode = false;


  List<ProductFilter> get brands {
    List<ProductFilter> brands = isShowingAllBrands.value ? allBrands : allBrands.take(5).toList();
    if (filterKeyword.value.isNotEmpty) {
      brands = allBrands.where((element) => element.name.toLowerCase().contains(filterKeyword.value.toLowerCase())).toList();
      brands = isShowingAllBrands.value ? brands : brands.take(5).toList();
    }
    return brands;
  }
  final isShowingAllBrands = false.obs;
  final isShowingOtherFilter = RxMap<CategoryFiltersList, bool>();

  void loadWith({required CategoryParam param}) {
    hasSetupBrandTextFieldFocusNode = false;
    _repository.getAllBrands(categoryId: param.categoryId)
      .then((value) {
        allBrands.assignAll(value);
      })
      .catchError((error) {

      });
  }

  void sortBy(Sort sort) {
    param.value = param.value.copyWith(sort: sort, currentPage: 1, order: "DESC");
  }

  void changeMinAndMaxPrice(RangeValues values) {
    param.value = param.value.copyWith(minPrice: values.start, maxPrice: values.end);
  }

  void removeBrand(ProductFilter brand) {
    final brands = param.value.brands ?? [];
    brands.removeWhere((element) => element.id == element.id || element.name.toLowerCase() == element.name.toLowerCase());
    param.value = param.value.copyWith(brands: brands);
  }

  void addBrand(ProductFilter brand) {
    final brands = param.value.brands ?? [];
    brands.add(brand);
    param.value = param.value.copyWith(brands: brands);
  }

  void removeFilter(CategoryFiltersListDetail detail) {
    final filters = param.value.filters ?? [];
    filters.removeWhere((element) => element.filterId == detail.filterId || element.filterGroupId == detail.filterGroupId);
    param.value = param.value.copyWith(filters: filters);
  }

  void addFilter(CategoryFiltersListDetail detail) {
    final brands = param.value.filters ?? [];
    brands.add(detail);
    param.value = param.value.copyWith(filters: brands);
  }

  void showMoreBrand() {
    isShowingAllBrands.value = true;
  }

  void showLessBrand() {
    isShowingAllBrands.value = false;
  }

  void reset() {
    param.value = param.value.reset();
  }

}