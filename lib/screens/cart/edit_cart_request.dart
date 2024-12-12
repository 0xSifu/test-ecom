
import 'package:collection/collection.dart';

class EditCartRequest {
  final List<String> checkedCartIds;
  final Map<String, double> cartIdAndPriceGaransis;
  final Map<String, int> cartIdAndQuantities;
  final Map<String, String> cartIdAndStores;
  EditCartRequest({
    required this.checkedCartIds,
    required this.cartIdAndPriceGaransis,
    required this.cartIdAndQuantities,
    required this.cartIdAndStores,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    checkedCartIds.forEachIndexed((index, element) {
      map["checked[$index]"] = element;
    });

    cartIdAndPriceGaransis.forEach((key, value) {
      map["garansi_ufo[$key]"] = value;
    });

    cartIdAndQuantities.forEach((key, value) {
      map["quantity[$key]"] = value;
    });

    cartIdAndStores.forEach((key, value) {
      map["store[$key]"] = value;
    });

    return map;
  }

  
}
