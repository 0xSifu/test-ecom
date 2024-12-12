import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/compare_product/compare_product_repository.dart';
import 'package:ufo_elektronika/screens/product/product_controller.dart';
import 'package:ufo_elektronika/screens/product/product_repository.dart';

class ProductBinding extends Bindings {
  final String _productId;
  final String _bindingIdentifier;
  ProductBinding({required String productId, required String bindingIdentifier}): _productId = productId, _bindingIdentifier = bindingIdentifier;
  
  @override
  void dependencies() {
    Get.lazyPut<ProductRepository>(() => ProductRepositoryImpl(dio: Get.find()));
    Get.lazyPut(() => ProductController(
      repository: Get.find(),
      productId: _productId, 
      compareProductRepository: CompareProductRepositoryImpl(dio: Get.find())
    ), tag: "$_productId$_bindingIdentifier");
    
  }
}