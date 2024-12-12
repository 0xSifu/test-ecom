import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/cart/cart_response.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_controller.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/common/coupon_divider.dart';
import 'package:ufo_elektronika/widgets/layouts/default_layout.dart';

class VoucherScreen extends GetView<VoucherController> {
  static const routeName = "/voucher";
  final VoucherClaimSource source; // If is for cart/checkout then auto go back after applying
  final String? paymentMethod; // This is the need from checkout, every payment method change, need to check voucher applied
  final CouponUsed? prevSelectedVoucher;
  final ScrollController? scrollController;
  const VoucherScreen({super.key, this.source = VoucherClaimSource.user, this.paymentMethod, this.prevSelectedVoucher, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: source != VoucherClaimSource.user ? null : const UEAppBar(
        showCart: false,
        showNotification: false,
        title: 'Voucher',
      ),
      body: Obx(() => Column(
        children: [
          if (source == VoucherClaimSource.user)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) => controller.searchedVoucher.value = value,
                      decoration: const InputDecoration(
                        hintText: 'Masukkan Kode Voucher',
                        hintStyle: TextStyle(
                          color: Colors.black38,
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.all(10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                          borderSide: BorderSide(
                            color: Color(0xFFBCBCBC),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                          borderSide: BorderSide(
                            color: Color(0xFFBCBCBC),
                          ),
                        ),
                        fillColor: Color(0xFFF8F8F8),
                        filled: true,
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 40,
                    child: FilledButton(
                      onPressed: controller.search,
                      child: const Text('Cari'),
                    ),
                  ),
                ],
              ),
            ),
          
          if (controller.isLoading.value)
            const Center(
              child: CircularProgressIndicator(),
            ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white,
              child: Obx(() => ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.zero,
                itemCount: controller.vouchers.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {

                  return Obx(() {
                    // if promo selected
                    // change the logic with your

                    final coupon = controller.vouchers[index];
                    bool isSelected = controller.selectedVoucher.value != null &&
                            controller.selectedVoucher.value == coupon
                        ? true
                        : false;
                    return GestureDetector(
                      onTap: () {
                        controller.selectedVoucher.value = coupon;
                        if (source != VoucherClaimSource.user) {

                        } else {
                          controller.claim(source: source, paymentMethod: paymentMethod);
                        }
                      },
                      child: Column(
                        children: [
                          if (source != VoucherClaimSource.user)
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 4
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 22
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected ? AppColor.primaryColor : const Color(0xFFEEEEEE),
                                ),
                                borderRadius: BorderRadius.circular(6)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(coupon.name ?? "", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                          const SizedBox(width: 8),
                                          if (prevSelectedVoucher?.couponId == coupon.couponId)
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFCCDFEF),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              width: 85,
                                              height: 19,
                                              alignment: Alignment.center,
                                              child: const Text("Voucher Terpilih", textAlign: TextAlign.center, style: TextStyle(color: AppColor.primaryColor, fontSize: 10),),
                                            )
                                        ],
                                      ),
                                      Text('Minimal Belanja ${coupon.min}', style: const TextStyle(fontSize: 12, color: Color(0xFF636363)))
                                    ],
                                  ),
                                  if (prevSelectedVoucher?.couponId == coupon.couponId)
                                    IconButton.filled(
                                      style: IconButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6)
                                        ),
                                        backgroundColor: const Color(0xFFF54F4D)
                                      ),
                                      onPressed: () {
                                        controller.removeVoucher();
                                      },
                                      icon: const FaIcon(FontAwesomeIcons.trashCan, color: Colors.white, size: 13))
                                ],
                              ),
                            )
                          else
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: !isSelected
                                      ? AppColor.grayBorder
                                      : AppColor.primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    color: !isSelected
                                        ? Colors.white
                                        : AppColor.primaryColor.withOpacity(0.1),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(coupon.name ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Text(
                                          'Minimal Belanja ${coupon.min}',
                                          style: const TextStyle(
                                            color: AppColor.grayText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(10),
                                        color: !isSelected
                                            ? AppColor.grayBorderBottom
                                            : AppColor.primaryColor.withOpacity(0.3),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Terpakai ${coupon.percent}%',
                                              style: const TextStyle(
                                                color: AppColor.grayText,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'S/D ${coupon.end}',
                                              style: const TextStyle(
                                                color: AppColor.grayText,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        child: Container(
                                          color: Colors.white,
                                          child: CouponDivider(
                                            borderColor: !isSelected
                                                ? AppColor.grayBorder
                                                : AppColor.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                        ],
                      ),
                    );
                  });
                },
              )),
            ),
          ),
          if (source != VoucherClaimSource.user)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      controller.claim(source: source, paymentMethod: paymentMethod);
                    },
                    child: Text("Gunakan Voucher Ini".toUpperCase()),
                  ),
                ),
              ),
            )
        ],
      )),
    );
  }
}
