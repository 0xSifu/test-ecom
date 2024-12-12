import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/refund/get_refund_response.dart';
import 'package:ufo_elektronika/screens/refund/refund_controller.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/image.dart';

class RefundScreen extends GetView<RefundController> {
  static String routeName = "/refund";
  const RefundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const UEAppBar(
        title: "REFUND",
        showCart: false,
        showNotification: false,
      ),
      body: controller.obx((refundData) {
        if (refundData == null) return const Center(child: CircularProgressIndicator());
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ORDER ID: ${refundData.ordersAll?.orderId}", style: const TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryColor, fontSize: 9)),
                          Text(DateFormat("dd MMMM yyyy").format(refundData.ordersAll?.dateAdded ?? DateTime.now()), style: const TextStyle(fontSize: 9, color: Color(0xFF4B4B4B)),)
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var product in refundData.ordersAll?.product ?? <RefundProduct>[])
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              child: Row(
                                children: [
                                  if (product.image?.isNotEmpty == true)
                                    UEImage2(product.image ?? "", width: 70, height: 70)
                                  else
                                    const SizedBox(width: 70, height: 70),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(product.name ?? "", style: const TextStyle(color: AppColor.primaryColor, fontSize: 13)),
                                        Text(product.total ?? "", style: const TextStyle(color: Color(0xFFFBAA1A), fontSize: 15, fontWeight: FontWeight.bold)),
                                        Row(
                                          children: [
                                            Image.asset("assets/icon/ufo-protection.png", width: 30),
                                            const SizedBox(width: 8),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text("Produk ini terproteksi oleh", style: TextStyle(color: Color(0xFF636363), fontSize: 11)),
                                                Row(
                                                  children: [
                                                    const Text("Garansi UFO PRO", style: TextStyle(color: AppColor.primaryColor, fontSize: 11)),
                                                    Text(product.garansiName ?? "", style: const TextStyle(color: Color(0xFF636363), fontSize: 11)) 
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                      ],
                    )
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("ALASAN PENGEMBALIAN PRODUK", style: TextStyle(fontFamily: "FuturaLT", fontWeight: FontWeight.bold, color: AppColor.primaryColor)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var reason in refundData.returnReasons)
                            InkWell(
                              onTap: () {
                                controller.selectedReason.value = reason;
                              },
                              child: Row(
                                children: [
                                  Checkbox(value: controller.selectedReason.value == reason, onChanged: (value) {
                                    if (value == true) {
                                      controller.selectedReason.value = reason;
                                    }
                                  }),
                                  Text(reason.name ?? "", style: const TextStyle(color: Color(0xFF636363), fontSize: 13))
                                ],
                              ),
                            )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              if (controller.medias.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: SizedBox(
                    height: 124,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.medias.length,
                      itemBuilder: (context, index) {
                        final media = controller.medias[index];
                        return Row(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10, top: 10),
                                  child: Row(
                                    children: [
                                      if (lookupMimeType(media.path)?.startsWith("image") == true)
                                        Image.file(File(media.path), width: 114, height: 114)
                                      else
                                        Container(
                                          color: Colors.grey.shade300, 
                                          width: 114, 
                                          height: 114,
                                          child: const Icon(Icons.play_arrow),
                                        )
                                    ],
                                  ),
                                ),
                                
                                Positioned(top: 0, right: 0, child: InkWell(
                                  onTap: () {
                                    controller.medias.removeAt(index);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: const Icon(Icons.clear, size: 20),
                                  ),
                                ))
                              ],
                            ),
                            const SizedBox(width: 8)
                          ],
                        );
                      },
                    ),
                  ),
                ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)
                            ),
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: "Nama Bank",
                                hintStyle: TextStyle(color: Color(0xFF636363), fontSize: 11),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15)
                              ),
                              style: const TextStyle(fontSize: 11),
                              onChanged: (value) {
                                controller.bankName.value = value;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)
                            ),
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: "Nomor Rekening",
                                hintStyle: TextStyle(color: Color(0xFF636363), fontSize: 11),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15)
                              ),
                              style: const TextStyle(fontSize: 11),
                              onChanged: (value) {
                                controller.accountNo.value = value;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Nama Pemilik Rekening",
                          hintStyle: TextStyle(color: Color(0xFF636363), fontSize: 11),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15)
                        ),
                        style: const TextStyle(fontSize: 11),
                        onChanged: (value) {
                          controller.accountName.value = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Tulis Pesan Anda",
                          hintStyle: TextStyle(color: Color(0xFF636363), fontSize: 11),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15)
                        ),
                        maxLines: 5,
                        style: const TextStyle(fontSize: 11),
                        onChanged: (value) {
                          controller.notes.value = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
                        ),
                        onPressed: () async {
                          final files = await ImagePicker().pickMultipleMedia(limit: 6);
                          controller.medias.addAll(files);
                        },
                        child: const Text("TAMBAHKAN FOTO ATAU VIDEO", style: TextStyle(color: AppColor.primaryColor)),
                      ),
                    ),
                    const SizedBox(height: 2),
                    SafeArea(
                      top: false,
                      child: Column(
                        children: [
                          if (controller.isLoadingSubmit.value)
                            const Center(child: CircularProgressIndicator())
                          else
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () {
                                  controller.submit();
                                },
                                child: const Text("KIRIM"),
                              ),
                            )
                        ],
                      ),
                    )
                  ],
                ),
              ),


            ],
          ),
        );
      }),
    );
  }
}