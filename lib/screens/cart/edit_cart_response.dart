import 'package:ufo_elektronika/screens/cart/cart_response.dart';

class EditCartResponse {
    EditCartResponse({
        required this.totals,
        required this.products
    });

    final List<Total> totals;
    final Map<String, List<CartProduct>> products; // Key = Store id 

    factory EditCartResponse.fromMap(Map<String, dynamic> json){ 
        return EditCartResponse(
            totals: json["totals"] == null ? [] : List<Total>.from(json["totals"]!.map((x) => Total.fromMap(x))),
            products: json["products"] == null ? {} : Map.from(json["products"]).map((k, v) => MapEntry<String, List<CartProduct>>(k, v == null ? [] : List<CartProduct>.from(v!.map((x) => CartProduct.fromMap(x))))),
        );
    }

}

class Total {
    Total({
        required this.code,
        required this.title,
        required this.value,
        required this.text,
    });

    final String? code;
    final String? title;
    final int? value;
    final String? text;

    factory Total.fromMap(Map<String, dynamic> json){ 
        return Total(
            code: json["code"],
            title: json["title"],
            value: int.tryParse(json["value"]?.toString() ?? ""),
            text: json['text']
        );
    }

}
