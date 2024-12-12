class AddToCartResponse {
    AddToCartResponse({
        required this.success,
        required this.total,
        required this.redirectProductDtl,
        required this.error
    });

    final String? success;
    final String? total;
    final String? redirectProductDtl;
    final Map<String, dynamic>? error;

    factory AddToCartResponse.fromMap(Map<String, dynamic> json){ 
        return AddToCartResponse(
            success: json["success"],
            total: json["total"],
            redirectProductDtl: json["redirect_product_dtl"],
            error: json['error']
        );
    }

}
