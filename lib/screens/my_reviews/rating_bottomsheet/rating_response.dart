class RatingResponse {
    RatingResponse({
        required this.data,
    });

    final Data? data;

    factory RatingResponse.fromMap(Map<String, dynamic> json){ 
        return RatingResponse(
            data: json["data"] == null ? null : Data.fromMap(json["data"]),
        );
    }

}

class Data {
    Data({
        required this.productId,
        required this.rating,
        required this.text,
        required this.orderId,
        required this.photo,
    });

    final String? productId;
    final String? rating;
    final String? text;
    final String? orderId;
    final List<String> photo;

    factory Data.fromMap(Map<String, dynamic> json){ 
        return Data(
            productId: json["product_id"],
            rating: json["rating"],
            text: json["text"],
            orderId: json["order_id"],
            photo: json["photo"] == null ? [] : List<String>.from(json["photo"]!.map((x) => x)),
        );
    }

}
