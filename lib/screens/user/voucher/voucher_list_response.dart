import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VoucherListResponse {
    VoucherListResponse({
        required this.breadcrumbs,
        required this.headingTitle,
        required this.account,
        required this.voucherListResponseReturn,
        required this.transaction,
        required this.ufopoint,
        required this.voucher,
        required this.notification,
        required this.wishlist,
        required this.newsletter,
        required this.recurring,
        required this.action,
        required this.edit,
        required this.password,
        required this.address,
        required this.textDescription,
        required this.textAgree,
        required this.entryToName,
        required this.entryToEmail,
        required this.entryFromName,
        required this.entryFromEmail,
        required this.entryTheme,
        required this.entryMessage,
        required this.entryAmount,
        required this.helpMessage,
        required this.helpAmount,
        required this.buttonContinue,
        required this.modules,
        required this.coupon,
        required this.pagination,
        required this.results,
        required this.columnLeft,
        required this.columnRight,
        required this.contentTop,
        required this.contentBottom,
        required this.footer,
        required this.header,
    });

    final List<Breadcrumb> breadcrumbs;
    final String? headingTitle;
    final String? account;
    final String? voucherListResponseReturn;
    final String? transaction;
    final String? ufopoint;
    final String? voucher;
    final String? notification;
    final String? wishlist;
    final String? newsletter;
    final String? recurring;
    final String? action;
    final String? edit;
    final String? password;
    final String? address;
    final String? textDescription;
    final String? textAgree;
    final String? entryToName;
    final String? entryToEmail;
    final String? entryFromName;
    final String? entryFromEmail;
    final String? entryTheme;
    final String? entryMessage;
    final String? entryAmount;
    final String? helpMessage;
    final String? helpAmount;
    final String? buttonContinue;
    final List<String> modules;
    final List<Coupon> coupon;
    final String? pagination;
    final String? results;
    final dynamic columnLeft;
    final String? columnRight;
    final String? contentTop;
    final String? contentBottom;
    final String? footer;
    final String? header;

    factory VoucherListResponse.fromMap(Map<String, dynamic> json){ 
        return VoucherListResponse(
            breadcrumbs: json["breadcrumbs"] == null ? [] : List<Breadcrumb>.from(json["breadcrumbs"]!.map((x) => Breadcrumb.fromMap(x))),
            headingTitle: json["heading_title"],
            account: json["account"],
            voucherListResponseReturn: json["return"],
            transaction: json["transaction"],
            ufopoint: json["ufopoint"],
            voucher: json["voucher"],
            notification: json["notification"],
            wishlist: json["wishlist"],
            newsletter: json["newsletter"],
            recurring: json["recurring"],
            action: json["action"],
            edit: json["edit"],
            password: json["password"],
            address: json["address"],
            textDescription: json["text_description"],
            textAgree: json["text_agree"],
            entryToName: json["entry_to_name"],
            entryToEmail: json["entry_to_email"],
            entryFromName: json["entry_from_name"],
            entryFromEmail: json["entry_from_email"],
            entryTheme: json["entry_theme"],
            entryMessage: json["entry_message"],
            entryAmount: json["entry_amount"],
            helpMessage: json["help_message"],
            helpAmount: json["help_amount"],
            buttonContinue: json["button_continue"],
            modules: json["modules"] == null ? [] : List<String>.from(json["modules"]!.map((x) => x)),
            coupon: json["coupon"] == null ? [] : List<Coupon>.from(json["coupon"]!.map((x) => Coupon.fromMap(x))),
            pagination: json["pagination"],
            results: json["results"],
            columnLeft: json["column_left"],
            columnRight: json["column_right"],
            contentTop: json["content_top"],
            contentBottom: json["content_bottom"],
            footer: json["footer"],
            header: json["header"],
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

class Coupon {
    Coupon({
        required this.couponId,
        required this.couponPointId,
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
    final dynamic couponPointId;
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
            couponPointId: json["coupon_point_id"],
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

    Map<String, dynamic> toMap() { 
      return {
        "coupon_id": couponId,
        "coupon_point_id": couponPointId,
        "name": name,
        "code": code,
        "uses_total": usesTotal,
        "uses_customer": usesCustomer,
        "total": total,
        "percent": percent,
        "end": end,
        "min": min,
        "amount": amount
      };
    }

    static Future<Coupon?> getAppliedVoucher(FlutterSecureStorage secureStorage) {
      return secureStorage.read(key: "applied_voucher")
        .then((value) {
          if (value == null || value.isEmpty) {
            return null;
          }
          return Coupon.fromMap(jsonDecode(value));
        });
    }

    static Future<void> setAppliedVoucher(FlutterSecureStorage secureStorage, Coupon coupon) async {
      await secureStorage.write(key: "applied_voucher", value: jsonEncode(coupon.toMap()));
    }
}
