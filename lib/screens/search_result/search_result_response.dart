import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';

class SearchResultResponse {
    SearchResultResponse({
        required this.filterMinPrice,
        required this.filterMaxPrice,
        required this.sortVal,
        required this.orderVal,
        required this.maxPrice,
        required this.products,
        required this.category,
    });

    final int? filterMinPrice;
    final int? filterMaxPrice;
    final String? sortVal;
    final String? orderVal;
    final MaxPrice? maxPrice;
    final List<Product> products;
    final List<Category> category;

    factory SearchResultResponse.fromMap(Map<String, dynamic> json){ 
        return SearchResultResponse(
            filterMinPrice: int.tryParse(json["filter_min_price"]?.toString() ?? ""),
            filterMaxPrice: int.tryParse(json["filter_max_price"]?.toString() ?? ""),
            sortVal: json["sort_val"],
            orderVal: json["order_val"],
            maxPrice: json["max_price"] == null ? null : MaxPrice.fromMap(json["max_price"]),
            products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromMap(x))),
            category: json["category"] == null ? [] : List<Category>.from(json["category"]!.map((x) => Category.fromMap(x))),
        );
    }

}

class Category {
    Category({
        required this.categoryId,
        required this.languageId,
        required this.name,
        required this.description,
        required this.metaTitle,
        required this.metaDescription,
        required this.metaKeyword,
        required this.icon,
        required this.labelFreeItem,
    });

    final String? categoryId;
    final String? languageId;
    final String? name;
    final String? description;
    final String? metaTitle;
    final String? metaDescription;
    final String? metaKeyword;
    final dynamic icon;
    final String? labelFreeItem;

    factory Category.fromMap(Map<String, dynamic> json){ 
        return Category(
            categoryId: json["category_id"],
            languageId: json["language_id"],
            name: json["name"],
            description: json["description"],
            metaTitle: json["meta_title"],
            metaDescription: json["meta_description"],
            metaKeyword: json["meta_keyword"],
            icon: json["icon"],
            labelFreeItem: json["label_free_item"],
        );
    }

}

class MaxPrice {
    MaxPrice({
        required this.max,
    });

    final int? max;

    factory MaxPrice.fromMap(Map<String, dynamic> json){ 
        return MaxPrice(
            max: double.tryParse(json["max"]?.toString() ?? "")?.toInt(),
        );
    }

}
