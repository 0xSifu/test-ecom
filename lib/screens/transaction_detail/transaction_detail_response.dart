import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/cart/edit_cart_response.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_statuses_response.dart';

class TransactionDetailResponse {
    TransactionDetailResponse({
        required this.orderId,
        required this.dateAdded,
        required this.orderHistory,
        required this.imageHistory,
        required this.atasNamaRekening,
        required this.name,
        required this.telephone,
        required this.resi,
        required this.paymentAddress,
        required this.paymentMethod,
        required this.shippingAddress,
        required this.reorder,
        required this.midtransLink,
        required this.midtransToken,
        required this.products,
        required this.vouchers,
        required this.totals,
        required this.shippingMethod,
        required this.comment,
        required this.histories,
        required this.noInvoice,
        required this.orderStatus,
        required this.orderStatusId,
        required this.reviewId
    });

    final String? orderId;
    final String? dateAdded;
    final List<OrderHistory> orderHistory;
    final String? imageHistory;
    final String? atasNamaRekening;
    final String? name;
    final String? telephone;
    final dynamic resi;
    final String? paymentAddress;
    final String? paymentMethod;
    final String? shippingAddress;
    final String? reorder;
    final String? midtransLink;
    final String? midtransToken;
    final List<Product> products;
    final List<dynamic> vouchers;
    final List<Total> totals;
    final String? shippingMethod;
    final String? comment;
    final List<History> histories;
    final String? noInvoice;
    final String? orderStatus;
    final TransactionStatus? orderStatusId;
    final String? reviewId;

    factory TransactionDetailResponse.fromMap(Map<String, dynamic> json){ 
        return TransactionDetailResponse(
            orderId: json["order_id"],
            dateAdded: json["date_added"],
            orderHistory: json["order_history"] == null ? [] : List<OrderHistory>.from(json["order_history"]!.map((x) => OrderHistory.fromMap(x))),
            imageHistory: json["image_history"],
            atasNamaRekening: json["atas_nama_rekening"],
            name: json["name"],
            telephone: json["telephone"],
            resi: json["resi"],
            paymentAddress: json["payment_address"],
            paymentMethod: json["payment_method"],
            shippingAddress: json["shipping_address"],
            reorder: json["reorder"],
            midtransLink: json["midtrans_link"],
            midtransToken: json["midtrans_token"],
            products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromMap(x))),
            vouchers: json["vouchers"] == null ? [] : List<dynamic>.from(json["vouchers"]!.map((x) => x)),
            totals: json["totals"] == null ? [] : List<Total>.from(json["totals"]!.map((x) => Total.fromMap(x))),
            shippingMethod: json["shipping_method"],
            comment: json["comment"],
            histories: json["histories"] == null ? [] : List<History>.from(json["histories"]!.map((x) => History.fromMap(x))),
            noInvoice: json["no_invoice"],
            orderStatus: json['order_status'],
            orderStatusId: TransactionStatus.values.firstWhereOrNull((e) => e.rawValue == json['order_status_id']) ?? TransactionStatus.unknown,
            reviewId: json['review_id']
        );
    }

}

class History {
    History({
        required this.dateAdded,
        required this.status,
        required this.comment,
    });

    final String? dateAdded;
    final String? status;
    final String? comment;

    factory History.fromMap(Map<String, dynamic> json){ 
        return History(
            dateAdded: json["date_added"],
            status: json["status"],
            comment: json["comment"],
        );
    }

}

class OrderHistory {
    OrderHistory({
        required this.dateAdded,
        required this.text,
    });

    final String? dateAdded;
    final String? text;

    factory OrderHistory.fromMap(Map<String, dynamic> json){ 
        return OrderHistory(
            dateAdded: json["date_added"],
            text: json["text"],
        );
    }

}

class Product {
    Product({
        required this.productId,
        required this.name,
        required this.model,
        required this.garansi,
        required this.garansiName,
        required this.garansiIc,
        required this.option,
        required this.optionText,
        required this.quantity,
        required this.price,
        required this.total,
        required this.productReturn,
        required this.review,
        required this.image,
        required this.href,
    });

    final String? productId;
    final String? name;
    final String? model;
    final String? garansi;
    final String? garansiName;
    final String? garansiIc;
    final List<dynamic> option;
    final String? optionText;
    final String? quantity;
    final String? price;
    final String? total;
    final String? productReturn;
    final String? review;
    final String? image;
    final String? href;

    factory Product.fromMap(Map<String, dynamic> json){ 
        return Product(
            productId: json['product_id'],
            name: json["name"],
            model: json["model"],
            garansi: json["garansi"],
            garansiName: json["garansi_name"],
            garansiIc: json["garansi_ic"],
            option: json["option"] == null ? [] : List<dynamic>.from(json["option"]!.map((x) => x)),
            optionText: json["option_text"],
            quantity: json["quantity"],
            price: json["price"],
            total: json["total"],
            productReturn: json["return"],
            review: json["review"],
            image: json["image"],
            href: json["href"],
        );
    }

}
