import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/providers/cart_provider.dart';
import 'package:ufo_elektronika/screens/main/main_controller.dart';
import 'package:ufo_elektronika/screens/transaction_detail/transaction_detail_screen.dart';
import 'package:ufo_elektronika/widgets/appbar/action_bar_widget.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar_search_input.dart';
import 'package:ufo_elektronika/widgets/common/flash_sale_timer.dart';
import 'package:ufo_elektronika/screens/home/widgets/bestseller/bestseller_list.dart';
import 'package:ufo_elektronika/widgets/layouts/default_layout.dart';

class CheckoutSuccessScreen extends StatelessWidget {
  static const routeName = "/checkout-success";
  const CheckoutSuccessScreen({super.key});

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  @override
  Widget build(BuildContext context) {
    CartProvider readCart = context.read<CartProvider>();

    // thousand format for price
    var thousandFormat = NumberFormat('#,###');

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: const UEAppBar(
          showCart: false,
          title: null,
        ),
        body: DefaultLayout(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Batas akhir pembayaran',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: AppColor.grayText,
                                ),
                          ),
                          Text(
                            'Selasa, 07 Nov 2023 13:17 WIB',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const FlashSaleTimer(
                        hours: 24,
                        minutes: 0,
                        seconds: 0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),

                      // selected bank
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'BCA Virtual Account',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(
                            height: 30,
                            child:
                                Image.asset('assets/icon/bank/logo-bca.webp'),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 30,
                        color: AppColor.grayBorderBottom,
                      ),

                      // virtual account number
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nomor Virtual Account',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: AppColor.grayText,
                                    ),
                              ),
                              Text(
                                '97777997712334',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          TextButton(
                            style: const ButtonStyle(
                              padding:
                                  WidgetStatePropertyAll(EdgeInsets.zero),
                            ),
                            onPressed: () {
                              copyToClipboard('97777997712334');

                              // Hide the current snackbar before showing a new one
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Nomor Virtual Account tersalin'),
                                ),
                              );
                            },
                            child: const Row(
                              children: [
                                Text(
                                  'Salin',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(Icons.copy),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Pembayaran',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: AppColor.grayText,
                                    ),
                              ),
                              Text(
                                'Rp${thousandFormat.format(readCart.totalCheckout)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          TextButton(
                            style: const ButtonStyle(
                              padding:
                                  WidgetStatePropertyAll(EdgeInsets.zero),
                            ),
                            onPressed: () {
                              Get.toNamed(TransactionDetailScreen.routeName, parameters: {"id": "10"});
                            },
                            child: const Text(
                              'Lihat Detail',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Divider(
                        height: 30,
                        color: AppColor.grayBorderBottom,
                      ),

                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Lihat Cara Pembayaran',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primaryColor,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(15),
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            Get.find<MainController>().tabController.index = 0;
                            Get.offAllNamed("/main");
                          },
                          child: const Text(
                            'Belanja Lagi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: const ButtonStyle(
                            foregroundColor:
                                WidgetStatePropertyAll(AppColor.primaryColor),
                            side: WidgetStatePropertyAll(
                              BorderSide(
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Get.find<MainController>().tabController.index = 2;
                            Get.offAllNamed("/main");
                          },
                          child: const Text(
                            'Check Status Pembayaran',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const BestSellerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
