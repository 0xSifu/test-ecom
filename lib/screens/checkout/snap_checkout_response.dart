class SnapCheckoutResponse {
    SnapCheckoutResponse({
        required this.errors,
        required this.buttonConfirm,
        required this.redirectUrl,
        required this.token,
        required this.data,
    });

    final List<dynamic> errors;
    final String? buttonConfirm;
    final String? redirectUrl;
    final String? token;
    final Data? data;

    factory SnapCheckoutResponse.fromMap(Map<String, dynamic> json){ 
        return SnapCheckoutResponse(
            errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
            buttonConfirm: json["button_confirm"],
            redirectUrl: json["redirect_url"],
            token: json["token"],
            data: json["data"] == null ? null : Data.fromMap(json["data"]),
        );
    }

}

class Data {
    Data({
        required this.orderId,
    });

    final int? orderId;

    factory Data.fromMap(Map<String, dynamic> json){ 
        return Data(
            orderId: json["order_id"],
        );
    }

}
