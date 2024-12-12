import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/checkout_payment_confirmation/manual/checkout_payment_manual_controller.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_screen.dart';
import 'package:ufo_elektronika/shared/utils/html_unescape/html_unescape.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/image.dart';

class CheckoutPaymentManualConfirmationScreen extends GetView<CheckoutPaymentManualController> {
  static String routeName = "/checkout-payment-manual-confirmation";
  const CheckoutPaymentManualConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Get.defaultDialog(
          radius: 4,
          title: "",
          titlePadding: EdgeInsets.zero,
          content: const Text("APAKAH ANDA INGIN KELUAR DARI HALAMAN INI?", 
            style: TextStyle(
              fontSize: 20, 
              color: AppColor.primaryColor, 
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          cancel: OutlinedButton(
            onPressed: () {
              Get.back();
            }, 
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              side: const BorderSide(color: AppColor.primaryColor)
            ),
            child: const Text("URUNGKAN", style: TextStyle(color: AppColor.primaryColor)),
          ),
          confirm: FilledButton(
            onPressed: () {
              controller.canPop.value = true;
              Get.back(result: true, closeOverlays: true);
            }, 
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            child: const Text("KEMBALI KE BERANDA"),
          )
        );
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: const UEAppBar(
          title: "KONIRMASI PEMBAYARAN",
          showCart: false, 
          showNotification: false
        ),
        body: controller.obx((state) {
          if (state == null) return const Center(child: CircularProgressIndicator());
          final data = state;
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        const Text("Transfer Bank", style: TextStyle(fontSize: 13, color: Color(0xFF4B4B4B))),
                        UEImage2(data.logoBank ?? "", width: 62),
                        const SizedBox(height: 8),
                        const Text("Batas Waktu Pembayaran", style: TextStyle(fontSize: 13, color: Color(0xFF4B4B4B))),
                        Text(DateFormat("dd MMMM yyyy - HH:mm:ss WIB").format(data.paymentBefore ?? DateTime.now()), 
                          style: const TextStyle(fontSize: 15, color: Color(0xFFFBAA1A))),

                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFA5C9FF),
                                Color(0xFF3F95E4),
                              ]
                            ),
                            borderRadius: BorderRadius.circular(14)
                          ),
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Text(data.norek ?? "", style: const TextStyle(fontSize: 32, color: Colors.white)),
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.white),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17)
                                  ),
                                  iconColor: Colors.white,
                                  maximumSize: const Size.fromHeight(40)
                                ),
                                onPressed: () async {
                                  await Clipboard.setData(ClipboardData(text: data.norek ?? ""));
                                  Get.showSnackbar(const GetSnackBar(
                                    message: "Berhasil meng-copy Bank Number",
                                    duration: Duration(seconds: 2),
                                  ));
                                }, 
                                icon: const FaIcon(FontAwesomeIcons.copy, color: Colors.white),
                                label: const Text("Copy Bank Number", style: TextStyle(color: Colors.white, fontSize: 13))
                              ),
                              const SizedBox(height: 8),
                              const Text("Nominal Yang Harus Di Transfer", style: TextStyle(fontSize: 13, color: Colors.white)),
                              Text(data.total ?? "", style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),

                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              TransactionScreen.showUploadPaymentProofBottomSheet(
                                context: context, 
                                orderId: data.orderId?.toString() ?? "",
                                dateAdded: null, 
                                totalProducts: null, 
                                uploadPaymentProof: controller.uploadPaymentProof
                              );
                            }, 
                            child: const Text("Unggah Bukti Transfer")
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(13),
                        child: Text("TATA CARA PEMBAYARAN", style: TextStyle(color: AppColor.primaryColor, fontFamily: "FuturaLT", fontWeight: FontWeight.bold),),
                      ),
                      const Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Transfer Bank", style: TextStyle(fontSize: 16, color: Color(0xFF4B4B4B))),
                            const SizedBox(width: 8),
                            UEImage2(data.logoBank ?? "", width: 56)
                          ],
                        ),
                      ),
                      const Divider(height: 1),

                      for (var instruction in controller.instructions)
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.toggleOpen(instruction);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(instruction.title, style: const TextStyle(fontSize: 13, color: AppColor.primaryColor, fontWeight: FontWeight.bold)),
                                    Icon(instruction.isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: const Color(0xFFFBAA1A))
                                  ],
                                ),
                              ),
                            ),
                            if (instruction.isOpen)
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                                color: const Color(0xFFEEF3F7),
                                child: Html(data: HtmlUnescape().convert(instruction.desc)),
                              )
                          ],
                        )
                    ],
                  ),
                ),
                const SafeArea(child: Padding(padding: EdgeInsets.all(8)))
              ],
            ),
          );
        })
      ),
    );
  }
}
