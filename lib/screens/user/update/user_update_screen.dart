import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/user/change_password_screen.dart';
import 'package:ufo_elektronika/screens/user/update/user_update_controller.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/image.dart';

class UserUpdateScreen extends GetView<UserUpdateController> {
  static const routeName = "/user-update";
  const UserUpdateScreen({super.key});

  Future pickImageFromGallery(BuildContext context) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    controller.profileImageFile.value = File(returnedImage.path);
  }

  Future<void> _selectDob(BuildContext context, DateTime initialDate) async {
    final DateTime now = DateTime.now();
    final DateTime firstDate =
        now.subtract(const Duration(days: 365 * 60)); // 60 years ago
    final DateTime lastDate =
        now.subtract(const Duration(days: 365 * 18)); // 18 years ago

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate, // 80 years ago
      lastDate: lastDate, // 18 years ago
    );
    if (picked != null) {
      controller.dob.value = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

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
    
    return Scaffold(
      appBar: const UEAppBar(
        showCart: false,
        showNotification: false,
        title: 'Ubah Profil',
      ),
      body: Obx(() => controller.profile.value == null ?
        const Center(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 15),
              Text(
                'Tunggu Sebentar',
                style: TextStyle(color: AppColor.grayText),
              ),
            ],
          )) :

        SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: controller.profileImageFile.value != null
                        ? Image.file(
                            controller.profileImageFile.value!,
                            fit: BoxFit.cover,
                          )
                        : (controller.profile.value?.image?.isNotEmpty == true ? UEImage2(controller.profile.value!.image!, fit: BoxFit.cover,) : Image.asset('assets/images/ufomen/ufomen-top.webp')),
                  ),
                ),
                const SizedBox(width: 15),
                TextButton(
                  onPressed: () => pickImageFromGallery(context),
                  child: const Text(
                    'Ubah Foto Profil',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  maxLength: 50,
                  initialValue: controller.name.value,
                  onChanged: (value) => controller.name.value = value,
                  decoration: inputDecoration.copyWith(
                    hintText: 'Nama',
                    label: const Text('Nama'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  maxLength: 100,
                  initialValue: controller.email.value,
                  onChanged: (value) => controller.email.value = value,
                  keyboardType: TextInputType.emailAddress,
                  readOnly: controller.emailIsReadOnly.value,
                  decoration: inputDecoration.copyWith(
                    hintText: 'Email',
                    label: const Text('Email'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  maxLength: 20,
                  initialValue: controller.phone.value,
                  onChanged: (value) => controller.phone.value = value,
                  keyboardType: TextInputType.phone,
                  decoration: inputDecoration.copyWith(
                    hintText: 'No Telepon',
                    label: const Text('No Telepon'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  maxLength: 16,
                  initialValue: controller.nik.value,
                  onChanged: (value) => controller.nik.value = value,
                  keyboardType: TextInputType.number,
                  decoration: inputDecoration.copyWith(
                    hintText: 'NIK KTP',
                    label: const Text('NIK KTP'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _selectDob(context, controller.dob.value),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFD6D6D6),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tanggal Lahir',
                          style: TextStyle(
                            color: Color(0xFF6B6B6B),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(DateFormat('d/M/y', 'in_ID').format(controller.dob.value),
                          style: const TextStyle(
                            fontSize: 17,
                            color: Color(0xFF6B6B6B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: RadioListTile(
                        contentPadding: const EdgeInsets.all(0),
                        value: 'M',
                        groupValue: controller.gender.value,
                        title: const Text('Laki-Laki'),
                        onChanged: (value) {
                          controller.gender.value = "M";
                        },
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: RadioListTile(
                        contentPadding: const EdgeInsets.all(0),
                        value: 'F',
                        groupValue: controller.gender.value,
                        title: const Text('Perempuan'),
                        onChanged: (value) {
                          controller.gender.value = "F";
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () => Get.toNamed(ChangePasswordScreen.routeName, parameters: {"email": controller.email.value}),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ubah Password',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                if (controller.biometricAvailable.value)
                  InkWell(
                        onTap: () => {
                          controller.biometricLoginIsEnabled.value = !controller.biometricLoginIsEnabled.value
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Login Biometrik',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Data Face ID hanya disimpan di dalam device kamu\ndan UFO Elektronika tidak menyimpan sama sekali.',
                                  style: TextStyle(fontSize: 11),
                                )
                              ],
                            ),
                            Switch(value: controller.biometricLoginIsEnabled.value, onChanged: (value) {
                              controller.biometricLoginIsEnabled.value = value == true;
                            }),
                          ],
                        ),
                      ),

                const SizedBox(height: 30),
                if (controller.isSubmitting.value)
                  const Center(child: CircularProgressIndicator()),
                
                if (!controller.isSubmitting.value)
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        controller.submit();
                      },
                      child: const Text('Simpan'),
                    ),
                  ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ))
    );
  }
}
