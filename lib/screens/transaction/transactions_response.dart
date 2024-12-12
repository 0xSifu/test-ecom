import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_statuses_response.dart';

class TransactionsResponse {
    TransactionsResponse({
        required this.periode,
        required this.orderStatus,
        required this.orders,
        required this.options,
    });

    final String? periode;
    final String? orderStatus;
    final List<Order> orders;
    final List<String> options;

    factory TransactionsResponse.fromMap(Map<String, dynamic> json){ 
        return TransactionsResponse(
            periode: json["periode"],
            options: json["options"] == null ? [] : json["options"] is List ? List<String>.from(json["options"]!.map((x) => x)) : [],
            orderStatus: json["order_status"],
            orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromMap(x))),
        );
    }

}

class Breadcrumb {
    Breadcrumb({
        required this.text,
        required this.href,
    });

    final String? text;
    final String? href;

    factory Breadcrumb.fromMap(Map<String, dynamic> json){ 
        return Breadcrumb(
            text: json["text"],
            href: json["href"],
        );
    }

}

class Order {
    Order({
        required this.orderId,
        required this.name,
        required this.status,
        required this.orderStatusId,
        required this.midtransToken,
        required this.midtransLink,
        required this.dateAdded,
        required this.orderReturn,
        required this.review,
        required this.products,
        required this.total,
        required this.view,
        required this.reorder,
        required this.resi,
        required this.orderProducts,
        required this.reviewId,
    });

    final String? orderId;
    final String? name;
    final String? status;
    final TransactionStatus? orderStatusId;
    final String? midtransToken;
    final String? midtransLink;
    final String? dateAdded;
    final String? orderReturn;
    final String? review;
    final int? products;
    final String? total;
    final String? view;
    final String? reorder;
    final dynamic resi;
    final List<OrderProduct> orderProducts;
    final String? reviewId;

    factory Order.fromMap(Map<String, dynamic> json){ 
        return Order(
            orderId: json["order_id"],
            name: json["name"],
            status: json["status"],
            orderStatusId: TransactionStatus.values.firstWhereOrNull((e) => e.rawValue == json["order_status_id"]) ?? TransactionStatus.unknown,
            midtransToken: json["midtrans_token"],
            midtransLink: json["midtrans_link"],
            dateAdded: json["date_added"],
            orderReturn: json["return"],
            review: json["review"],
            products: json["products"],
            total: json["total"],
            view: json["view"],
            reorder: json["reorder"],
            resi: json["resi"],
            orderProducts: json["order_products"] == null ? [] : List<OrderProduct>.from(json["order_products"]!.map((x) => OrderProduct.fromMap(x))),
            reviewId: json['review_id']
        );
    }

}

class OrderProduct {
    OrderProduct({
        required this.image,
        required this.name,
        required this.option,
        required this.href,
        required this.productId,
    });

    final String? image;
    final String? name;
    final String? option;
    final String? href;
    final String? productId;

    factory OrderProduct.fromMap(Map<String, dynamic> json){ 
        return OrderProduct(
            image: json["image"],
            name: json["name"],
            option: json["option"],
            href: json["href"],
            productId: json['product_id']
        );
    }

}
