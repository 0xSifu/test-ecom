import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';

class ProductCompareListResponse {
    ProductCompareListResponse({
        required this.success,
        required this.reviewStatus,
        required this.productsMap,
        required this.products,
        required this.attributeGroups,
    });

    final String? success;
    final String? reviewStatus;
    final Map<String, Product>? productsMap;
    final AttributeGroups? attributeGroups;
    final List<Product>? products;

    factory ProductCompareListResponse.fromMap(Map<String, dynamic> json){ 
        return ProductCompareListResponse(
            success: json["success"],
            reviewStatus: json["review_status"],
            productsMap: json["products"] == null ? null : Products.fromMap(json["products"]).products,
            products: json["products"] == null ? null : Products.fromMap(json["products"]).products?.values.toList(),
            attributeGroups: json["attribute_groups"] == null || json["attribute_groups"] is Map == false ? null : AttributeGroups.fromMap(json["attribute_groups"]),
        );
    }

}

class AttributeGroups {
    AttributeGroups({
        required this.attributes,
    });

    final Map<String, dynamic>? attributes;

    factory AttributeGroups.fromMap(Map<String, dynamic> json){ 
        return AttributeGroups(
            attributes: json,
        );
    }

}

class Products {
    Products({
        required this.products,
    });

    final Map<String, Product>? products;

    factory Products.fromMap(Map<String, dynamic> json){
      final products = <String, Product>{};
      json.forEach((key, value) {
        products[key] = Product.fromMap(value); 
      });
        return Products(
          products: products,
        );
    }

}