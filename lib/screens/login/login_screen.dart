import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufo_elektronika/screens/forgot_password/forgot_password_screen.dart';
import 'package:ufo_elektronika/screens/login/login_controller.dart';
import 'package:ufo_elektronika/shared/services/firebase_main_service.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';

class LoginScreen extends GetView<LoginController> {
  static const routeName = "/login";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UEAppBar(
        title: "",
        showCart: false, 
        showNotification: false,
      ),
      body: ListView(
        shrinkWrap: true,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          loginComponent(controller)
        ],
      ),
    );
  }

  static Widget loginComponent(LoginController controller) => Obx(() => Padding(
    padding: const EdgeInsets.all(16),
    child: AutofillGroup(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("MASUK KE UFO ELEKTRONIKA", style: TextStyle(
            color: AppColor.primaryColor,
            fontFamily: "FuturaLT",
            fontWeight: FontWeight.bold,
            fontSize: 17
          )),
          const SizedBox(height: 15),
          TextField(
            decoration: const InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.all(12),
            ),
            autofillHints: const [AutofillHints.username],
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => controller.email.value = value,
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: "Password",
              border: const OutlineInputBorder(),
              isDense: true,
              contentPadding: const EdgeInsets.all(12),
              suffixIcon: IconButton(
                icon: FaIcon(controller.passwordVisible.value == true ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash),
                onPressed: () => controller.passwordVisible.value = !controller.passwordVisible.value,
                padding: EdgeInsets.zero,
              )
            ),
            autofillHints: const [AutofillHints.password],
            obscureText: controller.passwordVisible.value != true,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) => controller.password.value = value,
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              const Text("Lupa Password?"),
              TextButton(onPressed: () {
                Get.toNamed(ForgotPasswordScreen.routeName);
                }, child: const Text("Klik Disini"))
            ],
          ),
          const SizedBox(height: 8),

          if (controller.isSigningIn.value)
            const Center(child: CircularProgressIndicator()),
          
          if (!controller.isSigningIn.value)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.yellow,
                      textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                    ),
                    onPressed: controller.isSignInEnabled == true ? controller.signInWithEmail : null, 
                    child: const Text("Masuk")
                  ),
                ),
                if (controller.biometricsAvailable.firstWhereOrNull((biometric) => biometric == BiometricType.face) != null)
                  IconButton(onPressed: () { 
                    controller.signInWithBiometric();
                  }, icon: Image.asset("assets/icon/face_id.png", width: 34)),
                if (controller.biometricsAvailable.firstWhereOrNull((biometric) => biometric == BiometricType.fingerprint) != null)
                  IconButton(onPressed: () { 
                    controller.signInWithBiometric();
                  }, icon: Image.asset("assets/icon/touch_id.png", width: 34))
              ],
            ),
          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(child: Container(height: 1, color: Colors.grey)),
              const SizedBox(width: 15),
              const Text("ATAU", style: TextStyle(fontFamily: "FuturaLT")),
              const SizedBox(width: 15),
              Expanded(child: Container(height: 1, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (Get.find<FirebaseService>().signInWithGoogleEnabled)
                IconButton(
                  onPressed: controller.signInWithGoogle,
                  icon: SvgPicture.asset("assets/icon/google.svg", height: 26,),
                ),
              if (Get.find<FirebaseService>().signInWithFacebookEnabled)
                IconButton(
                  onPressed: controller.signInWithFacebook,
                  icon: SvgPicture.asset("assets/icon/facebook.svg", height: 26,),
                ),
              if (Get.find<FirebaseService>().signInWithAppleEnabled && Platform.isIOS)
                InkWell(
                  onTap: controller.signInWithApple,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: Colors.black12
                    ),
                    padding: const EdgeInsets.only(top: 3),
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.all(8),
                    child: const FaIcon(FontAwesomeIcons.apple),
                  ),
                )
                
            ],
          ),

          Row(
            children: [
              const Text("Belum Punya Akun?"),
              TextButton(onPressed: () {
                Get.offNamed("/register")
                  ?.then((value) {
                    if (value == true) {
                      Get.back();
                    }
                  });
                }, child: const Text("Daftar Sekarang"))
            ],
          ),
        ],
      ),
    ),
  ));
}