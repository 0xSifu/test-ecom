import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:ufo_elektronika/screens/cart/add_to_cart_response.dart';
import 'package:ufo_elektronika/screens/cart/cart_response.dart';
import 'package:ufo_elektronika/screens/cart/edit_cart_request.dart';
import 'package:ufo_elektronika/screens/cart/edit_cart_response.dart';
import 'package:ufo_elektronika/screens/product/entities/product_detail_response.dart';

abstract class CartRepository {
  Future<void> addWishlist(String productId);
  Future<void> removeWishlist(String productId);
  // Future<CartResponse> getCart();
  Future<AddToCartResponse> addToCart(String productId, int quantity, int? garansiUfo, Map<ProductOption, ProductOptionValue> options);
  Future<CartResponse> editCart(EditCartRequest request);
  Future<void> buyAgainThisOrder(String orderId);
  // Future<void> editQtyCart(String cartId, int quantity);
  // Future<void> deleteItem(String cartId);
  // Future<void> changeStore(String cartId, String storeId);
}

class CartRepositoryImpl extends CartRepository {
  final Dio _dio;
  CartRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<void> removeWishlist(String productId) async {
    await _dio.get("account/wishlist&remove=$productId");
    return;
  }


  @override
  Future<void> addWishlist(String productId) async {
    await _dio.post("account/wishlist/add", data: FormData.fromMap({
      "product_id": productId
    }));
    return;
  }

  // @override
  // Future<CartResponse> getCart() async {
  //   final dioResp = await _dio.get("checkout/cart");
  //   // final res = jsonEncode(dioResp.data);
  //   return CartResponse.fromMap(dioResp.data);
  // }

  @override
  Future<AddToCartResponse> addToCart(
    String productId, 
    int quantity, 
    int? garansiUfo,
    Map<ProductOption, ProductOptionValue> options
  ) async {
    final body = <String, dynamic>{
      "product_id": productId,
      "quantity": quantity,
      "garansi_ufo": garansiUfo
    };
    final optionMap = options.entries.map((e) => MapEntry("option[${e.key.productOptionId}]", e.value.productOptionValueId));
    body.addEntries(optionMap);
    final dioResp = await _dio.post("checkout/cart/add", data: FormData.fromMap(body));
    // final res = jsonEncode(dioResp.data);
    return AddToCartResponse.fromMap(dioResp.data);
  }

  @override
  Future<CartResponse> editCart(EditCartRequest request) async {
    final map = request.toMap();
    final dioResp = await _dio.post("checkout/cart/edit", data: FormData.fromMap(map));
    // final resp = jsonEncode(dioResp.data);
    final res = CartResponse.fromMap(dioResp.data);
    return res;
  }

  @override
  Future<void> buyAgainThisOrder(String orderId) async {
    final dioResp = await _dio.post("account/order/reorder&order_id=$orderId");
    final res = jsonEncode(dioResp.data);
    return;
  }

  // @override
  // Future<void> editQtyCart(String cartId, int quantity) async {
  //   final dioResp = await _dio.post("checkout/cart/edit_qty", data: FormData.fromMap({
  //     "id": cartId,
  //     "qty": quantity
  //   }));
  //   final res = jsonEncode(dioResp.data);
  //   return;
  // }

  // @override
  // Future<void> deleteItem(String cartId) async {
  //   final dioResp = await _dio.post("checkout/cart/remove", data: FormData.fromMap({
  //     "key": cartId
  //   }));
  //   final res = jsonEncode(dioResp.data);
  //   return;
  // }

  // @override
  // Future<void> changeStore(String cartId, String storeId) async {
  //   final dioResp = await _dio.post("checkout/cart/changeOptionStore", data: FormData.fromMap({
  //     "cart_id": cartId,
  //     "id": storeId
  //   }));
  //   final res = jsonEncode(dioResp.data);
  //   return;
  // }
}
