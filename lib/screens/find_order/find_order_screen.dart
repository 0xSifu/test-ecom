import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/transaction_detail/transaction_detail_screen.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';

class FindOrderScreen extends StatefulWidget {
  static const routeName = "/track_order";
  const FindOrderScreen({super.key});

  @override
  State<FindOrderScreen> createState() => _FindOrderScreeState();
}

class _FindOrderScreeState extends State<FindOrderScreen> {
  String orderId = "";
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UEAppBar(
        title: "Lacak Pesanan",
        showCart: false, 
        showNotification: false
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 62),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Cek Pesanan", style: TextStyle(fontSize: 16, color: Color(0xFF4B4B4B))),
              Row(
                children: [
                  Expanded(child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Order ID",
                      border: OutlineInputBorder(),
                      isDense: true
                    ),
                    onChanged: (value) {
                      orderId = value;
                    },
                  ))
                ],
              ),
              if (errorMessage.isNotEmpty)
                Text(errorMessage, style: const TextStyle(color: Colors.red, fontSize: 11)),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    if (orderId.isNotEmpty) {
                      setState(() {
                        errorMessage = "";
                      });
                      Get.toNamed(TransactionDetailScreen.routeName, parameters: {"id": orderId});
                    } else {
                      setState(() {
                        errorMessage = "Mohon isi Order ID terlebih dahulu";
                      });
                    }
                   },
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)
                    ),
                    backgroundColor: AppColor.yellow
                  ),
                  child: const Text(
                    'CARI PESANAN',
                    style: TextStyle(
                      fontFamily: "MYRIADPRO",
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}