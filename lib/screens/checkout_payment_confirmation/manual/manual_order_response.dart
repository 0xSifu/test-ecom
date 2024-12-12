class ManualOrderResponse {
    ManualOrderResponse({
        required this.midtransToken,
        required this.norek,
        required this.paymentInstruction,
        required this.paymentBefore,
        required this.logoBank,
        required this.paymentMethod,
        required this.anRekening,
        required this.total,
        required this.orderId,
    });

    final String? midtransToken;
    final String? norek;
    final PaymentInstruction? paymentInstruction;
    final DateTime? paymentBefore;
    final String? logoBank;
    final String? paymentMethod;
    final String? anRekening;
    final String? total;
    final int? orderId;

    factory ManualOrderResponse.fromMap(Map<String, dynamic> json){ 
        return ManualOrderResponse(
            midtransToken: json["midtrans_token"],
            norek: json["norek"],
            paymentInstruction: json["payment_instruction"] == null ? null : PaymentInstruction.fromMap(json["payment_instruction"]),
            paymentBefore: DateTime.tryParse(json["payment_before"] ?? ""),
            logoBank: json["logo_bank"],
            paymentMethod: json["payment_method"],
            anRekening: json["an_rekening"],
            total: json["total"],
            orderId: json["order_id"],
        );
    }

}

class PaymentInstruction {
    PaymentInstruction({
        required this.paymentInstructionId,
        required this.languageId,
        required this.title,
        required this.description,
        required this.metaTitle,
        required this.metaDescription,
        required this.metaKeyword,
        required this.description2,
        required this.subtitle1,
        required this.subtitle2,
        required this.subtitle3,
        required this.description3,
    });

    final String? paymentInstructionId;
    final String? languageId;
    final String? title;
    final String? description;
    final String? metaTitle;
    final String? metaDescription;
    final String? metaKeyword;
    final String? description2;
    final String? subtitle1;
    final String? subtitle2;
    final String? subtitle3;
    final String? description3;

    factory PaymentInstruction.fromMap(Map<String, dynamic> json){ 
        return PaymentInstruction(
            paymentInstructionId: json["payment_instruction_id"],
            languageId: json["language_id"],
            title: json["title"],
            description: json["description"],
            metaTitle: json["meta_title"],
            metaDescription: json["meta_description"],
            metaKeyword: json["meta_keyword"],
            description2: json["description2"],
            subtitle1: json["subtitle1"],
            subtitle2: json["subtitle2"],
            subtitle3: json["subtitle3"],
            description3: json["description3"],
        );
    }

}
