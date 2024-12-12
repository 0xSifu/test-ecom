class ApplyCouponResponse {
    ApplyCouponResponse({
        required this.data,
        required this.success,
        required this.error
    });

    final Data? data;
    final String? success;
    final String? error;

    factory ApplyCouponResponse.fromMap(Map<String, dynamic> json){ 
        return ApplyCouponResponse(
            data: json["data"] == null ? null : Data.fromMap(json["data"]),
            success: json["success"],
            error: json['error']
        );
    }

}

class Data {
    Data({
        required this.coupon,
        required this.couponProduct,
        required this.maxAmount,
        required this.discount,
        required this.type,
    });

    final String? coupon;
    final List<dynamic> couponProduct;
    final String? maxAmount;
    final String? discount;
    final String? type;

    factory Data.fromMap(Map<String, dynamic> json){ 
        return Data(
            coupon: json["coupon"],
            couponProduct: json["coupon_product"] == null ? [] : List<dynamic>.from(json["coupon_product"]!.map((x) => x)),
            maxAmount: json["max_amount"],
            discount: json["discount"],
            type: json["type"],
        );
    }

}
