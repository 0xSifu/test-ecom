import 'package:collection/collection.dart';

class ProcessCheckoutRequest {
  final String addressId;
  final DeliveryGroup deliveryGroup; // 1 = pilih pengiriman, 2 = click and collect (real value = "tab")
  // final String? deliveryType; // (ex: kurir toko, regular, next day, etc)
  final String? courier; // (ex: jne, pos, tiki)
  // final String? jenisPengirimanKurir; // WHAT IS THIS????
  final String? notes;
  final String paymentMethod;
  final String? store;
  final String? shippingTitle;
  final String? shippingTaxClassId; // WHAT IS THIS???
  final double? cost; // WHAT IS THIS???
  final List<String> totals; // total[0], total[1] WHAT IS THIS???
  final Map<String, double> garansis; // Key = cart id, value = garansi value
  final String? e1; // WHAT IS THISS???
  final String? coupon; // Voucher
  final bool? isPackingKayu;

  ProcessCheckoutRequest({
    required this.addressId,
    required this.deliveryGroup,
    // required this.deliveryType,
    required this.courier,
    // required this.jenisPengirimanKurir,
    required this.notes,
    required this.paymentMethod,
    required this.store,
    required this.shippingTitle,
    required this.shippingTaxClassId,
    required this.cost,
    required this.totals,
    required this.garansis,
    required this.e1,
    required this.coupon,
    required this.isPackingKayu,
  });


  Map<String, dynamic> toMap() {
    final map = {
      'address_id': addressId,
      'tab': deliveryGroup.rawValue,
      'e1': e1,
      'store': store,
      // 'tipe_pengiriman': deliveryType,
      'jenis_pengiriman': courier,
      // 'jenis_pengiriman_kurir': jenisPengirimanKurir,
      'notes': notes,
      'payment_methods': paymentMethod,
      'shipping_title': shippingTitle,
      'shipping_tax_class_id': shippingTaxClassId,
      'cost': cost,
      'coupon': coupon,
      'packing_kayu': isPackingKayu == true ? 1 : 0
    };
    totals.forEachIndexed((index, total) {
      map['totals[$index]'] = total;
    });
    garansis.forEach((key, value) {
      map['garansi[$key]'] = value;
    });
    map.removeWhere((key, value) => value == null);
    return map;
  }
}

enum DeliveryGroup {
  clickAndCollect,
  delivery
}

extension DeliveryGroupExt on DeliveryGroup {
  String get rawValue {
    switch (this) {
      case DeliveryGroup.clickAndCollect:
      return "2";
      case DeliveryGroup.delivery:
      return "1";
    }
  }
}