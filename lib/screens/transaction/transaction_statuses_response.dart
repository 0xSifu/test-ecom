import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ufo_elektronika/constants/colors.dart';

class TransactionStatusesResponse {
    TransactionStatusesResponse({
        required this.orderStatusId,
        required this.languageId,
        required this.name,
    });

    final TransactionStatus orderStatusId;
    final String? languageId;
    final String? name;

    factory TransactionStatusesResponse.fromMap(Map<String, dynamic> json){ 
        return TransactionStatusesResponse(
            orderStatusId: TransactionStatus.values.firstWhereOrNull((e) => e.rawValue == json["order_status_id"]) ?? TransactionStatus.unknown,
            languageId: json["language_id"],
            name: json["name"],
        );
    }

}

enum TransactionStatus {
  waitingForPayment,
  processing,
  shipping,
  canceled,
  failed,
  paymentConfirmation,
  paid,
  expired,
  completed,
  unknown
}

extension TransactionStatusEnum on TransactionStatus {
  String? get rawValue {
    switch (this) {
      case TransactionStatus.waitingForPayment:
      return "1";
      case TransactionStatus.processing:
      return "2";
      case TransactionStatus.shipping:
      return "5";
      case TransactionStatus.canceled:
      return "7";
      case TransactionStatus.failed:
      return "10";
      case TransactionStatus.paymentConfirmation:
      return "17";
      case TransactionStatus.paid:
      return "18";
      case TransactionStatus.expired:
      return "19";
      case TransactionStatus.completed:
      return "22";
      case TransactionStatus.unknown:
      return null;
    }
  }

  Color get color {
    switch (this) {
      case TransactionStatus.canceled:
      return const Color(0xFFFCD4D3);
      case TransactionStatus.failed:
      case TransactionStatus.unknown:
      case TransactionStatus.expired:
      case TransactionStatus.waitingForPayment:
      return Colors.grey;
      
      case TransactionStatus.shipping:
      return const Color(0xFFFEEED1);

      case TransactionStatus.processing:
      return const Color(0xFFBCFCA3);

      case TransactionStatus.paymentConfirmation:
      case TransactionStatus.paid:
      case TransactionStatus.completed:
      return AppColor.primaryColor.withOpacity(0.2);
    }
  }

  Color get textColor {
    switch (this) {
      case TransactionStatus.canceled:
      return const Color(0xFFEE2724);
      case TransactionStatus.failed:
      case TransactionStatus.unknown:
      case TransactionStatus.expired:
      case TransactionStatus.waitingForPayment:
      return Colors.black;
      case TransactionStatus.shipping:
      return const Color(0xFFFBAA1A);
      case TransactionStatus.processing:
      return const Color(0xFF50B926);
      case TransactionStatus.paymentConfirmation:
      case TransactionStatus.paid:
      case TransactionStatus.completed:
      return AppColor.primaryColor;
    }
  }
}
