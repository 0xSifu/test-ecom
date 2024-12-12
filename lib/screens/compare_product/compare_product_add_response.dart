class ProductCompareAddResponse {
    ProductCompareAddResponse({
        required this.success,
        required this.total,
    });

    final String? success;
    final String? total;

    factory ProductCompareAddResponse.fromMap(Map<String, dynamic> json){ 
        return ProductCompareAddResponse(
            success: json["success"],
            total: json["total"],
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "total": total,
    };

}
