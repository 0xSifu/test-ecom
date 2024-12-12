import 'dart:convert';

import 'package:intl/intl.dart';


class SearchResponse {
    final List<Product> products;

    SearchResponse({
        required this.products,
    });


  factory SearchResponse.fromMap(Map<String, dynamic> map) {
    return SearchResponse(
      products: List<Product>.from(map['products']?.map((x) => Product.fromMap(x)) ?? []),
    );
  }

  factory SearchResponse.fromJson(String source) => SearchResponse.fromMap(json.decode(source));
}

class SuperDealResponse {
    final String headingTitle;
    final String textTax;
    final String buttonCart;
    final String buttonWishlist;
    final String buttonCompare;
    final List<Product> products;
    final String action;

    SuperDealResponse({
        required this.headingTitle,
        required this.textTax,
        required this.buttonCart,
        required this.buttonWishlist,
        required this.buttonCompare,
        required this.products,
        required this.action,
    });


  factory SuperDealResponse.fromMap(Map<String, dynamic> map) {
    return SuperDealResponse(
      headingTitle: map['heading_title'] ?? '',
      textTax: map['text_tax'] ?? '',
      buttonCart: map['button_cart'] ?? '',
      buttonWishlist: map['button_wishlist'] ?? '',
      buttonCompare: map['button_compare'] ?? '',
      products: List<Product>.from(map['products']?.map((x) => Product.fromMap(x)) ?? []),
      action: map['action'] ?? '',
    );
  }

  factory SuperDealResponse.fromJson(String source) => SuperDealResponse.fromMap(json.decode(source));
}

class FlashSaleResponse {
    final List<Product> flashSale;
    final DateTime? flashSaleDate;
    final String action;
  FlashSaleResponse({
    required this.flashSale,
    required this.flashSaleDate,
    required this.action,
  });

  factory FlashSaleResponse.fromMap(Map<String, dynamic> map) {
    final flashSaleDateString = map['flash_sale_date']?.toString() ?? '';
    return FlashSaleResponse(
      flashSale: List<Product>.from(map['flash_sale']?.map((x) => Product.fromMap(x)) ?? []),
      flashSaleDate: flashSaleDateString.isNotEmpty ? DateFormat("yyyy-MM-dd HH:mm:ss").parse(flashSaleDateString) : null ,
      action: map['action'] ?? '',
    );
  }

  factory FlashSaleResponse.fromJson(String source) => FlashSaleResponse.fromMap(json.decode(source));
}

class Product {
    final String productId;
    final String thumb;
    final String logoBrand;
    final String? totalSales;
    final int? total;
    final String name;
    final String model;
    final String description;
    final String price;
    final double? realPrice;
    final String? special;
    final double? disc;
    final String? tax;
    final double rating;
    final String href;

    // Flash Sale props
    final String? quantity;
    final String? qtySold;
    final String? priceFlashSale;

    // Compare product props
    final String? manufacturer;
    final String? availability;
    final double? minimum;
    final String? reviews;
    final String? weight;
    final String? length;
    final String? width;
    final String? height;
    final Map<String, dynamic>? attribute;

    Product({
      required this.productId,
      required this.thumb,
      required this.logoBrand,
      required this.totalSales,
      required this.total,
      required this.name,
      required this.model,
      required this.description,
      required this.price,
      this.realPrice = 0,
      required this.special,
      required this.disc,
      required this.tax,
      required this.rating,
      required this.href,
      required this.quantity,
      required this.qtySold,
      required this.priceFlashSale,
      this.manufacturer,
      this.availability,
      this.minimum,
      this.reviews,
      this.weight,
      this.length,
      this.width,
      this.height,
      this.attribute
    });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['product_id'] ?? '',
      thumb: map['thumb'] ?? '',
      logoBrand: map['logo_brand'] ?? '',
      totalSales: map['total_sales']?.toString(),
      total: map['total'],
      name: map['name'] ?? '',
      model: map['model'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? '',
      special: map['special'] is bool ? null : map['special'],
      disc: map['disc'] is bool ? null : double.tryParse(map['disc']?.toString() ?? ""),
      tax: map['tax'] is bool ? null : map['tax']?.toString(),
      rating: double.tryParse(map['rating']?.toString() ?? '') ?? 0,
      href: map['href'] ?? '',

      quantity: map['quantity']?.toString(),
      qtySold: map['qty_sold']?.toString(),
      priceFlashSale: map['price_flash_sale'],
      availability: map['availability'],
      height: map['height'],
      length: map['length'],
      manufacturer: map['manufacturer'],
      minimum: double.tryParse(map['minimum']?.toString() ?? ""),
      reviews: map['reviews'],
      weight: map['weight'],
      width: map['width'],
      realPrice: map['real_price'],
      attribute: map['attribute'] is Map ? map['attribute'] : null
    );
  }
}

class PopUpResponse {
    PopUpResponse({
        required this.popup,
    });

    final Popup? popup;

    factory PopUpResponse.fromMap(Map<String, dynamic> json){ 
        return PopUpResponse(
            popup: json["popup"] == null ? null : Popup.fromMap(json["popup"]),
        );
    }

}

class Popup {
    Popup({
        required this.title,
        required this.link,
        required this.image,
    });

    final String? title;
    final String? link;
    final String? image;

    factory Popup.fromMap(Map<String, dynamic> json){ 
        return Popup(
            title: json["title"],
            link: json["link"],
            image: json["image"],
        );
    }

}
