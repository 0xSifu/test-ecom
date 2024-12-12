import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/category/category_param.dart';
import 'package:ufo_elektronika/screens/category/category_repository.dart';
import 'package:ufo_elektronika/screens/category/category_response.dart';
import 'package:ufo_elektronika/screens/category/category_screen.dart';
import 'package:ufo_elektronika/screens/category/official_brand_response.dart';
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';

class CategoryController extends GetxController {
  final CategoryRepository _repository;
  CategoryController({required CategoryRepository repository}): _repository = repository;

  final products = RxList<Product>();
  final officialBrands = RxList<OfficialBrand>();
  final loaded = false.obs;
  final banners = RxList<BannerData>([]);
  final currentParam = Rx<CategoryParam>(CategoryParam(categoryId: "", currentPage: 1));
  final otherFilters = RxList<CategoryFiltersList>();
  final filterMaxPrice = Rx<double?>(null);
  int get noOfFilterApplied {
      int count = 0;
      if (currentParam.value.sort != null) count++;
      if (currentParam.value.minPrice != null) count++;
      if (currentParam.value.maxPrice != null) count++;
      count += currentParam.value.filters?.length ?? 0;
      count += currentParam.value.brands?.length ?? 0;
      return count;
  }

  bool get canLoadMore => currentParam.value.currentPage != 0;

  void hardRefresh() {
    currentParam.value = currentParam.value.copyWith(currentPage: 1);
    load();
  }

  void loadMore() {
    load();
  }

  void load({String? categoryId, String? categoryType}) async {
    if (categoryType == CategoryScreen.clickAndCollect) {
      try {
        final res = await _repository.getClickAndCollect();
        products.addAll(res);
        loaded.value = true;
      } catch (error) {
        Get.showSnackbar(const GetSnackBar(
          message: "Terjadi kesalahan. Silakan coba lagi",
          duration: Duration(seconds: 2),
        ));
      } 

    } else if (categoryType == CategoryScreen.officialBrands) {
      try {
        final res = await _repository.getOfficialBrands();
        officialBrands.addAll(res.categories);
        loaded.value = true;
      } catch (error) {
        Get.showSnackbar(const GetSnackBar(
          message: "Terjadi kesalahan. Silakan coba lagi",
          duration: Duration(seconds: 2),
        ));
      }
    } else if (categoryType == CategoryScreen.brand) {
      if (categoryId != null) {
        try {
          final res = await _repository.getBrand(manufacturerId: categoryId);
          products.addAll(res);
          loaded.value = true;
        } catch (error) {
          Get.showSnackbar(const GetSnackBar(
            message: "Terjadi kesalahan. Silakan coba lagi",
            duration: Duration(seconds: 2),
          ));
        }
      } else {
        Get.showSnackbar(const GetSnackBar(
          message: "Terjadi kesalahan. Silakan coba lagi",
          duration: Duration(seconds: 2),
        ));
      }
    } else {
      currentParam.value = currentParam.value.copyWith(categoryId: categoryId);
      if (currentParam.value.currentPage == 0) return; // Means we reach end of page
      try {
        final res = await _repository.getCategory(currentParam.value);
        otherFilters.value = res.categoryFiltersList;
        filterMaxPrice.value = res.maxPrice;
        if (currentParam.value.currentPage == 1) {
          products.clear();
        }

        banners.assignAll(res.banners);

        if (res.products.isNotEmpty) {
          currentParam.value = currentParam.value.copyWith(currentPage: currentParam.value.currentPage + 1);
        } else {
          currentParam.value = currentParam.value.copyWith(currentPage: 0);
        }

        products.addAll(res.products);
        loaded.value = true;
      } catch (error) {
        Get.showSnackbar(const GetSnackBar(
          message: "Terjadi kesalahan. Silakan coba lagi",
          duration: Duration(seconds: 2),
        ));
      }
    }
  }

  void applyFilter(CategoryParam param) {
    currentParam.value = param.copyWith(currentPage: 1, categoryId: currentParam.value.categoryId);
    load();
  }

  void sortBy(Sort sort) {
    if (currentParam.value.sort == sort) {
      currentParam.value = currentParam.value.resetSort();
    } else {
      currentParam.value = currentParam.value.copyWith(sort: sort, currentPage: 1, order: "DESC");
    }
    load();
  }
}