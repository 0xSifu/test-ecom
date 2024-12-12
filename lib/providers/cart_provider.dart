import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:ufo_elektronika/models/cart_item.dart';
import 'package:ufo_elektronika/screens/cart/cart_repository.dart';
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cart = [];
  List<CartItem> _checkoutCart = [];
  bool _allCheckoutStatus = false;
  double _totalCheckout = 0;
  double _totalCheckoutQuantity = 0;

  // getter
  List<CartItem> get cart => _cart;
  List<CartItem> get checkoutCart => _checkoutCart;
  bool get allCheckoutStatus => _allCheckoutStatus;
  double get totalCheckout => _totalCheckout;
  double get totalCheckoutQuantity => _totalCheckoutQuantity;

  final CartRepository _repository;

  CartProvider({required CartRepository repository}): _repository = repository;

  int getQuantity(Product product) {
    var existingCart =
        _cart.firstWhereOrNull((item) => item.product.productId == product.productId);

    return existingCart?.quantity ?? 0;
  }

  // add to cart
  void addToCart(Product product, int quantity) {
    var existingCart =
        _cart.firstWhereOrNull((item) => item.product.productId == product.productId);

    if (existingCart != null) {
      // existingCart.quantity += quantity;
    } else {
      _cart.add(CartItem(
        product: product,
        quantity: quantity,
      ));
    }

    updateCheckoutStatus();

    notifyListeners();
  }

  // increase quantity
  void increaseQuantity(Product product) {
    addToCart(product, 1);
  }

  // decrease quantity
  void decreaseQuantity(Product product) {
    var existingCart =
        _cart.firstWhereOrNull((item) => item.product.productId == product.productId);

    if (existingCart!.quantity > 1) {
      // existingCart.quantity--;
    } else {
      return;
    }

    updateCheckoutStatus();

    notifyListeners();
  }

  // change quantity
  void changeQuantity(Product product, int quantity) {
    if (quantity == 0) quantity = 1;

    var existingCart =
        _cart.firstWhereOrNull((item) => item.product.productId == product.productId);

    if (existingCart != null) {
      // existingCart.quantity = quantity;
      updateCheckoutStatus();

      notifyListeners();
    }
  }

  // remove cart
  void removeCart(Product product) {
    CartItem cartItem =
        _cart.firstWhere((item) => item.product.productId == product.productId);
    _cart.remove(cartItem);
    updateCheckoutStatus();

    notifyListeners();
  }

  // add cart to checkout
  void addToCheckout(Product product, bool checkout) {
    var existingCart =
        _cart.firstWhereOrNull((item) => item.product.productId == product.productId);

    if (existingCart != null) {
      // existingCart.checkout = checkout;
      updateCheckoutStatus();

      notifyListeners();
    }
  }

  // add all cart to checkout
  void addAllToCheckout(bool status) {
    for (CartItem cart in _cart) {
      // cart.checkout = status;
    }

    updateCheckoutStatus();

    notifyListeners();
  }

  void updateCheckoutStatus() {
    List<CartItem> checkout = [];
    bool checkAllStatus = true;
    double total = 0;
    double quantity = 0;

    for (CartItem cart in _cart) {
      if (cart.checkout == false) checkAllStatus = false;

      // total cart price
      if (cart.checkout) {
        checkout.add(cart);
        _totalCheckout += (cart.quantity.toDouble() * (cart.product.realPrice ?? 0));
        total += (cart.quantity.toDouble() * (cart.product.realPrice ?? 0));
        quantity += cart.quantity;
      }
    }

    // update checkout cart
    _checkoutCart = checkout;
    // update total
    _totalCheckout = total;
    // update cart quantity
    _totalCheckoutQuantity = quantity;
    // update status select all
    _allCheckoutStatus = checkAllStatus;
  }
}
