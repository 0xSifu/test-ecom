import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufo_elektronika/screens/register/register_controller.dart';
import 'package:ufo_elektronika/shared/services/firebase_main_service.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';

class RegisterScreen extends GetView<RegisterController> {
  static const routeName = "/register";
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UEAppBar(
        title: "",
        showCart: false,
        showNotification: false,
      ),
      body: Obx(() => ListView(
        shrinkWrap: true,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("DAFTAR KE UFO ELEKTRONIKA", style: TextStyle(
                  color: AppColor.primaryColor,
                  fontFamily: "FuturaLT",
                  fontWeight: FontWeight.bold,
                  fontSize: 17
                )),
                const SizedBox(height: 15),
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Nama",
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(12),
                  ),
                  keyboardType: TextInputType.name,
                  onChanged: (value) => controller.name.value = value,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Nomor Telepon",
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(12),
                  ),
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => controller.phone.value = value
                ),
                const SizedBox(height: 8),
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
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: const OutlineInputBorder(),
                    isDense: true,
                    contentPadding: const EdgeInsets.all(12),
                    suffixIcon: IconButton(
                      icon: FaIcon(controller.passwordIsVisible.value == true ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash),
                      onPressed: () => controller.passwordIsVisible.value = !controller.passwordIsVisible.value,
                      padding: EdgeInsets.zero,
                    )
                  ),
                  obscureText: controller.passwordIsVisible.value != true,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) => controller.password.value = value,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Konfirmasi Password",
                    border: const OutlineInputBorder(),
                    isDense: true,
                    contentPadding: const EdgeInsets.all(12),
                    suffixIcon: IconButton(
                      icon: FaIcon(controller.passwordIsVisible.value == true ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash),
                      onPressed: () => controller.passwordIsVisible.value = !controller.passwordIsVisible.value,
                      padding: EdgeInsets.zero,
                    )
                  ),
                  obscureText: controller.passwordIsVisible.value != true,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) => controller.passwordConfirmation.value = value,
                ),
                const SizedBox(height: 8),

                InkWell(
                  onTap: () => controller.agreeToTnC.value = !controller.agreeToTnC.value,
                  child:  Row(
                    children: [
                      Checkbox(value: controller.agreeToTnC.value, onChanged: (value) {
                        if (value != null) {
                          controller.agreeToTnC.value = value;
                        }
                      }),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Dengan mendaftar, Anda setuju dengan"),
                          TextButton(
                            onPressed: () {
                              Get.toNamed('https://www.ufoelektronika.com/syarat-dan-ketentuan');
                            }, 
                            style: TextButton.styleFrom(padding: EdgeInsets.zero, alignment: Alignment.centerLeft, minimumSize: const Size(50, 10), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                            child: const Text("Syarat ketentuan yang berlaku di UFO Elektronika")
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                
                if (controller.isSigningIn.value)
                  const Center(child: CircularProgressIndicator()),

                if (!controller.isSigningIn.value)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.yellow,
                        textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                      ),
                      onPressed: controller.name.value.isNotEmpty 
                      && controller.phone.value.isNotEmpty 
                      && controller.email.value.isNotEmpty 
                      && controller.password.value.isNotEmpty 
                      && controller.passwordConfirmation.value.isNotEmpty
                      && controller.password.value == controller.passwordConfirmation.value
                      && controller.agreeToTnC.value ? controller.signInWithEmail : null, 
                      child: const Text("Daftar")
                    ),
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
                    const Text("Sudah Punya Akun?"),
                    TextButton(
                      onPressed: () {
                        Get.offNamed("/login")
                          ?.then((value) {
                            if (value == true) {
                              Get.back();
                            }
                          });
                      }, 
                      style: TextButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap, padding: const EdgeInsets.symmetric(horizontal: 4)),
                      child: const Text("Login Disini")
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}