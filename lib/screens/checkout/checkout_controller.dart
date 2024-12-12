import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/cart/cart_response.dart';
import 'package:ufo_elektronika/screens/checkout/checkout_repository.dart';
import 'package:ufo_elektronika/screens/checkout/checkout_response.dart';
import 'package:ufo_elektronika/screens/checkout/process_checkout_request.dart';
import 'package:ufo_elektronika/screens/checkout_payment_confirmation/manual/checkout_payment_manual_screen.dart';
import 'package:ufo_elektronika/screens/main/main_screen.dart';
import 'package:ufo_elektronika/screens/transaction_detail/transaction_detail_screen.dart';
import 'package:ufo_elektronika/screens/user/address/address_repository.dart';
import 'package:ufo_elektronika/screens/user/address/address_response.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/address_add_update_screen.dart';
import 'package:ufo_elektronika/screens/user/update/user_update_repository.dart';
import 'package:ufo_elektronika/screens/user/update/user_update_screen.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_controller.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_repository.dart';
import 'package:ufo_elektronika/shared/providers/midtrans_provider.dart';
import 'package:ufo_elektronika/shared/utils/state_controller.dart';

class CheckoutController extends StateController<CheckoutResponse> {
  final CheckoutRepository _repository;
  final VoucherRepository _voucherRepository;
  final AddressRepository _addressRepository;
  final UserUpdateRepository _userUpdateRepository;
  final MidtransProvider _midtransProvider;
  CheckoutController({
    required CheckoutRepository repository,
    required AddressRepository addressRepository,
    required VoucherRepository voucherRepository,
    required UserUpdateRepository userUpdateRepository,
    required MidtransProvider midtransProvider
  }): _repository = repository, 
    _addressRepository = addressRepository, 
    _voucherRepository = voucherRepository, 
    _userUpdateRepository = userUpdateRepository,
    _midtransProvider = midtransProvider 
  {
    selectedPaymentMethod.listen((method) {
      final voucherCode = state?.useCoupon.firstOrNull?.code;
      if (method != null && voucherCode != null) {
        _voucherRepository.claim(code: voucherCode, source: VoucherClaimSource.checkout, paymentMethod: method.code)
          .then((value) {
            if (value.error != null) {
              Get.showSnackbar(GetSnackBar(
                message: value.error,
                duration: const Duration(seconds: 3),
              ));
            }
          })
          .catchError((error) {
            Get.showSnackbar(GetSnackBar(
              message: error is DioException ? error.response?.data["error"] : "Ada kesalahan dalam mengambil data. Silakan coba lagi.",
              duration: const Duration(seconds: 3),
            ));
            load(shouldShowLoading: false);
            return error;
          });
      }
    });
  }

  final garansiChecked = RxMap<CartProduct, bool>({});
  final garansiPrice = 0.0.obs;
  final finalPrice = 0.0.obs;
  final notes = "".obs;

  // Delivery Bottomsheet states
  final clickAndCollectShippingMethodSelected = false.obs;
  final clickAndCollectPickupDate = Rx<DateTime?>(null);
  final clickAndCollectCollapsed = false.obs;
  final kurirCollapsed = false.obs;

  // Address Bottomsheet states
  final selectedAddress = Rx<Address?>(null);
  final previouslyAddressBottomSheetShown = false.obs;
  final selectedShippingMethod = Rx<ShippingMethod?>(null);
  final kurirTokoShippingMethod = Rx<ShippingMethod?>(null);
  final shippingMethodError = Rx<String?>(null);

  // Payment Method Bottomsheet states
  final paymentMethodGroups = RxList<MethodDataPayment>();
  final selectedPaymentMethod = Rx<Method?>(null);
  final paymentMethodError = Rx<String?>(null);

  final isPackingKayuChecked = false.obs;

  final isProcessingCheckout = false.obs;

  Future<CheckoutResponse> load({bool shouldShowLoading = true}) {
    _userUpdateRepository.getProfile()
      .then((value) {
        if (value.fullname?.trim().isEmpty == true || value.email?.trim().isEmpty == true || value.telephone?.trim().isEmpty == true) {
          Get.toNamed(UserUpdateScreen.routeName);
          Get.showSnackbar(const GetSnackBar(
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColor.primaryColor,
            message: "Silakan melengkapi nama, email dan nomor telepon terlebih dahulu",
            duration: Duration(seconds: 2),
          ));

        }
      });
    return futurize(() async {
      try {
        return await _repository.loadCheckout(addressId: selectedAddress.value?.addressId);
      } catch (error) {
        if (error is DioException && ((error).response?.statusCode == 404 || error.response?.data["error"] == "Data Empty")) {
          Get.back();
          Get.showSnackbar(const GetSnackBar(
            message: "Barang yang kamu mau beli habis. Silakan coba barang lain ya",
            duration: Duration(seconds: 2),
          ));
        }
        rethrow;
      }
    }, shouldShowLoading: shouldShowLoading, onFinishLoading: (checkout) {
      for (var product in checkout.product) {
        garansiChecked[product] = (product.garansiPrice ?? 0) > 0;
      }
      paymentMethodGroups.assignAll(checkout.methodDataPayment);
      final lastSelectedAddress = selectedAddress.value;
      selectedAddress.value = checkout.addresses[checkout.addressId?.toString()];
      if (lastSelectedAddress?.addressId != selectedAddress.value?.addressId) {
        selectedShippingMethod.value = null;
      }
      kurirTokoShippingMethod.value = ShippingMethod.kurirToko.copyWith(cost: checkout.kurirTokoPrice);
      // selectedShippingMethod.value = checkout.shippingMethod.firstOrNull ?? kurirTokoShippingMethod.value;
      calculateGaransiPrice();
      calculateFinalPrice();
      if (checkout.addresses.isEmpty) {
        Get.toNamed(AddressAddUpdateScreen.routeName);
        Get.showSnackbar(const GetSnackBar(
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColor.primaryColor,
          message: "Silakan menambahkan alamat terlebih dahulu",
          duration: Duration(seconds: 2),
        ));
      }
    });
  }

  void processCheckout() async {
    if (selectedShippingMethod.value == null && clickAndCollectShippingMethodSelected.value == false) {
      shippingMethodError.value = "Tipe Pengiriman belum terpilih";
    } else {
      shippingMethodError.value = null;
    }

    if (clickAndCollectShippingMethodSelected.value == true && clickAndCollectPickupDate.value == null) {
    Get.showSnackbar(const GetSnackBar(message: "Pilih Tanggal Pengiriman terlebih dahulu", duration: Duration(seconds: 2)));
    return;
    }
    if (selectedPaymentMethod.value == null) {
      paymentMethodError.value = "Metode pembayaran belum terpilih";
    } else {
      paymentMethodError.value = null;
    }

    if (paymentMethodError.value != null || shippingMethodError.value != null) {
      return;
    }

    final garansis = <String, double>{};
    state?.product.forEach((product) {
      if (product.cartId != null) garansis[product.cartId!] = product.garansiPrice ?? 0;
    });

    isProcessingCheckout.value = true;
    final totals = [
      state?.totalPriceNum?.toString() ?? "",
      state?.totalGaransiPrice.toString() ?? "",
      selectedShippingMethod.value?.cost.toString() ?? "",
      state?.biayaLayanan.toString() ?? ""
    ];
    if (isPackingKayuChecked.value == true) {
      totals.add(state?.packingKayuPrice.toString() ?? "");
    }
    totals.add(finalPrice.value.toString());
    final request = ProcessCheckoutRequest(
      addressId: selectedAddress.value?.addressId ?? "", 
      deliveryGroup: clickAndCollectShippingMethodSelected.value == true ? DeliveryGroup.clickAndCollect : DeliveryGroup.delivery, 
      paymentMethod: "${selectedPaymentMethod.value?.code}-${selectedPaymentMethod.value?.title}", 
      totals: totals, 
      garansis: garansis,
      cost: selectedShippingMethod.value?.cost?.toDouble(),
      coupon: "",
      courier: selectedShippingMethod.value?.code,
      // jenisPengirimanKurir: selectedShippingMethod.value?.codeGroup,
      // deliveryType: selectedShippingMethod.value?.codeGroup,
      shippingTaxClassId: selectedShippingMethod.value?.taxClassId?.toString(),
      shippingTitle: selectedShippingMethod.value?.title,
      e1: clickAndCollectPickupDate.value != null ?DateFormat("y-M-d").format(clickAndCollectPickupDate.value!) : null,
      notes: notes.value,
      store: clickAndCollectShippingMethodSelected.value == true ? state?.optLoc : null,
      isPackingKayu: isPackingKayuChecked.value
    );
    try {
      if (selectedPaymentMethod.value?.code?.contains("trf") == true) {
        final redirectionUrl = await _repository.processCheckoutManual(request);
        // Pop to root first
        while (Get.currentRoute != MainScreen.routeName) {
          Get.back();
        }
        Get.toNamed(CheckoutPaymentManualConfirmationScreen.routeName, parameters: {"redirection_url": redirectionUrl});
      } else {
        final res = await _repository.processCheckoutSnap(request);
        final midtrans = _midtransProvider.getMidtransSDK?.call();
        if (res.errors.isEmpty) {
          if (res.redirectUrl != null && res.token != null) {
            if (midtrans != null) {
              midtrans.setTransactionFinishedCallback((result) {
                final orderId = res.data?.orderId?.toString();
                if (orderId != null) {
                  Get.toNamed(TransactionDetailScreen.routeName, parameters: {"id": orderId});
                }
                if (result.isTransactionCanceled) {
                  Get.showSnackbar(const GetSnackBar(
                    message: "Kamu membatalkan pembayaran",
                    duration: Duration(seconds: 2),
                  ));
                } else {
                  switch (result.transactionStatus) {
                    case TransactionResultStatus.cancel:
                      break;
                    case TransactionResultStatus.capture:
                      break;
                    case TransactionResultStatus.settlement:
                      break;
                    case TransactionResultStatus.pending:
                      break;
                    case TransactionResultStatus.deny:
                      break;
                    case TransactionResultStatus.expire:
                      break;
                    case null:
                      break;
                  }
                }
              });
              midtrans.startPaymentUiFlow(token: res.token);
            } else {
              Get.showSnackbar(const GetSnackBar(
                message: "Terjadi kesalahan. Silakan coba lagi",
                duration: Duration(seconds: 3),
              ));
            }
          } else {
            Get.showSnackbar(const GetSnackBar(
              message: "Terjadi kesalahan. Silakan coba lagi",
              duration: Duration(seconds: 3),
            ));
          }
        } else {
          Get.showSnackbar(GetSnackBar(
            message: res.errors.firstOrNull?.toString(),
            duration: const Duration(seconds: 3),
          ));
        }
      }
      // Get.toNamed(CheckoutProcessingScreen.routeName);
      isProcessingCheckout.value = false;
    } catch (error) {
      if (error is DioException) {
        Get.showSnackbar(GetSnackBar(
          message: error.response?.data["error"].toString(),
          duration: const Duration(seconds: 3),
        ));
      } else {
        Get.showSnackbar(const GetSnackBar(
          message: "Terjadi kesalahan dalam proses checkout. Silakan coba lagi",
          duration: Duration(seconds: 2),
        ));
      }
      isProcessingCheckout.value = false;
    }

  }

  void garansiCheckedChange({required CartProduct product, required bool checked}) {
    garansiChecked[product] = checked;
    calculateGaransiPrice();
    calculateFinalPrice();
  }

  void selectDelivery({bool? isClickAndCollect, ShippingMethod? shippingMethod}) {
    clickAndCollectShippingMethodSelected.value = isClickAndCollect == true;
    selectedShippingMethod.value = shippingMethod;
    calculateFinalPrice();
  }

  void calculateGaransiPrice() {
    garansiPrice.value = (state?.totalGaransiPrice ?? 0).toDouble();

  }

  void calculateFinalPrice() {
    finalPrice.value = (state?.totalPriceNum ?? 0) + 
      garansiPrice.value + 
      (state?.biayaLayanan ?? 0) +
      (selectedShippingMethod.value?.cost ?? kurirTokoShippingMethod.value?.cost ?? 0) + 
      (isPackingKayuChecked.value ? (state?.packingKayuPrice ?? 0) : 0) +
      (state?.allPrice.firstWhereOrNull((price) => price.code == "coupon")?.value ?? 0);
  }
}