import 'package:ufo_elektronika/screens/cart/edit_cart_response.dart';
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';
import 'package:ufo_elektronika/screens/product/entities/product_detail_response.dart';

class CartResponse {
    CartResponse({
        required this.errorWarning,
        required this.attention,
        required this.success,
        required this.action,
        required this.weight,
        required this.productsRecomended,
        required this.useCoupon,
        required this.products,
        required this.cp,
        required this.coupon,
        required this.totalPoints,
        required this.totals,
    });

    final String? errorWarning;
    final String? attention;
    final String? success;
    final String? action;
    final String? weight;
    final List<Product> productsRecomended;
    final CouponUsed? useCoupon;
    final Map<String, List<CartProduct>> products; // Key = Store id 
    final String? cp;
    final List<Coupon> coupon;
    final String? totalPoints;
    final List<Total> totals;

    factory CartResponse.fromMap(Map<String, dynamic> json){ 
        return CartResponse(
            errorWarning: json["error_warning"],
            attention: json["attention"],
            success: json["success"],
            action: json["action"],
            weight: json["weight"],
            productsRecomended: json["products_recomended"] == null ? [] : List<Product>.from(json["products_recomended"]!.map((x) => Product.fromMap(x))),
            useCoupon: json['use_coupon'] == null ? null : json['use_coupon'] is Map ? CouponUsed.fromMap(json['use_coupon']) : (json["use_coupon"] as List).map((x) => CouponUsed.fromMap(x)).firstOrNull,
            products: json["products"] == null ? {} : Map.from(json["products"]).map((k, v) => MapEntry<String, List<CartProduct>>(k, v == null ? [] : List<CartProduct>.from(v!.map((x) => CartProduct.fromMap(x))))),
            cp: json["cp"],
            coupon: json["coupon"] == null ? [] : List<Coupon>.from(json["coupon"]!.map((x) => Coupon.fromMap(x))),
            totalPoints: json["total_points"]?.toString(),
            totals: json["totals"] == null ? [] : List<Total>.from(json["totals"]!.map((x) => Total.fromMap(x))),
        );
    }

}
class CouponUsed {
    CouponUsed({
        required this.couponId,
        required this.code,
        required this.name,
        required this.type,
        required this.maxAmount,
        required this.point,
        required this.discount,
        required this.shipping,
        required this.total,
        required this.product,
        required this.dateStart,
        required this.dateEnd,
        required this.usesTotal,
        required this.usesCustomer,
        required this.status,
        required this.dateAdded,
        required this.link,
    });

    final String? couponId;
    final String? code;
    final String? name;
    final String? type;
    final String? maxAmount;
    final String? point;
    final String? discount;
    final String? shipping;
    final String? total;
    final List<dynamic> product;
    final DateTime? dateStart;
    final DateTime? dateEnd;
    final String? usesTotal;
    final String? usesCustomer;
    final String? status;
    final DateTime? dateAdded;
    final String? link;

    factory CouponUsed.fromMap(Map<String, dynamic> json){ 
        return CouponUsed(
            couponId: json["coupon_id"],
            code: json["code"],
            name: json["name"],
            type: json["type"],
            maxAmount: json["max_amount"],
            point: json["point"],
            discount: json["discount"],
            shipping: json["shipping"],
            total: json["total"],
            product: json["product"] == null ? [] : List<dynamic>.from(json["product"]!.map((x) => x)),
            dateStart: DateTime.tryParse(json["date_start"] ?? ""),
            dateEnd: DateTime.tryParse(json["date_end"] ?? ""),
            usesTotal: json["uses_total"],
            usesCustomer: json["uses_customer"],
            status: json["status"],
            dateAdded: DateTime.tryParse(json["date_added"] ?? ""),
            link: json["link"],
        );
    }

}


class Coupon {
    Coupon({
        required this.couponId,
        required this.name,
        required this.code,
        required this.usesTotal,
        required this.usesCustomer,
        required this.total,
        required this.percent,
        required this.end,
        required this.min,
        required this.amount,
    });

    final String? couponId;
    final String? name;
    final String? code;
    final String? usesTotal;
    final String? usesCustomer;
    final int? total;
    final int? percent;
    final String? end;
    final String? min;
    final String? amount;

    factory Coupon.fromMap(Map<String, dynamic> json){ 
        return Coupon(
            couponId: json["coupon_id"],
            name: json["name"],
            code: json["code"],
            usesTotal: json["uses_total"],
            usesCustomer: json["uses_customer"],
            total: json["total"],
            percent: json["percent"],
            end: json["end"],
            min: json["min"],
            amount: json["amount"],
        );
    }

}

class CartProduct {
    CartProduct({
        required this.cartId,
        required this.productId,
        required this.thumb,
        required this.name,
        required this.sku,
        required this.model,
        required this.optionText,
        required this.option,
        required this.optionSelect,
        required this.garansiName,
        required this.garansiPrice,
        required this.recurring,
        required this.quantity,
        required this.stock,
        required this.reward,
        required this.price,
        required this.priceAmount,
        required this.total,
        required this.href,
    });

    final String? cartId;
    final String? productId;
    final String? thumb;
    final String? name;
    final String? sku;
    final String? model;
    final String? optionText;
    final List<Option> option;
    final List<ProductOption>? optionSelect;
    final String? garansiName;
    final double? garansiPrice;
    final String? recurring;
    final String? quantity;
    final bool? stock;
    final String? reward;
    final String? price;
    final int? priceAmount;
    final String? total;
    final String? href;

    factory CartProduct.fromMap(Map<String, dynamic> json){ 
        return CartProduct(
            cartId: json["cart_id"],
            productId: json["product_id"],
            thumb: json["thumb"],
            name: json["name"],
            sku: json["sku"],
            model: json["model"],
            optionText: json["option_text"],
            option: json["option"] == null || json["option"] is! List ? [] : List<Option>.from(json["option"]!.map((x) => Option.fromMap(x))),
            optionSelect: json["option_select"] == null ? [] : json["option_select"] is List ? List<ProductOption>.from(json["option_select"]!.map((x) => ProductOption.fromMap(x))) : json["option_select"] is Map ? [ProductOption.fromMap(json["option_select"])] : [],
            garansiName: json["garansi_name"],
            garansiPrice: json["garansi_price"] is String ? double.tryParse(json["garansi_price"]) : json["garansi_price"]?.toDouble(),
            recurring: json["recurring"],
            quantity: json["quantity"],
            stock: json["stock"],
            reward: json["reward"]?.toString(),
            price: json["price"],
            priceAmount: json["price_amount"],
            total: json["total"],
            href: json["href"],
        );
    }
}

class Option {
    Option({
        required this.name,
        required this.value,
    });

    final String? name;
    final String? value;

    factory Option.fromMap(Map<String, dynamic> json){ 
        return Option(
            name: json["name"],
            value: json["value"],
        );
    }

}

class OptionSelectClass {
    OptionSelectClass({
        required this.productOptionId,
        required this.productOptionValue,
        required this.optionId,
        required this.name,
        required this.type,
        required this.value,
        required this.required,
    });

    final String? productOptionId;
    final List<ProductOptionValue> productOptionValue;
    final String? optionId;
    final String? name;
    final String? type;
    final String? value;
    final String? required;

    factory OptionSelectClass.fromMap(Map<String, dynamic> json){ 
        return OptionSelectClass(
            productOptionId: json["product_option_id"],
            productOptionValue: json["product_option_value"] == null ? [] : List<ProductOptionValue>.from(json["product_option_value"]!.map((x) => ProductOptionValue.fromMap(x))),
            optionId: json["option_id"],
            name: json["name"],
            type: json["type"],
            value: json["value"],
            required: json["required"],
        );
    }

}