import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/compare_product/compare_product_list_response.dart';
import 'package:ufo_elektronika/screens/compare_product/compare_product_repository.dart';
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';
import 'package:ufo_elektronika/shared/utils/state_controller.dart';

class CompareProductController extends StateController<ProductCompareListResponse> {
  final CompareProductRepository _repository;
  CompareProductController({required CompareProductRepository repository}): _repository = repository;

  @override
  void onInit() {
    super.onInit();

    futurize(_repository.getCompareProductList);
  }

  void removeProduct(Product product) {
    _repository.removeFromCompareProduct(productId: product.productId)
      .then((res) {
        futurize(_repository.getCompareProductList);
      })
      .catchError((error) {
        Get.showSnackbar(GetSnackBar(
          message: "Terjadi kesalahan, silakan coba lagi. [${(error is DioException ? error.response?.statusMessage : "")}]",
          duration: const Duration(seconds: 3),
        ));
      });
  }
}