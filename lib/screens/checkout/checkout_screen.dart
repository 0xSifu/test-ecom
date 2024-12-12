import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/checkout/checkout_controller.dart';
import 'package:ufo_elektronika/screens/checkout/checkout_response.dart';
import 'package:ufo_elektronika/screens/user/address/address_response.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/address_add_update_screen.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_binding.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_controller.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_screen.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/common/modal_bottom_sheet_default.dart';
import 'package:ufo_elektronika/widgets/image.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  static const routeName = "/process-checkout";
  const CheckoutScreen({super.key});

  void showDeliveryOptionBottomSheet(BuildContext context) {
    final thousandFormat = NumberFormat('#,###');
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
      ),
      builder: (context) {
        return ModalBottomSheetDefault(
            title: "PILIH PENGIRIMAN",
            initialChildSize: 0.7,
            child: (scrollController) => controller.obx((state) {
              if (state == null) return Container();
              final checkout = state;
              bool clickAndCollectCollapsed = false;
              bool kurirCollapsed = false;

              bool clickAndCollectShippingMethodSelected = controller.clickAndCollectShippingMethodSelected.value;
              DateTime? selectedPickupDate = controller.clickAndCollectPickupDate.value;
              ShippingMethod? selectedShippingMethod = controller.selectedShippingMethod.value;
              final kurirTokoShippingMethod = controller.kurirTokoShippingMethod.value;
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: StatefulBuilder(
                        builder: (context, setState) {

                        void selectDelivery({bool? isClickAndCollect, ShippingMethod? shippingMethod}) {
                          setState(() {
                            clickAndCollectShippingMethodSelected = isClickAndCollect == true;
                            selectedShippingMethod = shippingMethod;
                            controller.shippingMethodError.value = null;
                          });
                        }
                        return Column(
                          children: [
                            /************************** Click & Collect **********************************/
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      clickAndCollectCollapsed = !clickAndCollectCollapsed;
                                    });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 17),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Click & Collect", style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryColor, fontSize: 13)),
                                        Icon(Icons.arrow_drop_down, color: Color(0xFFFBAA1A))
                                      ],
                                    ),
                                  ),
                                ),
                                if (!clickAndCollectCollapsed && checkout.optLoc?.isNotEmpty == true)
                                  InkWell(
                                    onTap: () {
                                      selectDelivery(isClickAndCollect: true);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 18, top: 17, bottom: 17, left: 5),
                                      color: const Color(0xFFEEF3F7),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: clickAndCollectShippingMethodSelected, 
                                            onChanged: (value) { 
                                              selectDelivery(isClickAndCollect: value == true);
                                            }
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text("Store"),
                                                Container(
                                                  color: Colors.white,
                                                  child: DropdownButtonFormField(
                                                    isExpanded: true,
                                                    padding: EdgeInsets.zero,
                                                    itemHeight: kMinInteractiveDimension,
                                                    icon: const Icon(                // Add this
                                                      Icons.arrow_drop_down,  // Add this
                                                      color: Color(0xFFFBAA1A),   // Add this
                                                    ),
                                                    decoration: const InputDecoration(
                                                      border: InputBorder.none,
                                                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                                    ),
                                                    value: checkout.optLoc,
                                                    items: [checkout.optLoc]
                                                      .map((text) => DropdownMenuItem(
                                                        value: text, 
                                                        child: Text(text ?? "", style: const TextStyle(fontSize: 11),))
                                                      )
                                                      .toList(), 
                                                    onChanged: clickAndCollectShippingMethodSelected != true ? null : (value) {

                                                    }
                                                  ),
                                                ),

                                                const SizedBox(height: 8),

                                                const Text("Pilih Tanggal Pickup"),
                                                InkWell(
                                                  onTap: clickAndCollectShippingMethodSelected != true ? null : () {
                                                    showDatePicker(
                                                      context: context, 
                                                      firstDate: DateTime.now(), 
                                                      lastDate: DateTime.now().add(const Duration(days: 10)),
                                                      initialDate: selectedPickupDate
                                                    )
                                                      .then((date) {
                                                        setState(() {
                                                          if (date != null) selectedPickupDate = date;
                                                        });
                                                      });
                                                  },
                                                  child: Container(
                                                    color: Colors.white,
                                                    padding: const EdgeInsets.only(left: 10, right: 15, top: 12, bottom: 12),
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons.calendar_month, color: AppColor.primaryColor),
                                                        const SizedBox(width: 8),
                                                        Expanded(
                                                          child: Text(selectedPickupDate == null ? "Pilih Tanggal" : DateFormat("dd MMM yyyy").format(selectedPickupDate!))
                                                        ),
                                                        const Icon(Icons.arrow_drop_down, color: Color(0xFFFBAA1A))
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                if (!clickAndCollectCollapsed && checkout.optLoc?.isEmpty == true)
                                  Row(
                                    children: [
                                      const SizedBox(width: 15),
                                      Image.asset("assets/icon/ufomen_sad.webp", width: 60),
                                      const SizedBox(width: 8),
                                      const Expanded(
                                        child: Text("Maaf, produk yang kamu beli tidak mendukung pengiriman \"Click & Collect\""),
                                      ),
                                      const SizedBox(width: 15,)
                                    ],
                                  ),
                                const SizedBox(height: 10),
                              ],
                            ),

                            /************************** Kurir ******************************/
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      kurirCollapsed = !kurirCollapsed;
                                    });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 17),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Kurir", style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryColor, fontSize: 13)),
                                        Icon(Icons.arrow_drop_down, color: Color(0xFFFBAA1A))
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(height: 1, color: AppColor.primaryColor),
                                if (!kurirCollapsed)
                                  for (var shippingMethod in checkout.shippingMethod)
                                    InkWell(
                                      onTap: () {
                                        selectDelivery(shippingMethod: shippingMethod);
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(right: 18, top: 4, bottom: 4, left: 5),
                                            color: const Color(0xFFEEF3F7),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Checkbox(value: selectedShippingMethod == shippingMethod, onChanged: (value) { 
                                                      if (value == true) {
                                                        selectDelivery(shippingMethod: shippingMethod);
                                                      }
                                                    }),
                                                    const SizedBox(width: 4),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(shippingMethod.title ?? shippingMethod.headTitle ?? "", style: const TextStyle(fontSize: 13)),
                                                        Text(shippingMethod.etd ?? "", style: const TextStyle(fontSize: 10))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Text("Rp ${thousandFormat.format(shippingMethod.cost)}", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColor.primaryColor))
                                              ],
                                            ),
                                          ),
                                          const Divider(height: 1, color: Colors.white)
                                        ],
                                      ),
                                    )
                              ],
                            )
                          ],
                        );
                      }),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                    child: SafeArea(
                      top: false,
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            controller.selectDelivery(isClickAndCollect: clickAndCollectShippingMethodSelected == true, shippingMethod: selectedShippingMethod);
                            controller.clickAndCollectPickupDate.value = selectedPickupDate;
                            Navigator.pop(context);
                          },
                          child: const Text("Gunakan Pengiriman ini"),
                        ),
                      ),
                    ),
                  )
                ],
              );
            
            }),
        );
    });
  }

  void showAddressOptionBottomSheet(BuildContext context) {
    controller.previouslyAddressBottomSheetShown.value = true;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
      ),
      builder: (context) {
        return ModalBottomSheetDefault(
          title: "PILIH ALAMAT",
          child: (scrollController) => controller.obx((state) {
            if (state == null) return Container();
            final checkout = state;
            Address? selectedAddress = controller.selectedAddress.value;
            
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: StatefulBuilder(
                      builder: (context, setState) {
                      return Column(
                        children: [
                          for (var addressEntry in checkout.addresses.entries)
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedAddress = addressEntry.value;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
                                decoration: BoxDecoration(
                                  border: Border.all(color: addressEntry.value.addressId == selectedAddress?.addressId ? AppColor.primaryColor : Colors.grey.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(6)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text("${addressEntry.value.lastname}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.primaryColor),),
                                            const SizedBox(width: 8),
                                            if (addressEntry.value.addressId == controller.selectedAddress.value?.addressId)
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFCCDFEF),
                                                  borderRadius: BorderRadius.circular(6)
                                                ),
                                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                                                child: const Text("Alamat Terpilih", style: TextStyle(fontSize: 9, color: AppColor.primaryColor)),
                                              )
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () { 
                                            Navigator.pop(context);
                                            Get.toNamed(AddressAddUpdateScreen.routeName, parameters: {
                                              "id": addressEntry.value.addressId ?? ""
                                            });
                                          }, 
                                          icon: const FaIcon(FontAwesomeIcons.penToSquare, size: 15, color: AppColor.primaryColor)
                                        )
                                      ],
                                    ),
                                    Text(addressEntry.value.address2 ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                    Text(addressEntry.value.detail, style: const TextStyle(fontSize: 11))
                                  ],
                                ),
                              ),
                            )
                        ],
                      );
                    }),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              controller.previouslyAddressBottomSheetShown.value = false;
                              controller.selectedAddress.value = selectedAddress;
                              Get.showOverlay(
                                asyncFunction: () => controller.load(shouldShowLoading: false),
                                loadingWidget: const Center(child: CircularProgressIndicator())
                              );
                              Navigator.pop(context);
                            },
                            child: const Text("Gunakan Alamat ini"),
                          ),
                        ),
                        const Text("Atau"),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              Get.toNamed(AddressAddUpdateScreen.routeName);
                            },
                            child: const Text("Tambah Alamat lain"),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
        );
    }).whenComplete((() {
      controller.previouslyAddressBottomSheetShown.value = false;
    }));
  }
  
  void showPaymentMethodOptionBottomSheet(BuildContext context) {
    final paymentMethodOpens = Map<MethodDataPayment, bool>.fromEntries(
      controller.paymentMethodGroups.map((e) => MapEntry(e, false))
    );
    Method? selectedMethod = controller.selectedPaymentMethod.value;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
      ),
      builder: (context) {
        return ModalBottomSheetDefault(
          title: "METODE PEMBAYARAN",
          initialChildSize: 0.7,
          child: (scrollController) => StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: controller.paymentMethodGroups.length,
                      itemBuilder: (context, index) {
                        final paymentGroup = controller.paymentMethodGroups[index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  final open = paymentMethodOpens[paymentGroup] ?? false;
                                  paymentMethodOpens[paymentGroup] = !open;
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    color: const Color(0xFFEEF3F7),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(paymentGroup.group ?? ""),
                                        if (paymentMethodOpens[paymentGroup] == true)
                                          const Icon(Icons.arrow_drop_up)
                                        else
                                          const Icon(Icons.arrow_drop_down)
                                      ],
                                    )
                                  ),
                                  const Divider(height: 1, color: Colors.white)
                                ],
                              ),
                            ),

                            if (paymentMethodOpens[paymentGroup] == true)
                            for (var paymentMethod in paymentGroup.methods)
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedMethod = paymentMethod;
                                  });
                                },
                                child: Column(
                                  children: [
                                     Container(
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          Checkbox(value: selectedMethod == paymentMethod, onChanged: (value) {
                                            setState(() {
                                              if (value == true) {
                                                selectedMethod = paymentMethod;
                                              }
                                            });
                                          }),
                                          UEImage2(paymentMethod.thumb ?? "", width: 70)
                                        ],
                                      ),
                                    ),
                                    const Divider(height: 1, color: Color(0xFFEEEEEE))
                                  ],
                                ),
                              )
                          ],
                        );
                      },
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            controller.selectedPaymentMethod.value = selectedMethod;
                            controller.paymentMethodError.value = null;
                            Navigator.pop(context);
                          },
                          child: const Text("GUNAKAN PEMBAYARAN INI"),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          )
        );
    });
  }
  
  @override
  Widget build(BuildContext context) {

    // thousand format for price
    final thousandFormat = NumberFormat('#,###');

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        
      },
      child: VisibilityDetector(
        key: const Key("checkout"), 
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction >= 1) {
            controller.load();
          }
        }, 
        child: Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          appBar: const UEAppBar(
            title: 'Checkout',
            showCart: false, 
            showNotification: false
          ),
          body: controller.obx((state) {
            if (state == null) return const Center(child: CircularProgressIndicator());
            final checkout = state;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        ...(checkout.product.map((product) {
                          return Container(
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(vertical: 3),
                            padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.name ?? "", style: const TextStyle(color: AppColor.primaryColor, fontSize: 13)),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    UEImage2(product.thumb ?? "", width: 71, height: 71),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Store: ${checkout.stores.firstOrNull?.name ?? "-"}", style: const TextStyle(fontSize: 10)),
                                          ...(product.option.map((e) => Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                            child: Text("${e.name} : ${e.value}", style: const TextStyle(color: Colors.grey, fontSize: 11),),
                                          ))),
                                          Text("UFO Poin: ${product.reward}", style: const TextStyle(fontSize: 10)),
                                          Text(product.total ?? "", style: const TextStyle(color: Color(0xFFFBAA1A), fontSize: 15, fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        if (controller.garansiChecked[product] == true)
                                          Column(
                                            children: [
                                              // Image.asset("assets/icon/ufoe-icon-verfied.png", width: 20),
                                              // const SizedBox(width: 4),
                                              // Checkbox(value: controller.garansiChecked[product], onChanged: null
                                              // // (value) {
                                              // //   controller.garansiCheckedChange(product: product, checked: value == true);
                                              // // })
                                              // ),
                                              Image.asset("assets/icon/ufo-protection.png", width: 29),
                                              const SizedBox(width: 4),
                                              // const Text("Garansi UFO PRO ", style: TextStyle(color: AppColor.primaryColor, fontSize: 10)),
                                              Text(product.garansiName ?? "", style: const TextStyle(fontSize: 10)),
                                              const SizedBox(height: 8)
                                            ],
                                          ),
                                        Text("Jumlah: ${product.quantity}", style: const TextStyle(fontSize: 10))
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          );
                        })),
                        /* --------------------------------- address -------------------------------- */
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [/************************* Product ****************************/
                              
                              const SizedBox(height: 6),
                              Text('Alamat pengiriman'.toUpperCase(), 
                                style: const TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.bold)
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 15),
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(controller.selectedAddress.value?.lastname ?? controller.selectedAddress.value?.firstname ?? "", style: const TextStyle(color: AppColor.primaryColor)),
                                        IconButton(
                                          onPressed: () {
                                            Get.toNamed(AddressAddUpdateScreen.routeName, parameters: {
                                              "id": checkout.addressId?.toString() ?? ""
                                            });
                                          }, 
                                          constraints: const BoxConstraints(), // override default min size of 48px
                                          style: const ButtonStyle(
                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // the '2023' part
                                          ),
                                          icon: const Icon(FontAwesomeIcons.penToSquare, color: AppColor.primaryColor, size: 18),
                                          padding: EdgeInsets.zero,
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(controller.selectedAddress.value?.address2 ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      controller.selectedAddress.value?.detail ?? "",
                                      style: const TextStyle(fontSize: 11),
                                    ),
                                    const Divider(),
                                    Center(
                                      child: TextButton(
                                        onPressed: () { 
                                          showAddressOptionBottomSheet(context);
                                        }, 
                                        child: const Text("Gunakan Alamat Lain", 
                                          style: TextStyle(fontWeight: FontWeight.bold)
                                        )
                                      )
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 6),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Tulis Pesan Anda',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: AppColor.grayText,
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                constraints: BoxConstraints(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 15)
                              ),
                              onChanged: (value) {
                                controller.notes.value = value;
                              },
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              /* --------------------------------- courier -------------------------------- */

                              // Text("Pilih Pengiriman".toUpperCase(), style: const TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              InkWell(
                                onTap: () {
                                  showDeliveryOptionBottomSheet(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: controller.shippingMethodError.value != null ? const Color(0xFFFFE1E1) : AppColor.primaryColor,
                                    border: controller.shippingMethodError.value != null ? Border.all(width: 0.5, color: const Color(0xFFE90F0F)) : null,
                                    borderRadius: controller.shippingMethodError.value != null ? BorderRadius.circular(4) : null
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          if (controller.shippingMethodError.value != null)
                                            Row(
                                              children: [
                                                Image.asset("assets/icon/exclamation.png", width: 19),
                                                const SizedBox(width: 8)
                                              ],
                                            ),
                                          Text(
                                            controller.selectedShippingMethod.value?.title ?? controller.selectedShippingMethod.value?.headTitle ?? 
                                            (controller.clickAndCollectShippingMethodSelected.value == true ? "Click & Collect" : "Pilih Tipe Pengiriman"), 
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: controller.shippingMethodError.value != null ? AppColor.primaryColor : Colors.white
                                            )
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(controller.selectedShippingMethod.value != null ? "(Rp.${controller.selectedShippingMethod.value?.cost.toString() ?? 0})" : "", style: const TextStyle(
                                            fontSize: 13,
                                            color: AppColor.primaryColor,
                                            fontWeight: FontWeight.bold
                                          )),
                                          const SizedBox(width: 8),
                                          Icon(Icons.arrow_right, color: controller.shippingMethodError.value != null ? AppColor.primaryColor :  const Color(0xFFFBAA1A))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              if (controller.shippingMethodError.value != null)
                                Text(controller.shippingMethodError.value!, 
                                  style: const TextStyle(
                                    color: Color(0xFFE90F0F),
                                    fontSize: 13
                                  )),

                              if (checkout.packingKayuChecked?.isNotEmpty == true)
                                InkWell(
                                  onTap: () {
                                    controller.isPackingKayuChecked.value = !controller.isPackingKayuChecked.value;
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                    child: Row(
                                      children: [
                                        Checkbox(value: controller.isPackingKayuChecked.value, onChanged: (value) {
                                          controller.isPackingKayuChecked.value = value == true;
                                        }),
                                        const Text("Packing Kayu")
                                      ],
                                    ),
                                  ),
                                ),
                              /* ------------------------------ product list ------------------------------ */
                            
                            ],
                          ),
                        ),      


                        /* --------------------------------- message -------------------------------- */
                        

                        /* --------------------------------- voucher -------------------------------- */
                        // GestureDetector(
                        //   onTap: () => voucher(context),
                        //   child: Container(
                        //     padding: const EdgeInsets.all(15),
                        //     color: Colors.white,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Row(
                        //           children: [
                        //             SizedBox(
                        //               height: 30,
                        //               child:
                        //                   Image.asset('assets/icon/voucher-color.png'),
                        //             ),
                        //             const SizedBox(width: 10),
                        //             const Text(
                        //               'Gunakan voucher',
                        //               style: TextStyle(fontWeight: FontWeight.bold),
                        //             ),
                        //           ],
                        //         ),
                        //         const Icon(
                        //           Icons.chevron_right,
                        //           color: AppColor.grayBorder,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(height: 10),

                        /* --------------------------------- payment -------------------------------- */
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const SizedBox(height: 6),
                              // const Text("Metode Pembayaran", style: TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              GestureDetector(
                                onTap: () {
                                  showPaymentMethodOptionBottomSheet(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: controller.paymentMethodError.value != null ? const Color(0xFFFFE1E1) : AppColor.primaryColor,
                                    border: controller.paymentMethodError.value != null ? Border.all(width: 0.5, color: const Color(0xFFE90F0F)) : null,
                                    borderRadius: controller.paymentMethodError.value != null ? BorderRadius.circular(4) : null
                                  ),
                                  child: Row(
                                    children: [
                                      if (controller.paymentMethodError.value != null)
                                        Row(
                                          children: [
                                            Image.asset("assets/icon/exclamation.png", width: 19),
                                            const SizedBox(width: 8)
                                          ],
                                        ),
                                      Expanded(
                                        child: Text(
                                          controller.selectedPaymentMethod.value?.judul ?? "Pilih Metode Pembayaran", 
                                          style: TextStyle(
                                            color: controller.paymentMethodError.value != null ? AppColor.primaryColor : Colors.white, 
                                            fontSize: 13))
                                      ),
                                      const SizedBox(width: 10),
                                      Icon(
                                        Icons.arrow_right,
                                        color: controller.shippingMethodError.value != null ? AppColor.primaryColor :  const Color(0xFFFBAA1A),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            
                              if (controller.paymentMethodError.value != null)
                                Text(controller.paymentMethodError.value!, 
                                  style: const TextStyle(
                                    color: Color(0xFFE90F0F),
                                    fontSize: 13
                                  )),
                            ],
                          ),
                        ),
                        

                        /* --------------------------------- summary -------------------------------- */
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 6),
                              const Text("Rincian Pembayaran", style: TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Sub-Total'),
                                        Text(checkout.totalPrice ?? ""),
                                      ],
                                    ),
                                    const SizedBox(height: 10),

                                    if (checkout.couponPrice != null)
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(checkout.couponPrice?.title ?? ""),
                                              Text('Rp ${thousandFormat.format(checkout.couponPrice?.value ?? 0)}'),
                                            ],
                                          ),
                                          const SizedBox(height: 10)
                                        ],
                                      ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Garansi UFO PRO'),
                                        Text('Rp ${thousandFormat.format(controller.garansiPrice.value)}'),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Pengiriman (${checkout.totalWeight} KG)'),
                                        if (controller.clickAndCollectShippingMethodSelected.value == true)
                                          Text('Rp ${thousandFormat.format(controller.selectedShippingMethod.value?.cost ?? 0)}'),
                                        if (controller.clickAndCollectShippingMethodSelected.value != true)
                                          Text('Rp ${thousandFormat.format(controller.selectedShippingMethod.value?.cost ?? 0)}'),
                                      ],
                                    ),
                                    if (checkout.packingKayuChecked?.isNotEmpty == true && controller.isPackingKayuChecked.value)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Packing Kayu'),
                                              Text('Rp ${checkout.packingKayuPrice}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Biaya Penanganan'),
                                        Text('Rp ${thousandFormat.format(checkout.biayaLayanan)}'),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Text(
                                          'Rp ${thousandFormat.format((controller.finalPrice.value))}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Dapatkan'),
                                        Row(
                                          children: [
                                            Image.asset("assets/icon/account/ufo-point.webp", width: 20),
                                            const SizedBox(width: 4),
                                            Text('UFO Poin : ${thousandFormat.format(checkout.totalAllUfoP)}')
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    const Divider(),
                                    const SizedBox(height: 10),
                                    
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 19,
                  ),
                  color: const Color(0xFFCAE3F9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (checkout.useCoupon.isEmpty)
                        const Text("Belum ada voucher yang terpakai", style: TextStyle(fontSize: 13))
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Promo Terpakai", style: TextStyle(fontSize: 13, color: Color(0xFF333333))),
                            Text("${checkout.useCoupon.firstOrNull?.code}", 
                              style: const TextStyle(fontSize: 20, color: Color(0xFF0060AF), fontWeight: FontWeight.bold))
                          ],
                        ),
                      SizedBox(
                        height: 30,
                        child: FilledButton(
                          onPressed: () {
                            final paymentMethod = controller.selectedPaymentMethod.value?.code;
                            
                            VoucherBinding().dependencies();
                            showModalBottomSheet(
                              context: context, 
                              isScrollControlled: true,
                              builder: (context) {
                              return ModalBottomSheetDefault(
                                title: "Voucher",
                                child: (scrollController) {
                                  return VoucherScreen(
                                    source: VoucherClaimSource.checkout, 
                                    prevSelectedVoucher: checkout.useCoupon.firstOrNull,
                                    scrollController: scrollController,
                                    paymentMethod: paymentMethod,
                                  );
                                },
                              );
                            })
                            .then((result) async {
                              await controller.load(shouldShowLoading: false);
                            });
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                              side: const BorderSide(color: AppColor.primaryColor)
                            ),
                          ),
                          child: Text(
                            checkout.useCoupon.isEmpty ? "Pakai Voucher" : "Ganti Voucher",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                              fontSize: 12
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 19,
                  ),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Total Pesanan", style: TextStyle(fontSize: 10)),
                            Text("Rp ${thousandFormat.format(controller.finalPrice.value)}", style: const TextStyle(
                              color: Color(0xFFFBAA1A),
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              if (controller.isProcessingCheckout.value)
                                const Center(child: CircularProgressIndicator())
                              else
                                FilledButton(
                                  onPressed: () => controller.processCheckout(),
                                  style: FilledButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 25),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)
                                    )
                                  ),
                                  child: const Text(
                                    "Lanjut Bayar",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                    ),
                                  ),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
