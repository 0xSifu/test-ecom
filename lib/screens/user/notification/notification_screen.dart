import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/user/notification/notification_controller.dart';
import 'package:ufo_elektronika/screens/user/notification/notification_response.dart';
import 'package:ufo_elektronika/shared/utils/html_unescape/html_unescape.dart';
import 'package:ufo_elektronika/widgets/appbar/action_bar_widget.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/image.dart';
import 'package:ufo_elektronika/widgets/shimmer/notification_shimmer.dart';

class NotificationScreen extends GetView<NotificationController> {
  static const routeName = "/notification";
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const UEAppBar(
        showNotification: false,
        title: "Notifikasi",
      ),
      body: controller.obx((state) {
        if (state == null) return const NotificationShimmer();
        return Column(
          children: [
            /* --------------------------------- filter --------------------------------- */
            // Container(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 15,
            //     vertical: 5,
            //   ),
            //   color: Colors.white,
            //   child: Row(
            //     children: [
            //       OutlinedButton(
            //         style: controller.notifType.value == NotificationType.transaction
            //             ? AppButton.outlineGrayActive
            //             : AppButton.outlineGray,
            //         onPressed: () {
            //           controller.notifType.value = NotificationType.transaction;
            //         },
            //         child: const Text('Transaksi'),
            //       ),
            //       const SizedBox(width: 15),
            //       OutlinedButton(
            //         style: controller.notifType.value == NotificationType.promo
            //             ? AppButton.outlineGrayActive
            //             : AppButton.outlineGray,
            //         onPressed: () {
            //           controller.notifType.value = NotificationType.promo;
            //         },
            //         child: const Text('Promo'),
            //       ),
            //     ],
            //   ),
            // ),

            /* --------------------------- notification items --------------------------- */
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 10),
                  // if (controller.notifType.value == NotificationType.promo)
                  for (var notification in state.notifications)
                    InkWell(
                      onTap: () {
                        if (notification.applink != null) {
                          Get.toNamed(notification.applink!);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0x1FA6A6A6),
                            ),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            if (notification.type == NotificationType.promo)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  UEImage2(notification.image ?? "", width: 67, height: 63),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(notification.name ?? "", style: const TextStyle(
                                                fontFamily: "FuturaLT",
                                                color: AppColor.primaryColor,
                                                fontWeight: FontWeight.bold
                                              )),
                                            ),
                                            const SizedBox(width: 15),
                                            Text(DateFormat("d MMM yyyy HH:mm").format(notification.dateAdded ?? DateTime.now()), style: const TextStyle(fontSize: 10, color: Color(0xFF636363)),)
                                          ],
                                        ),
                                        const SizedBox(height: 1),
                                        if ((notification.description ?? "").length > 230)
                                          Html(data: "${(notification.description ?? "").substring(0, 230)}...", style: {"body": Style(margin: Margins.all(0), fontSize: FontSize(11), color: const Color(0xFF333333))},)
                                        else
                                          Html(data: notification.description ?? "", style: {"body": Style(margin: Margins.all(0), fontSize: FontSize(11), color: const Color(0xFF333333))},)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            if (notification.type == NotificationType.transaction)
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(notification.type == NotificationType.promo ? "assets/icon/notification-promo.png" : "assets/icon/notification-transaction.png", width: 20),
                                          const SizedBox(width: 10),
                                          Text(notification.type == NotificationType.promo ? 'Promo' : 'Transaksi'),
                                        ],
                                      ),
                                      Text(DateFormat("d MMM yyyy HH:mm").format(notification.dateAdded ?? DateTime.now()), style: const TextStyle(fontSize: 10, color: Color(0xFF636363))),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(notification.name ?? "",
                                    style: const TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.bold, fontSize: 13),
                                  ),
                                  const SizedBox(height: 1),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Html(data: notification.description ?? "", style: {"body": Style(margin: Margins.all(0), fontSize: FontSize(11), color: const Color(0xFF333333))},),
                                      ),
                                    ],
                                  ),
                                  if (notification.image != null)
                                    Column(
                                      children: [
                                        const SizedBox(height: 8),
                                        UEImage2(notification.image ?? "")
                                      ],
                                    )
                                ],
                              )
                          ],
                        ),
                      )
                    ),


                  // if (controller.notifType.value == NotificationType.transaction)
                  // for (var pesanan in state.pesanan)

                  //   Container(
                  //     padding: const EdgeInsets.all(15),
                  //     decoration: BoxDecoration(
                  //       border: const Border(
                  //         bottom: BorderSide(
                  //           color: Color(0x1FA6A6A6),
                  //         ),
                  //       ),
                  //       color: Colors.blue.shade50,
                  //     ),
                  //     child: Column(
                  //       mainAxisSize: MainAxisSize.min,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Row(
                  //           mainAxisAlignment:
                  //               MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Row(
                  //               children: [
                  //                 Image.asset("assets/icon/notification-transaction.png", width: 20),
                  //                 const SizedBox(width: 10),
                  //                 const Text('Transaksi'),
                  //               ],
                  //             ),
                  //             Text(DateFormat("d MMM yyyy HH: mm").format(pesanan.date ?? DateTime.now()), style: const TextStyle(fontSize: 12)),
                  //           ],
                  //         ),
                  //         const SizedBox(height: 10),
                  //         Text(pesanan.statusName ?? "",
                  //           style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColor.primaryColor, fontWeight: FontWeight.bold),
                  //         ),
                  //         const SizedBox(height: 10),
                  //         Text(pesanan.statusDesc ?? ""),
                  //       ],
                  //     ),
                  //   ),
                    
                  if (state.notifications.isEmpty)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/icon/ufomen_sad.webp", width: 150), 
                          const SizedBox(height: 15),
                          const Text("Tidak ada pesan")
                        ],
                      ),
                    ),

                  // // load more button
                  // Container(
                  //   margin: const EdgeInsets.symmetric(vertical: 15),
                  //   padding: const EdgeInsets.symmetric(horizontal: 15),
                  //   child: FilledButton(
                  //     style: const ButtonStyle(
                  //       textStyle: MaterialStatePropertyAll(
                  //         TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 16,
                  //         ),
                  //       ),
                  //     ),
                  //     onPressed: () {},
                  //     child: const Text('Lihat Lebih Banyak'),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        );
      },
      onLoading: const NotificationShimmer()),
    );
  }
}
