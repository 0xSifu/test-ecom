import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';

class InformationResponse {
    InformationResponse({
        required this.products,
        required this.pagination,
        required this.limits,
        required this.results,
        required this.limit,
        required this.headingTitle,
        required this.banner,
        required this.description,
    });

    final List<Product> products;
    final String? pagination;
    final List<dynamic> limits;
    final String? results;
    final int? limit;
    final String? headingTitle;
    final String? banner;
    final String? description;

    factory InformationResponse.fromMap(Map<String, dynamic> json){ 
        return InformationResponse(
            products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromMap(x))),
            pagination: json["pagination"],
            limits: json["limits"] == null ? [] : List<dynamic>.from(json["limits"]!.map((x) => x)),
            results: json["results"],
            limit: int.tryParse(json["limit"] ?? ""),
            headingTitle: json["heading_title"],
            banner: json["banner"],
            description: json["description"],
        );
    }

}