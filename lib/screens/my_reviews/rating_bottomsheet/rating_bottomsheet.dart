import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/my_reviews/rating_bottomsheet/rating_controller.dart';
import 'package:ufo_elektronika/widgets/common/score_slider.dart';
import 'package:ufo_elektronika/widgets/image.dart';

class RatingBottomsheet extends GetView<RatingController> {
  final ScrollController scrollController;
  final String orderId;
  const RatingBottomsheet({
    super.key,
    required this.scrollController,
    required this.orderId
  });

  @override
  String? get tag => orderId;
  
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    for (var product in controller.products)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (product.image?.isNotEmpty == true)
                                UEImage2(product.image!, width: 64, height: 64)
                              else
                                const SizedBox(width: 64, height: 64),
                              const SizedBox(width: 9),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ORDER ID: ${controller.orderId}", style: const TextStyle(fontSize: 9)),
                                    Text(product.name ?? "", style: const TextStyle(fontSize: 13, color: AppColor.primaryColor))
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(controller.dateAdded, style: const TextStyle(fontSize: 9))
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Text("Beri Nilai"),
                              SizedBox(
                                width: 220,
                                child: ScoreSlider(
                                  maxScore: 5,
                                  minScore: 1,
                                  score: controller.ratings[product],
                                  onScoreChanged: (value) {
                                    controller.ratings[product] = value;
                                  },
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: "Pesan Saya",
                              hintStyle: const TextStyle(fontSize: 11),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade100)),
                            ),
                            style: const TextStyle(fontSize: 11),
                            onChanged: (value) {
                              controller.notes[product] = value;
                            },
                          ),
                          const SizedBox(height: 10),
                          const Text("Tipe Media: JPEG, PNG, GIF, MP4, MOV, 3GP", style: TextStyle(fontSize: 12)),
                          const Text("*Maksimal 3 Media", style: TextStyle(fontSize: 12)),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 60,
                            child: Row(
                              children: [
                                for (var e in controller.medias[product]!.indexed)
                                  Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 10, top: 10),
                                            child: Row(
                                              children: [
                                                if (lookupMimeType(e.$2.path)?.startsWith("image") == true)
                                                  Image.file(File(e.$2.path), width: 60, height: 60)
                                                else
                                                  Container(
                                                    color: Colors.grey.shade300, 
                                                    width: 60, 
                                                    height: 60,
                                                    child: const Icon(Icons.play_arrow),
                                                  )
                                              ],
                                            ),
                                          ),
                                          if (controller.isRated[product] == false)
                                            Positioned(top: 0, right: 0, child: InkWell(
                                              onTap: () {
                                                controller.deleteMedia(product, e.$1);
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
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (controller.isRated[product] == false)
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () async { 
                                  final files = await ImagePicker().pickMultipleMedia(limit: 3);
                                  controller.medias[product] = files;
                                }, 
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white
                                ),
                                child: const Text("TAMBAHKAN FOTO ATAU VIDEO", style: TextStyle(color: AppColor.primaryColor))
                              ),
                            ),
                          if (controller.isRateLoading[product] == true)
                            const SizedBox(
                              width: double.infinity,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          else if (controller.isRated[product] == false)
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () async {
                                    controller.rate(product);
                                  }, 
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFED100)
                                  ),
                                  child: const Text("SELESAI", style: TextStyle(color: AppColor.primaryColor))
                                ),
                              )
                        ],
                      )
                  ],
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () { 
                    Navigator.pop(context);
                  }, 
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor
                  ),
                  child: const Text("KEMBALI", style: TextStyle(color: Colors.white))
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}