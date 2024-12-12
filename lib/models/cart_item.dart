
import 'package:collection/collection.dart';
import 'package:ufo_elektronika/screens/cart/cart_response.dart';
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';
import 'package:ufo_elektronika/screens/product/entities/product_detail_response.dart';

class CartItem {
  CartItem({
    required this.product,
    this.quantity = 1,
    this.checkout = false,
        
    this.option,
    this.optionSelect,
    this.stock,
    this.garansiName,
    this.garansiPrice,
    this.garansiChecked,
    this.reward,
    this.groupKey,
    this.cartId,

    this.optionValues
  });

  final Product product;
  final int quantity;
  final bool checkout;

  // It can comes from cart response mapping at cart controller
  final List<Option>? option;
  final List<ProductOption>? optionSelect;
  final bool? stock;
  final String? garansiName;
  final double? garansiPrice;
  final bool? garansiChecked;
  final String? reward;
  final String? groupKey; // This is for now to know what store option value   
  final String? cartId;

  // To manage state on cart
  final Map<ProductOption, ProductOptionValue>? optionValues;

  String? get store => optionValues?.entries.firstWhereOrNull((e) => e.key.name?.toLowerCase() == "store")?.value.productOptionValueId;
  

  CartItem copyWith({
    Product? product,
    int? quantity,
    bool? checkout,
    List<Option>? option,
    List<ProductOption>? optionSelect,
    bool? stock,
    String? garansiName,
    double? garansiPrice,
    bool? garansiChecked,
    String? reward,
    String? groupKey,
    String? cartId,
    Map<ProductOption, ProductOptionValue>? optionValues,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      checkout: checkout ?? this.checkout,
      option: option ?? this.option,
      optionSelect: optionSelect ?? this.optionSelect,
      stock: stock ?? this.stock,
      garansiName: garansiName ?? this.garansiName,
      garansiPrice: garansiPrice ?? this.garansiPrice,
      garansiChecked: garansiChecked ?? this.garansiChecked,
      reward: reward ?? this.reward,
      groupKey: groupKey ?? this.groupKey,
      cartId: cartId ?? this.cartId,
      optionValues: optionValues ?? this.optionValues
    );
  }
}

class CartGroup {
  final String title;
  final List<CartItem> items;
  final String id;
  CartGroup({required this.items, required this.title, required this.id});

  CartGroup copyWith({
    String? title,
    List<CartItem>? items,
    String? id,
  }) {
    return CartGroup(
      title: title ?? this.title,
      items: items ?? this.items,
      id: id ?? this.id,
    );
  }
}
