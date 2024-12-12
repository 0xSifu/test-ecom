import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/forgot_password/forgot_password_controller.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  static const routeName = "/forgot-password";
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UEAppBar(showCart: false, showNotification: false, title: "",),
      body: Obx(() => ListView(
        shrinkWrap: true,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text("LUPA PASSWORD", style: TextStyle(
                      color: AppColor.primaryColor,
                      fontFamily: "FuturaLT",
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                    ))
                  ],
                ),
                const SizedBox(height: 15),
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(12),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => controller.email.value = value,
                ),
                if (controller.errorMessage.isNotEmpty)
                  Text(controller.errorMessage.value, style: TextStyle(color: Colors.red, fontSize: 11)),
                const SizedBox(height: 8),

                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      }, 
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap
                      ),
                      child: const Text("Klik Disini"),
                    ),
                    const Text("untuk mencoba login kembali"),
                  ],
                ),
                const SizedBox(height: 8),

                if (controller.isSubmitting.value)
                  const Center(child: CircularProgressIndicator()),

                if (!controller.isSubmitting.value)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.yellow,
                        textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                      ),
                      onPressed: controller.submit, 
                      child: const Text("Kirim")
                    ),
                  ),
                const SizedBox(height: 15),
              ],
            ),
          )
        ],
      )),
    );
  }
}