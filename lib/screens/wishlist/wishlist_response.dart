import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';

class WishlistResponse {
    WishlistResponse({
        required this.success,
        required this.products,
    });

    final String? success;
    final List<Product> products;

    factory WishlistResponse.fromMap(Map<String, dynamic> json){ 
        return WishlistResponse(
            success: json["success"],
            products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromMap(x))),
        );
    }

}