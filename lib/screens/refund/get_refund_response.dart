class RefundDataResponse {
    RefundDataResponse({
        required this.headingTitle,
        required this.returnInfo,
        required this.errorWarning,
        required this.products,
        required this.ordersAll,
        required this.returnReasons,
    });

    final String? headingTitle;
    final List<dynamic> returnInfo;
    final String? errorWarning;
    final List<dynamic> products;
    final OrdersAll? ordersAll;
    final List<ReturnReason> returnReasons;

    factory RefundDataResponse.fromMap(Map<String, dynamic> json){ 
        return RefundDataResponse(
            headingTitle: json["heading_title"],
            returnInfo: json["return_info"] == null ? [] : List<dynamic>.from(json["return_info"]!.map((x) => x)),
            errorWarning: json["error_warning"],
            products: json["products"] == null ? [] : List<dynamic>.from(json["products"]!.map((x) => x)),
            ordersAll: json["orders_all"] == null ? null : OrdersAll.fromMap(json["orders_all"]),
            returnReasons: json["return_reasons"] == null ? [] : List<ReturnReason>.from(json["return_reasons"]!.map((x) => ReturnReason.fromMap(x))),
        );
    }

}

class OrdersAll {
    OrdersAll({
        required this.product,
        required this.orderId,
        required this.orderStatusText,
        required this.dateAdded,
    });

    final List<RefundProduct> product;
    final String? orderId;
    final String? orderStatusText;
    final DateTime? dateAdded;

    factory OrdersAll.fromMap(Map<String, dynamic> json){ 
        return OrdersAll(
            product: json["product"] == null ? [] : List<RefundProduct>.from(json["product"]!.map((x) => RefundProduct.fromMap(x))),
            orderId: json["order_id"],
            orderStatusText: json["order_status_text"],
            dateAdded: DateTime.tryParse(json["date_added"] ?? ""),
        );
    }

}

class RefundProduct {
    RefundProduct({
        required this.name,
        required this.productId,
        required this.model,
        required this.garansi,
        required this.garansiName,
        required this.option,
        required this.optionText,
        required this.quantity,
        required this.price,
        required this.total,
        required this.productReturn,
        required this.image,
        required this.href,
    });

    final String? name;
    final String? productId;
    final String? model;
    final String? garansi;
    final String? garansiName;
    final List<dynamic> option;
    final String? optionText;
    final String? quantity;
    final String? price;
    final String? total;
    final String? productReturn;
    final String? image;
    final String? href;

    factory RefundProduct.fromMap(Map<String, dynamic> json){ 
        return RefundProduct(
            name: json["name"],
            productId: json["product_id"],
            model: json["model"],
            garansi: json["garansi"],
            garansiName: json["garansi_name"],
            option: json["option"] == null ? [] : List<dynamic>.from(json["option"]!.map((x) => x)),
            optionText: json["option_text"],
            quantity: json["quantity"],
            price: json["price"],
            total: json["total"],
            productReturn: json["return"],
            image: json["image"],
            href: json["href"],
        );
    }

}

class ReturnReason {
    ReturnReason({
        required this.returnReasonId,
        required this.name,
    });

    final String? returnReasonId;
    final String? name;

    factory ReturnReason.fromMap(Map<String, dynamic> json){ 
        return ReturnReason(
            returnReasonId: json["return_reason_id"],
            name: json["name"],
        );
    }

}
