import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/checkout_success_screen.dart';

class CheckoutProcessingScreen extends StatefulWidget {
  static const routeName = "/checkout-processing";
  const CheckoutProcessingScreen({super.key});

  @override
  State<CheckoutProcessingScreen> createState() =>
      _CheckoutProcessingScreenState();
}

class _CheckoutProcessingScreenState extends State<CheckoutProcessingScreen> {
  /* ---------------------------- Dummy processing data ---------------------------- */
  Future<void> _fetchData() async {
    // Simulate a refresh operation (e.g., fetching updated data)
    await Future.delayed(
      const Duration(milliseconds: 2000),
      () {
        Get.toNamed(CheckoutSuccessScreen.routeName);
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 400,
              alignment: Alignment.bottomCenter,
              child: Lottie.asset(
                'assets/lottie/payment_processing.json',
                width: 250,
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                color: AppColor.primaryColor,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sedang Memproses',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(
                        'Tunggu sebentar pembayaran kamu sedang di proses',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Total Rp3.500.000',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
