import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/category/category_param.dart';
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';
import 'package:ufo_elektronika/screens/search_result/search_result_param.dart';
import 'package:ufo_elektronika/screens/search_result/search_result_repository.dart';
import 'package:ufo_elektronika/screens/search_result/search_result_response.dart';

class SearchResultController extends GetxController {
  final SearchResultRepository _repository;
  final Rx<SearchResultParam> param;
  SearchResultController({required SearchResultRepository repository, required String keyword}): 
    _repository = repository, 
    param = Rx(SearchResultParam(keyword: keyword));

  final products = RxList<Product>();
  final loaded = false.obs;
  bool get canLoadMore => param.value.page != 0;

  int get noOfFilterApplied {
      int count = 0;
      // if (param.value.minPrice != null) count++;
      // if (param.value.maxPrice != null) count++;
      count += param.value.categories?.length ?? 0;
      return count;
  }

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void applyFilter(SearchResultParam param) {
    this.param.value = param.copyWith(page: 1);
    load();
  }

  void sortBy(Sort sort) {
    if (param.value.sort == sort) {
      param.value = param.value.resetSort();
    } else {
      param.value = param.value.copyWith(sort: sort, page: 1, order: "DESC");
    }
    load();
  }
  
  void loadMore() {
    load();
  }

  void load() {
    if (param.value.page == 0) return; // Means we reach end of page
    _repository.search(param: param.value)
      .then((value) {
        if (param.value.page == 1) {
          products.clear();
        }

        products.addAll(value.products);

        if (value.products.isNotEmpty) {
          param.value = param.value.copyWith(page: param.value.page + 1);
        } else {
          param.value = param.value.copyWith(page: 0);
        }

        param.value = param.value.copyWith(maxPriceForFilter: value.maxPrice?.max, categoriesForFilter: value.category);
        loaded.value = true;
      })
      .catchError((error) {
        loaded.value = true;
        final errorFromAPI = error is DioException ? error.response?.data["error"] : null;
        Get.showSnackbar(GetSnackBar(
          message: errorFromAPI ?? "Terjadi kesalahan. Silakan Coba Lagi.",
            duration: const Duration(seconds: 2),
        ));
        return error;
      });
  }
}