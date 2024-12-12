import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ufo_elektronika/models/cart_item.dart';
import 'package:ufo_elektronika/screens/cart/cart_repository.dart';
import 'package:ufo_elektronika/screens/cart/cart_response.dart';
import 'package:ufo_elektronika/screens/cart/cart_screen.dart';
import 'package:ufo_elektronika/screens/cart/edit_cart_request.dart';
import 'package:ufo_elektronika/screens/checkout/checkout_screen.dart';
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';
import 'package:ufo_elektronika/screens/login/login_response.dart';
import 'package:ufo_elektronika/screens/login/login_screen.dart';
import 'package:ufo_elektronika/screens/product/entities/product_detail_response.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_repository.dart';
import 'package:ufo_elektronika/screens/wishlist/wishlist_controller.dart';

class CartController extends GetxController {

  final CartRepository _repository;
  final VoucherRepository _voucherRepository;
  final WishlistController _wishlistController;
  final FlutterSecureStorage _secureStorage;
  CartController({required CartRepository repository, required VoucherRepository voucherRepository, required WishlistController wishlistController, required FlutterSecureStorage secureStorage}): 
    _repository = repository, 
    _voucherRepository = voucherRepository,
    _wishlistController = wishlistController, 
    _secureStorage = secureStorage;
  
  // loading state
  final isLoading = false.obs;
  final garansiUFOPro = Rx<String?>(null);
  final subtotal = "".obs;
  final voucherPrice = Rx<String?>(null);
  final voucherTitle = Rx<String?>(null);
  final deliveryFee = Rx<String?>(null);
  final ufoPoin = Rx<String?>(null);
  // cart list
  final cartGroups = RxList<CartGroup>();
  final grandTotal = "".obs;
  final couponUsed = Rx<CouponUsed?>(null);
  final recommendedProducts = RxList<Product>([]);
  final totalItemControllers = RxList<TextEditingController>([]);
  
  final totalCartItem  = 0.obs;

  final thousandFormat = NumberFormat('#,###');
  Timer? _debounce;
  final _debounceDuration = 1000;

  @override
  void onInit() {
    super.onInit();
    
    LoginResponse.listenToLoginDataChanged(_secureStorage, (value) {
      if (value != null) {
        load();
      } else {
        cartGroups.clear();
        totalCartItem.value = 0;
        grandTotal.value = "";
      }
    });
  }

  List<CartGroup> generateCartGroupFromProducts(Map<String, List<CartProduct>> products) {
    return products.entries.map((group) => CartGroup(
        id: group.key,
        title: group.value.map((e) => e.optionText).toSet().join(","),
        items: group.value.map((e) {
          final optionSelect = e.optionSelect;
          if (optionSelect != null && optionSelect.isNotEmpty) {
            // This is for store options, so when a product have store options, we need to add depo as an option hardcoded
            final productOptionValue = optionSelect.firstOrNull?.productOptionValue;
            if (productOptionValue != null && productOptionValue.isNotEmpty) {
              // 1000 is random, not real value
              productOptionValue.insert(0, ProductOptionValue(
                productOptionValueId: "1000", 
                optionValueId: "1000", 
                name: "Depo", 
                code: "", 
                image: null, 
                price: null, 
                pricePrefix: null,
                priceOption: null
              ));
            }
          }
          final product = Product(
            productId: e.productId ?? "", 
            thumb: e.thumb ?? "", 
            logoBrand: "", 
            totalSales: null, 
            total: null, 
            name: e.name ?? "", 
            model: e.model ?? "", 
            description: "", 
            price: e.price ?? "", 
            realPrice: e.priceAmount?.toDouble(),
            special: "", 
            disc: null, 
            tax: null, 
            rating: 0, 
            href: e.href ?? "", 
            quantity: e.quantity ?? "", 
            qtySold: null, 
            priceFlashSale: null
          );


          // Create option values, by pre-selected store option from product group,
          // Because products here is grouped by its store
          final optionValues = <ProductOption, ProductOptionValue>{};
          final storeOption = optionSelect?.firstWhereOrNull((element) => element.productOptionValue.firstWhereOrNull((element) => element.optionValueId == group.key) != null);
          final storeOptionValueByProductGroup = storeOption?.productOptionValue.firstWhereOrNull((e) => e.optionValueId == group.key);
          if (storeOption != null && storeOptionValueByProductGroup != null) {
            optionValues[storeOption] = storeOptionValueByProductGroup;
          }
          
          final cartItem = CartItem(
            product: product,
            quantity: int.tryParse(e.quantity ?? "") ?? 0,
            optionSelect: optionSelect,
            option: e.option,
            stock: e.stock,
            garansiName: e.garansiName,
            garansiPrice: e.garansiPrice,
            reward: e.reward,
            groupKey: group.key,
            cartId: e.cartId,
            checkout: cartGroups
              .firstWhereOrNull((element) => element.items.firstWhereOrNull((item) => item.cartId == e.cartId) != null)?.items
              .firstWhereOrNull((element) => element.cartId == e.cartId)
              ?.checkout == true,
            garansiChecked: cartGroups
              .firstWhereOrNull((element) => element.items.firstWhereOrNull((item) => item.cartId == e.cartId) != null)?.items
              .firstWhereOrNull((element) => element.cartId == e.cartId)
              ?.garansiChecked == true,
            optionValues: optionValues
          );
          
          return cartItem;
        }
      ).toList())).toList();
  }

  Future<void> load({bool shouldShowLoading = true}) async {
    isLoading.value = shouldShowLoading;
    try {
      // final value = await _repository.getCart();
      final isNewData = cartGroups.isEmpty;


      await updateCartState();
      // Every first time load cart, check all product in first group
      if (isNewData && cartGroups.isNotEmpty) {
        onGroupCheckedChange(checked: true, cartGroup: cartGroups.firstOrNull!);
      }
      isLoading.value = false;
    } catch (error, stacktrace) {
        debugPrintStack(stackTrace: stacktrace);
    }
  }
  
  int getQuantity(Product product) {
    return cartGroups.map((element) => element.items.firstWhereOrNull((element) => element.product.productId == product.productId)?.quantity).firstOrNull ?? 0;
  }

  Future<bool> addToCart({required Product product, required Map<ProductOption, ProductOptionValue> options, int quantity = 1, int? garansiUfo, bool isBuyNow = false}) async {
    if (await LoginResponse.getLoginData(_secureStorage) == null) {
      final ensureLoggedIn = await Get.toNamed(LoginScreen.routeName);
      if (ensureLoggedIn == false || ensureLoggedIn == null) {
        return false;
      }
    }

    if (isBuyNow) {
      return await Get.showOverlay(asyncFunction: () async {
        try {
          await  _repository.addToCart(product.productId, quantity, garansiUfo, options);
          Get.toNamed(CheckoutScreen.routeName);
          return true;
        } catch (error) {
          return false;
        }
      },
      loadingWidget: const Center(child: CircularProgressIndicator()));
    } else {
      try {
        final value = await  _repository.addToCart(product.productId, quantity, garansiUfo, options);
        if (value.success == null || value.success!.isEmpty) {
          Get.showSnackbar(GetSnackBar(
            message: 'Terjadi kesalahan ${value.error?.values.toString()}',
            duration: const Duration(seconds: 2)
          ));
          return false;
        }
        await updateCartState(withEmptyBody: true);
        // Hide the current snackbar before showing a new one
        Get.closeAllSnackbars();
        Get.showSnackbar(GetSnackBar(
          message: 'Berhasil ditambahkan ke keranjang belanja!',
          duration: const Duration(seconds: 2),
          mainButton: TextButton(
            child: const Text("Lihat"),
            onPressed: () => Get.toNamed(CartScreen.routeName),
          ),
        ));
        return true;
      } catch (error) {
        return false;
      }
    }
  }

  void onGroupCheckedChange({required bool checked, required CartGroup cartGroup}) async {
    cartGroups.value = cartGroups.map((group) {
      return group.copyWith(
        items: group.items.map((item) {
          if (cartGroup.id == group.id) {
            return item.copyWith(
              checkout: checked,
              garansiChecked: checked
            );
          }

          // User select / check item from other store
          final isGroupChanging = item.checkout && group.id != cartGroup.id;
          if (isGroupChanging) {
            return item.copyWith(checkout: false, garansiChecked: false);
          }
          return item;
        }).toList()
      );
    }).toList();

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: _debounceDuration), () async {
      try {
          await updateCartState();
        } catch (error) {
          // Hide the current snackbar before showing a new one
          Get.closeAllSnackbars();
          // show snack bar notification
          Get.showSnackbar(const GetSnackBar(
            message: "Terjadi kesalahan. Silakan coba lagi.",
            duration: Duration(seconds: 2),
          ));
        }
    });
  }

  void onItemCheckedChange({required bool checked, required CartItem cartItem, required CartGroup cartGroup}) async {
    cartGroups.value = cartGroups.map((group) {
      return group.copyWith(
          items: group.items.map((item) {
            if (item.cartId == cartItem.cartId && group.id == cartGroup.id) {
              return item.copyWith(
                  checkout: checked, 
                  garansiChecked: checked
                );
            }

            // User select / check item from other store
            final isGroupChanging = item.checkout && group.id != cartGroup.id;
            if (isGroupChanging) {
              return item.copyWith(checkout: false, garansiChecked: false);
            }
            return item;
          }).toList()
        );
    }).toList();

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: _debounceDuration), () async {
      try {
          await updateCartState();
        } catch (error) {
          // Hide the current snackbar before showing a new one
          Get.closeAllSnackbars();
          // show snack bar notification
          Get.showSnackbar(const GetSnackBar(
            message: "Terjadi kesalahan. Silakan coba lagi.",
            duration: Duration(seconds: 2),
          ));
        }
    });
  }

  void onGaransiItemCheckedChange({required bool checked, required CartItem cartItem, required CartGroup cartGroup}) async {
    cartGroups.value = cartGroups.map((group) {
      return group.copyWith(
          items: group.items.map((item) {
            if (item.cartId == cartItem.cartId && group.id == cartGroup.id) {
              return item.copyWith(garansiChecked: checked);
            }
            return item;
          }).toList()
        );
    }).toList();

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: _debounceDuration), () async {
      try {
          await updateCartState();
        } catch (error) {
          // Hide the current snackbar before showing a new one
          Get.closeAllSnackbars();
          // show snack bar notification
          Get.showSnackbar(const GetSnackBar(
            message: "Terjadi kesalahan. Silakan coba lagi.",
            duration: Duration(seconds: 2),
          ));
        }
    });
  }
  
  void onIncreaseItem({required CartItem cartItem, required CartGroup cartGroup}) async {
    int? quantity;
    cartGroups.value = cartGroups.map((group) {
      if (group == cartGroup) {
        return group.copyWith(
          items: group.items.map((item) {
            if (item.cartId == cartItem.cartId) {
              quantity = item.quantity + 1;
              return cartItem.copyWith(quantity: quantity, checkout: true);
            }
            return item;
          }).toList()
        );
      }
      return group;
    }).toList();
    
    if (quantity != null) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(Duration(milliseconds: _debounceDuration), () async {
        try {
          await updateCartState();
        } catch (error) {
          // Hide the current snackbar before showing a new one
          Get.closeAllSnackbars();
          // show snack bar notification
          Get.showSnackbar(const GetSnackBar(
            message: "Terjadi kesalahan. Silakan coba lagi.",
            duration: Duration(seconds: 2),
          ));
        }
      });
    }
  }
  
  void onDecreaseItem({required CartItem cartItem, required CartGroup cartGroup}) async {
    int? quantity;
    cartGroups.value = cartGroups.map((group) {
      if (group == cartGroup) {
        return group.copyWith(
          items: cartGroup.items.map((item) {
            if (item.cartId == cartItem.cartId) {
              quantity = item.quantity - 1;
              return item.copyWith(quantity: quantity, checkout: true);
            }
            return item;
          }).toList()
        );
      }
      return group;
    }).toList();

    if (quantity != null) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(Duration(milliseconds: _debounceDuration), () async {
        try {
          await updateCartState();
        } catch (error) {
          // Hide the current snackbar before showing a new one
          Get.closeAllSnackbars();
          // show snack bar notification
          Get.showSnackbar(const GetSnackBar(
            message: "Terjadi kesalahan. Silakan coba lagi.",
            duration: Duration(seconds: 2),
          ));
        }
      });
    }
  }
  
  void onChangeItemQuantity({required int quantity, required CartItem cartItem, required CartGroup cartGroup}) async {
    cartGroups.value = cartGroups.map((group) {
      if (group == cartGroup) {
        return group.copyWith(
          items: group.items.map((item) {
            if (item.cartId == cartItem.cartId) {
              return cartItem.copyWith(quantity: quantity, checkout: true);
            }
            return item;
          }).toList()
        );
      }
      return group;
    }).toList();

      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(Duration(milliseconds: _debounceDuration), () async {
        try {
          await updateCartState();
        } catch (error) {
          // Hide the current snackbar before showing a new one
          Get.closeAllSnackbars();
          // show snack bar notification
          Get.showSnackbar(const GetSnackBar(
            message: "Terjadi kesalahan. Silakan coba lagi.",
            duration: Duration(seconds: 2),
          ));
        }
      });
  }

  Future<void> onRemoveItem({required CartItem cartItem, required CartGroup cartGroup, bool showSnackbar = true}) async {
    try {
      cartGroups.value = cartGroups.map((group) {
        if (group == cartGroup) {
          return group.copyWith(
            items: group.items.map((item) {
              if (item.cartId == cartItem.cartId) {
                return cartItem.copyWith(quantity: 0, garansiChecked: false, checkout: true);
              }
              return item;
            }).toList()
          );
        }
        return group;
      }).toList();

      if (await updateCartState() && showSnackbar) {
        // Hide the current snackbar before showing a new one
        Get.closeAllSnackbars();

        // show snack bar notification
        Get.showSnackbar(GetSnackBar(
          message: "${cartItem.quantity} barang berhasil dihapus",
          duration: const Duration(seconds: 2),
        ));
      }
    } catch (error) {
      // Hide the current snackbar before showing a new one
      Get.closeAllSnackbars();
      // show snack bar notification
      Get.showSnackbar(const GetSnackBar(
        message: "Terjadi kesalahan. Silakan coba lagi.",
        duration: Duration(seconds: 2),
      ));
    }
  }

  // void onWishlistItem({required CartItem cartItem, required CartGroup cartGroup}) async {
  //   final wishlisted = isWishlisted(cartItem: cartItem);
  //   if (!wishlisted) {
  //     _wishlistController.addToWishlist(cartItem.product.productId);
  //   }
    
  //   await onRemoveItem(cartItem: cartItem, cartGroup: cartGroup, showSnackbar: false);

  //   // Hide the current snackbar before showing a new one
  //   Get.closeAllSnackbars();

  //   // show snack bar notification
  //   Get.showSnackbar(const GetSnackBar(
  //     message: "Barang berhasil dipindahkan ke wishlist",
  //     duration: Duration(seconds: 2),
  //   ));
  // }

  Future<bool> updateOptionValue({
    required CartItem cartItem, 
    required CartGroup cartGroup, 
    required ProductOption option,
    required ProductOptionValue value
  }) async {

    final lastSelectionOptionValue = cartItem.optionValues?[option];
    
    cartGroups.value = cartGroups.map((group) {
      if (group == cartGroup) {
        return group.copyWith(
          items: group.items.map((item) {
            if (item == cartItem) {
              final optionValues = cartItem.optionValues ?? {};
              final optionValue = cartItem
                  .optionSelect
                  ?.firstWhereOrNull((e) => e == option)
                  ?.productOptionValue
                  .firstWhereOrNull((optionValue) => optionValue.name == value.name);
              if (optionValue != null) {
                optionValues[option] = optionValue;
              }
              return cartItem.copyWith(
                optionValues: optionValues
              );
            }
            return item;
          }).toList()
        );
      }
      return group;
    }).toList();

    if (option.name?.toLowerCase() == "store") {
      final storeIsChanged = lastSelectionOptionValue != value;
      if (storeIsChanged) {
        // Unchecked all other item
        cartGroups.value = cartGroups.map((group) {
          return group.copyWith(
            items: group.items.map((item) {
              return item.copyWith(
                checkout: item.cartId == cartItem.cartId,
              );
            }).toList()
          );
        }).toList();
      }
    } else {
      
    }
    await load(shouldShowLoading: false);
    return false;
  }

  // `With empty body` is useful when you want to only update from cart response (BE)
  Future<bool> updateCartState({bool withEmptyBody = false}) async {
    final cartIdAndPriceGaransis = Map.fromEntries(cartGroups
      .map((element) => element.items
        .where((element) => element.checkout == true)
        .map((e) => MapEntry(e.cartId ?? "", e.garansiChecked == true ? e.garansiPrice ?? 0 : 0.0))
      ).flattened);

    final cartIdAndQuantities = Map.fromEntries(cartGroups
      .map((element) => element.items
        .where((element) => element.checkout == true)
        .map((e) => MapEntry(e.cartId ?? "", e.quantity))
      ).flattened);

    final cartIdAndStores = Map.fromEntries(cartGroups
      .map((element) => element.items
        .where((element) => element.checkout == true && element.store != null)
        .map((e) => MapEntry(e.cartId ?? "", e.store ?? ""))
        .whereNotNull()
      ).flattened);

    final checkedCartIds = cartGroups.map((element) => element.items.where((element) => element.checkout).map((e) => e.cartId ?? "")).flattened.toList();
    
    return _repository.editCart(EditCartRequest(
      checkedCartIds: withEmptyBody ? [] : checkedCartIds, 
      cartIdAndPriceGaransis: withEmptyBody ? {} : cartIdAndPriceGaransis, 
      cartIdAndQuantities: withEmptyBody ? {} : cartIdAndQuantities,
      cartIdAndStores: withEmptyBody ? {} : cartIdAndStores
    ))
    .then((value) {
      cartGroups.value = generateCartGroupFromProducts(value.products);
      couponUsed.value = value.useCoupon;
      totalCartItem.value = cartGroups.map((element) => element.items.map((e) => e.quantity).sum).sum;
      totalItemControllers.value = List.generate(
        cartGroups.map((element) => element.items.length).sum,
        (index) => TextEditingController(),
      );
      grandTotal.value = "Rp ${thousandFormat.format(value.totals.firstWhereOrNull((total) => total.title?.toLowerCase() == "total")?.value ?? 0)}";
      garansiUFOPro.value = "Rp ${thousandFormat.format(value.totals.firstWhereOrNull((total) => total.title?.toLowerCase().contains("garansi") == true)?.value ?? 0)}";
      subtotal.value = "Rp ${thousandFormat.format(value.totals.firstWhereOrNull((total) => total.title?.toLowerCase().contains("sub-total") == true)?.value ?? 0)}";
      voucherPrice.value = "Rp -${thousandFormat.format(value.totals.firstWhereOrNull((total) => total.title?.toLowerCase().contains("voucher") == true)?.value ?? 0)}";
      voucherTitle.value = value.totals.firstWhereOrNull((total) => total.title?.toLowerCase().contains("voucher") == true)?.title;
      ufoPoin.value = thousandFormat.format(value.totals.firstWhereOrNull((total) => total.title?.toLowerCase().contains("poin") == true)?.value ?? 0);
      recommendedProducts.value = value.productsRecomended;
      return true;
    })
    .catchError((error, stacktrace) {
      // Hide the current snackbar before showing a new one
      Get.closeAllSnackbars();
      // show snack bar notification
      Get.showSnackbar(const GetSnackBar(
        message: "Terjadi kesalahan. Silakan coba lagi.",
        duration: Duration(seconds: 2),
      ));
      return false;
    });
  }

  Future<bool> checkout() async {
    final itemChecked = cartGroups.map((element) => element.items.where((element) => element.checkout)).flattened.toList().length;
    if (itemChecked > 0) {
      return Get.showOverlay(
        asyncFunction: () async {
          final success = await updateCartState();
          if (success) {
            Get.toNamed(CheckoutScreen.routeName);
          }
          return success;
        },
        loadingWidget: const Center(child: CircularProgressIndicator())
      );
    } else {
      // Hide the current snackbar before showing a new one
      Get.closeAllSnackbars();
      // show snack bar notification
      Get.showSnackbar(const GetSnackBar(
        message: "Pilih barang terlebih dahulu",
        duration: Duration(seconds: 2),
      ));
      return false;
    }
  }

  void buyAgain(String orderId) {
    _repository.buyAgainThisOrder(orderId)
      .then((value) {
        load(shouldShowLoading: false);
        Get.showSnackbar(const GetSnackBar(
          message: "Berhasil menambahkan produk ke keranjang",
          duration: Duration(seconds: 3),
        ));
      })
      .catchError((error) {
        if (error is DioException) {
          Get.showSnackbar(const GetSnackBar(
            message: "Terjadi kesalahan, silakan coba lagi.",
            duration: Duration(seconds: 3),
          ));
        }
      });
  }

  void removeVoucher() {
    _voucherRepository.removeActiveCoupon()
    .then((value) {
      print(value);
    })
    .catchError((error) {
      if (error is DioException) {
        Get.showSnackbar(const GetSnackBar(
          message: "Terjadi kesalahan, silakan coba lagi.",
          duration: Duration(seconds: 3),
        ));
      }
    });
  }

  bool isWishlisted({required CartItem cartItem}) => _wishlistController.wishlist.value?.products.firstWhereOrNull((element) => element.productId == cartItem.product.productId) != null;

}