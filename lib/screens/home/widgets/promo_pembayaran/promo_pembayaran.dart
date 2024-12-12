import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/home/widgets/promo_pembayaran/promo_pembayaran_controller.dart';
import 'package:ufo_elektronika/screens/information/information_screen.dart';
import 'package:ufo_elektronika/shared/utils/get_view_keep_alive.dart';

class PromoPembayaran extends GetViewKeepAlive<PromoPembayaranController> {
  const PromoPembayaran({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      if (state == null) return const Center(child: CircularProgressIndicator());
      if (state.promoPembayaran.isEmpty) return Container();
      
      return Column(
        children: [
          const Text(
            "PROMO PEMBAYARAN",
            style: TextStyle(
              color: AppColor.primaryColor,
              fontFamily: "FuturaLT",
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 7),
          Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: controller.scrollController,
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 7),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: state.promoPembayaran.map((promo) {
                          return InkWell(
                            onTap: () {
                              if (promo.informationId != null) {
                                Get.toNamed(InformationScreen.routeName, parameters: {"id": promo.informationId!});
                              }
                            },
                            child: Row(
                              children: [
                                Image.network(promo.image ?? "", height: 103.58),
                                const SizedBox(width: 7)
                              ],
                            ),
                          );
                        }).toList() ,
                      ),
                    ),
                  )
                ],
              ),

              if (state.promoPembayaran.length > 3)
                Positioned(
                  left: 8,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(17)
                      ),
                      height: 34,
                      width: 34,
                      child: IconButton(
                        icon: const Icon(Icons.chevron_left),
                        iconSize: 17,
                        onPressed: () {
                          controller.scrollController.animateTo(controller.currentOffset.value - 120, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                        },
                      ),
                    ),
                  ),
                ),

              if (state.promoPembayaran.length > 3)
                Positioned(
                  right: 8,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(17)
                      ),
                      height: 34,
                      width: 34,
                      child: IconButton(
                        icon: const Icon(Icons.chevron_right),
                        iconSize: 17,
                        onPressed: () {
                          controller.scrollController.animateTo(controller.currentOffset.value + 120, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                        },
                      ),
                    ),
                  ),
                ),
            ],
          )
        ],
      );
    });
  }
}