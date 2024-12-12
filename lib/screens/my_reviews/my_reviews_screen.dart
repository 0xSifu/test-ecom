import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/my_reviews/my_reviews_controller.dart';
import 'package:ufo_elektronika/screens/my_reviews/rating_bottomsheet/rating_binding.dart';
import 'package:ufo_elektronika/screens/my_reviews/rating_bottomsheet/rating_bottomsheet.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_controller.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_screen.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_statuses_response.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/common/modal_bottom_sheet_default.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MyReviewsScreen extends GetView<MyReviewsController> {
  static const routeName = "/my-reviews";
  final String transactionControllerTag;
  const MyReviewsScreen({super.key, required this.transactionControllerTag});

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionController>(tag: transactionControllerTag);
    transactionController.selectedOrderStatus.value = TransactionStatus.completed;
    transactionController.onInit();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const UEAppBar(
        title: "PENILAIAN SAYA",
        showCart: false,
        showNotification: false,
      ),
      body: Obx(() {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFCAE3F9),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
                    alignment: Alignment.center,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Nama Produk atau Nomor Order",
                        hintStyle: TextStyle(fontSize: 11),
                        suffixIcon: Icon(Icons.search, color: AppColor.primaryColor),
                        suffixIconConstraints: BoxConstraints(),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 9),
                        constraints: BoxConstraints(),
                        isDense: true
                      ),
                      onChanged: (keyword) {
                        transactionController.searchKeyword.value = keyword;
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)
                    ),
                    height: 42,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        DropdownButtonFormField(
                          isExpanded: true,
                          padding: EdgeInsets.zero,
                          itemHeight: kMinInteractiveDimension,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          ),
                          value: transactionController.selectedPeriod.value,
                          items: transactionController.periods.map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e, style: const TextStyle(fontSize: 11),),
                          )).toList(), 
                          onChanged: (selectedOptionValue) {
                            if (selectedOptionValue != null) {
                              transactionController.selectedPeriod.value = selectedOptionValue;
                            }
                        }),
                        if (transactionController.selectedPeriod.isEmpty)
                          const Positioned(
                            top: 0,
                            bottom: 0,
                            left: 15,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Periode", style: TextStyle(fontSize: 11, color: Colors.grey))
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  final orders = transactionController.ordersPerStatus[TransactionStatus.completed];
                  if (orders == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return VisibilityDetector(
                        key: Key("order$index"), 
                        onVisibilityChanged: (visibilityInfo) {
                          if (index >= orders.length - 1 && visibilityInfo.visibleFraction >= 0.9) {
                            transactionController.loadMore();
                          }
                        },
                        child: TransactionScreen.transaction(
                          order: order, 
                          context: context, 
                          controller: transactionController, 
                          onUploadPaymentProofClicked: ({required context, required dateAdded, firstProductImage, firstProductName, required orderId, required totalProducts, required uploadPaymentProof}) {
                            
                          }, 
                          onGivingRateClicked: (context, order, controller) {
                            RatingBinding(
                              products: order.orderProducts,
                              orderId: order.orderId ?? "", 
                              dateAdded: order.dateAdded ?? ""
                            ).dependencies();

                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
                              ),
                              builder: (context) {
                                return ModalBottomSheetDefault(
                                  title: "BERI PENILAIAN",
                                  child: (scrollController) => RatingBottomsheet(
                                    scrollController: scrollController, 
                                    orderId: order.orderId ?? ""
                                  ),
                                );
                            }).then((result) {
                              transactionController.refreshTransactions();
                            });
                          },
                          isForReview: true
                        ));
                    },
                  );
                },
              ),
            )
          ],
        );
      }),
    );
  }
}