import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as Get;
import 'package:get/get_navigation/get_navigation.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/layouts/default_layout.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = "/change-password";
  final String email;
  const ChangePasswordScreen({super.key, required this.email});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> showPassword = {
    'newPassword': false,
    'newPasswordConfirm': false,
  };
  String password = "";
  String confirmationPassword = "";
  bool loading = false;

  InputDecoration inputDecoration = const InputDecoration(
    hintText: 'Hint',
    label: Text('Label'),
    alignLabelWithHint: true,
    labelStyle: TextStyle(
      color: Color(0xFF6E6E6E),
    ),
    hintStyle: TextStyle(
      fontWeight: FontWeight.normal,
      height: 0,
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFD6D6D6),
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColor.primaryColor,
        width: 1,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UEAppBar(
        title: 'Ubah Password',
        showCart: false,
        showNotification: false,
      ),
      body: DefaultLayout(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(15),
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      autofillHints: const [AutofillHints.newPassword],
                      decoration: inputDecoration.copyWith(
                        hintText: 'Password Baru',
                        label: const Text('Password Baru'),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              showPassword['newPassword'] =
                                  !showPassword['newPassword'];
                            });
                          },
                          child: Icon(!showPassword['newPassword']
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      obscureText: !showPassword['newPassword'] ? true : false,
                      enableSuggestions: false,
                      autocorrect: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Wajib diisi';
                        }
                        if (value != confirmationPassword) {
                          return "Password tidak sama";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          confirmationPassword = value;
                        });
                      },
                      decoration: inputDecoration.copyWith(
                        hintText: 'Konfirmasi Password Baru',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              showPassword['newPasswordConfirm'] =
                                  !showPassword['newPasswordConfirm'];
                            });
                          },
                          child: Icon(!showPassword['newPasswordConfirm']
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        label: const Text('Konfirmasi Password Baru'),
                      ),
                      obscureText:
                          !showPassword['newPasswordConfirm'] ? true : false,
                      enableSuggestions: false,
                      autocorrect: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Wajib diisi';
                        }
                        if (value != password) {
                          return "Password tidak sama";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: loading ? const Padding(padding: EdgeInsets.symmetric(vertical: 4), child: Center(child: CircularProgressIndicator())) : FilledButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final dio = Get.Get.find<Dio>();
                            setState(() {
                              loading = true;
                            });
                            final dioResp = await dio.post("account/password/update", data: FormData.fromMap({
                              "email": widget.email,
                              "password": password,
                              "confirm": confirmationPassword
                            }));
                            setState(() {
                              loading = false;
                            });
                            if (dioResp.data["success"] != null) {
                              Get.Get.back(closeOverlays: false);
                            }
                            Future.delayed(const Duration(milliseconds: 300), () {
                              final message = dioResp.data["success"] ?? dioResp.data["error"] ?? "Terjadi kesalahan. Silakan coba lagi";
                              Get.Get.showSnackbar(GetSnackBar(
                                message: message,
                                duration: const Duration(seconds: 2),
                              ));
                            });
                          }
                        },
                        child: const Text('Konfirmasi'),
                      )
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Nanti Saja'),
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
