import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:midtrans_sdk/src/models/transaction_result.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/cart/cart_controller.dart';
import 'package:ufo_elektronika/screens/my_reviews/rating_bottomsheet/rating_binding.dart';
import 'package:ufo_elektronika/screens/my_reviews/rating_bottomsheet/rating_bottomsheet.dart';
import 'package:ufo_elektronika/screens/refund/refund_screen.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_controller.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_statuses_response.dart';
import 'package:ufo_elektronika/screens/transaction/transactions_response.dart';
import 'package:ufo_elektronika/screens/transaction_detail/transaction_detail_screen.dart';
import 'package:ufo_elektronika/shared/providers/midtrans_provider.dart';
import 'package:ufo_elektronika/widgets/appbar/action_bar_widget.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar_search_input.dart';
import 'package:ufo_elektronika/widgets/common/modal_bottom_sheet_default.dart';
import 'package:ufo_elektronika/widgets/common/score_slider.dart';
import 'package:ufo_elektronika/widgets/image.dart';
import 'package:ufo_elektronika/widgets/layouts/default_layout.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TransactionScreen extends GetView<TransactionController> {
  static const routeName = "/transaction";
  final String? _tag;
  const TransactionScreen({super.key, String? tag}): _tag = tag;
  
  @override
  String? get tag => _tag ?? super.tag;

  static void showUploadPaymentProofBottomSheet({ 
    required BuildContext context,
    required String orderId,
    required String? dateAdded,
    required int? totalProducts,
    String? firstProductImage,
    String? firstProductName,
    required Future<void> Function(String orderId, String accountName, File image) uploadPaymentProof
  }) {
    File? selectedImage;
    String? accountName;
    bool uploading = false;
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
      ),
      builder: (context) => StatefulBuilder(builder: (context, setModalState) {
        Future pickImageFromGallery() async {
          final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

          if (returnedImage == null) return;
          setModalState(() {
            selectedImage = File(returnedImage.path);
          });
        }

        return ModalBottomSheetDefault(
          title: 'Bukti Transfer',
          initialChildSize: 0.7,
          child: (scrollController) => Container(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (firstProductImage != null)
                                UEImage2(firstProductImage, width: 64, height: 64),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'ORDER ID: $orderId',
                                          style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColor.primaryColor),
                                        ),
                                        if (dateAdded != null)
                                          Text(dateAdded,
                                            style: const TextStyle(fontSize: 9)
                                        ),
                                      ],
                                    ),
                                    if (firstProductName != null)
                                      Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(firstProductName, style: const TextStyle(color: AppColor.primaryColor, fontSize: 13))
                                          )
                                        ],
                                      ),
                                    if (totalProducts != null)
                                      Text("$totalProducts Barang")
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: GestureDetector(
                              onTap: () => pickImageFromGallery(),
                              child: Stack(
                                children: [
                                  DottedBorder(
                                    borderType: BorderType.RRect,
                                    dashPattern: const [15, 10],
                                    radius: const Radius.circular(12),
                                    padding: const EdgeInsets.all(6),
                                    color: AppColor.primaryColor,
                                    child: SizedBox(
                                      height: 200,
                                      width: double.infinity,
                                      child: selectedImage != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.file(
                                              selectedImage!,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.camera_alt_outlined,
                                                color: AppColor.primaryColor,
                                                size: 40,
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'Unggah Foto',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                  color: AppColor.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                    ),
                                  ),

                                  if (selectedImage != null)
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                        onPressed: () {
                                          setModalState(() {
                                            selectedImage = null;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel),
                                        color: AppColor.grayText,
                                        style: IconButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          backgroundColor: Colors.white,
                                          side: const BorderSide(color: Colors.white)
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Atas Nama Rekening',
                              labelText: 'Atas Nama Rekening',
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(Radius.circular(6)),
                                borderSide: BorderSide(color: Colors.grey.shade200)
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 15,
                              ),
                            ),
                            onChanged: (value) {
                              setModalState(() {
                                accountName = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Wajib diisi';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      children: [
                        if (uploading)
                          const SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: Center(child: CircularProgressIndicator()),
                          )
                        else
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: FilledButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate() && selectedImage != null && accountName != null) {
                                  setModalState(() { uploading = true; });
                                  await uploadPaymentProof(orderId, accountName ?? "", selectedImage!);
                                  setModalState(() { uploading = false; });
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text('Unggah Bukti Transfer'),
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool skip1Refresh = false;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const UEAppBar(title: null),
      body: VisibilityDetector(
        key: const Key("transaction"),
        onVisibilityChanged: (visibilityInfo) {
          if (skip1Refresh == false) {
            skip1Refresh = true;
            return;
          }
          if (visibilityInfo.visibleFraction >= 0.9) {
            controller.refreshTransactions();
          }
        },
        child: Obx(() {
            if (controller.isLoadingStatuses.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                const SizedBox(height: 4),
                SizedBox(
                  height: 28,
                  child: ScrollablePositionedList.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemScrollController: controller.transactionListItemScrollController,
                    itemPositionsListener: controller.transactionListItemPositionsController,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.transactionStatuses.length,
                    itemBuilder: (context, index) {
                      return Obx(() {
                        final status = controller.transactionStatuses[index];
                        final isSelected = status.orderStatusId == controller.selectedOrderStatus.value;
                        return InkWell(
                          onTap: () {
                            controller.tabController.value?.animateTo(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                            margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                            constraints: const BoxConstraints(minWidth: 86),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColor.yellow : Colors.white,
                              border: Border.all(color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Text(status.name ?? "", 
                              style: TextStyle(
                                color: isSelected ? AppColor.primaryColor : null,
                                fontWeight: isSelected ? FontWeight.bold : null,
                                fontFamily: "MYRIADPRO",
                                fontSize: 11
                              )
                            ),
                          ),
                        );
                      }, key: Key(controller.selectedOrderStatus.value.name));
                    },
                  )
                ),
                const SizedBox(height: 9),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCAE3F9),
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: Row(children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
                        alignment: Alignment.center,
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "Nama Produk / No Order",
                            hintStyle: TextStyle(fontSize: 11, color: Colors.grey),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Icon(Icons.search, color: AppColor.primaryColor),
                            ),
                            suffixIconConstraints: BoxConstraints(),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                            constraints: BoxConstraints(),
                            isDense: true
                          ),
                          onChanged: (keyword) {
                            controller.searchKeyword.value = keyword;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)
                        ),
                        height: 28,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Transform.translate(
                              offset: const Offset(0, -9),
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                isDense: true,
                                iconSize: 20,
                                iconEnabledColor: const Color(0xFFFBAA1A),
                                padding: EdgeInsets.zero,
                                itemHeight: kMinInteractiveDimension,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 15, right: 8),
                                ),
                                value: controller.selectedPeriod.value,
                                items: controller.periods.map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.isEmpty ? "Semua Periode" : e, style: const TextStyle(fontSize: 11)),
                                )).toList(), 
                                onChanged: (selectedOptionValue) {
                                  if (selectedOptionValue != null) {
                                    controller.selectedPeriod.value = selectedOptionValue;
                                  }
                              }),
                            ),
                            // if (controller.selectedPeriod.isEmpty)
                            //   const Positioned(
                            //     top: 0,
                            //     bottom: 0,
                            //     left: 10,
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Text("Periode", style: TextStyle(fontSize: 11, color: Colors.grey))
                            //       ],
                            //     ),
                            //   )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 4),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.primaryColor),
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/icon/account/online-store.webp", width: 30),
                          const SizedBox(width: 8),
                          const Text("TRANSAKSI CLICK & COLLECT", style: TextStyle(
                            fontFamily: "FuturaLT",
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor,
                            fontSize: 15
                          ),)
                        ],
                      ),
                      SizedBox(
                        height: 25,
                        child: Transform.scale(
                          scale: 0.7,
                          child: Switch(
                            value: controller.isClickAndCollectOn.value, 
                            activeColor: AppColor.primaryColor,
                            activeTrackColor: AppColor.primaryColor.withOpacity(0.2),
                            onChanged: (value) {
                              controller.isClickAndCollectOn.value = value;
                            }),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: DefaultLayout(
                    child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    // color: Colors.white,
                      child: TabBarView(
                        controller: controller.tabController.value,
                        children: [
                          for (TransactionStatusesResponse status in controller.transactionStatuses)
                            Builder(
                              builder: (context) {
                                final orders = controller.ordersPerStatus[status.orderStatusId];
                                if (orders == null) {
                                  return const Center(child: CircularProgressIndicator());
                                }
                                if (orders.isEmpty) {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/icon/ufomen_sad.webp", width: 150), 
                                        const SizedBox(height: 15),
                                        const Text("Kamu belum punya transaksi nih")
                                      ],
                                    ),
                                  );
                                }
                                return  SingleChildScrollView(
                                    child: SafeArea(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Column(
                                          children: orders.indexed.map((e) => VisibilityDetector(
                                            key: Key("order_${e.$2.orderId}_${e.$1}"), 
                                            onVisibilityChanged: (visibilityInfo) {
                                              if (e.$1 >= orders.length - 1 && visibilityInfo.visibleFraction >= 0.9) {
                                                controller.loadMore();
                                              }
                                            },
                                            child: transaction(
                                              order: e.$2, 
                                              context: context, 
                                              controller: controller, 
                                              onUploadPaymentProofClicked: showUploadPaymentProofBottomSheet,
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
                                                  controller.refreshTransactions();
                                                });
                                              },
                                            ))).toList()
                                        )
                                      ),
                                    )
                                  );
                              },
                            )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      )
    );
  }

  static Widget transaction(
    {
      bool isForReview = false,
      required Order order, 
      required BuildContext context, 
      required TransactionController controller,
      required Function({
        required BuildContext context, 
        required String orderId,
        required String dateAdded,
        required int totalProducts,
        String? firstProductImage,
        String? firstProductName,
        required Future<void> Function(String orderId, String accountName, File image) uploadPaymentProof
      }) onUploadPaymentProofClicked,
      Function(BuildContext context, Order order, TransactionController controller)? onGivingRateClicked
    }
  ) {
    return GestureDetector(
      onTap: () => Get.toNamed(TransactionDetailScreen.routeName, parameters: {"id": "${order.orderId}"}),
      child: Container(
        margin: const EdgeInsets.only(bottom: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE5EBF5),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ORDER ID: ${order.orderId}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor,
                          fontSize: 11
                        )
                      ),
                      Text(order.dateAdded ?? "", style: const TextStyle(fontSize: 11, color: Color(0xFF4B4B4B))),
                    ],
                  ),
                  if (isForReview == false)
                    Container(
                      height: 25,
                      decoration: BoxDecoration(
                        color: order.orderStatusId?.color,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.center,
                      child: Text(order.status ?? "",
                        style: TextStyle(
                          fontSize: 11,
                          color: order.orderStatusId?.textColor,
                        ),
                      ),
                    )
                  else
                    Container(
                      height: 25,
                      decoration: BoxDecoration(
                        color: order.reviewId == null ? const Color(0xFFE0E0E0) : const Color(0xFFFEEED1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(minWidth: 85),
                      alignment: Alignment.center,
                      child: Text(order.reviewId == null ? "Belum Dinilai" : "Sudah Dinilai",
                        style: TextStyle(
                          fontSize: 11,
                          color: order.reviewId == null ? const Color(0xFF636363) : const Color(0xFFFBAA1A),
                        ),
                      ),
                    )
                ],
              ),
            ),
            const SizedBox(height: 4),
            const Divider(
              color: Color(0xFFEFEFEF),
              height: 1,
            ),
            const SizedBox(height: 11),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 64,
                        height: 64,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: UEImage2(order.orderProducts.firstOrNull?.image ?? ""),
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text((order.orderProducts.firstOrNull?.name ?? "").toUpperCase(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: AppColor.primaryColor
                                        )
                                      ),
                                      Text(
                                        '${order.products} barang',
                                        style: const TextStyle(
                                          color: Color(0xFF4B4B4B),
                                          fontSize: 11
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset("assets/icon/ufo-protection.png", width: 29),
                              ],
                            ),
                            if (isForReview)
                              Column(
                                children: [
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      if (false) // TODO: If already rated
                                        const SizedBox(
                                          width: 170,
                                          child: ScoreSlider(
                                            maxScore: 5, 
                                            minScore: 1,
                                            score: 3,
                                            enabled: false,
                                          ),
                                        ),
                                      Expanded(child: Container()),
                                      if (order.orderStatusId != TransactionStatus.unknown)
                                        SizedBox(
                                          height: 30,
                                          child: FilledButton(
                                            onPressed: () {
                                              Get.find<CartController>().buyAgain(order.orderId ?? "");
                                            },
                                            style: FilledButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(6)
                                              ),
                                              backgroundColor: AppColor.yellow
                                            ),
                                            child: const Text(
                                              'Beli Lagi',
                                              style: TextStyle(
                                                fontSize: 9,
                                                color: AppColor.primaryColor,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                      const SizedBox(width: 8),
                                          
                                      if (order.orderStatusId == TransactionStatus.completed && order.reviewId == null)
                                        SizedBox(
                                          height: 30,
                                          child: FilledButton(
                                            onPressed: () {
                                              onGivingRateClicked?.call(context, order, controller);
                                            },
                                            child: const Text(
                                              'Beri Penilaian',
                                              style: TextStyle(
                                                fontSize: 9
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  )
                                ],
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                  if (isForReview == false)
                    Column(
                      children: [
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Total Pesanan', style: TextStyle(fontSize: 11, color: Color(0xFF4B4B4B))),
                                Text(order.total ?? "",
                                  style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Color(0xFFFBAA1A)
                                      ),
                                ),
                              ],
                            ),
                            
                            Row(
                              children: [
                                // if (order.orderStatusId == TransactionStatus.completed)
                                //   SizedBox(
                                //     height: 26,
                                //     width: 87,
                                //     child: FilledButton(
                                //       onPressed: () {
                                //         Get.toNamed(RefundScreen.routeName, parameters: {"order_id": order.orderId ?? ""});
                                //       },
                                //       style: FilledButton.styleFrom(
                                //         shape: RoundedRectangleBorder(
                                //           borderRadius: BorderRadius.circular(6)
                                //         ),
                                //         backgroundColor: const Color(0xFFFCD4D3),
                                //         padding: EdgeInsets.zero
                                //       ),
                                //       child: const Text(
                                //         'BATALKAN',
                                //         style: TextStyle(
                                //           fontFamily: "MYRIADPRO",
                                //           fontSize: 11,
                                //           color: Color(0xFFEF322F),
                                //           fontWeight: FontWeight.bold
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                if (order.orderStatusId == TransactionStatus.completed && order.reviewId == null)
                                    SizedBox(
                                      height: 26,
                                      child: FilledButton(
                                        onPressed: () {
                                          onGivingRateClicked?.call(context, order, controller);
                                        },
                                        child: const Text(
                                          'BERI PENILAIAN',
                                          style: TextStyle(
                                            fontSize: 11
                                          ),
                                        ),
                                      ),
                                    ),

                                const SizedBox(width: 8),

                                if (order.orderStatusId != TransactionStatus.unknown)
                                  SizedBox(
                                    height: 26,
                                    width: 87,
                                    child: FilledButton(
                                      onPressed: () {
                                        Get.find<CartController>().buyAgain(order.orderId ?? "");
                                      },
                                      style: FilledButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6)
                                        ),
                                        backgroundColor: AppColor.yellow,
                                        padding: EdgeInsets.zero
                                      ),
                                      child: const Text(
                                        'BELI LAGI',
                                        style: TextStyle(
                                          fontFamily: "MYRIADPRO",
                                          fontSize: 11,
                                          color: AppColor.primaryColor,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),

                  // upload photo
                  if (order.orderStatusId == TransactionStatus.waitingForPayment && isForReview == false)
                    
                    Container(
                      width: double.infinity,
                      height: 27,
                      margin: const EdgeInsets.only(top: 15),
                      child: FilledButton.icon(
                        onPressed: () {
                          if (order.midtransLink?.isNotEmpty == true) {
                            final midtrans = Get.find<MidtransProvider>().getMidtransSDK?.call();
                            if (midtrans != null) {
                              midtrans.setTransactionFinishedCallback((result) {
                                if (result.isTransactionCanceled) {

                                } else {
                                  switch (result.transactionStatus) {
                                    case null:
                                      // TODO: Handle this case.
                                    case TransactionResultStatus.capture:
                                      // TODO: Handle this case.
                                    case TransactionResultStatus.settlement:
                                      // TODO: Handle this case.
                                    case TransactionResultStatus.pending:
                                      // TODO: Handle this case.
                                    case TransactionResultStatus.deny:
                                      // TODO: Handle this case.
                                    case TransactionResultStatus.expire:
                                      // TODO: Handle this case.
                                    case TransactionResultStatus.cancel:
                                      // TODO: Handle this case.
                                  }
                                }
                              });
                              midtrans.startPaymentUiFlow(token: order.midtransToken);
                            } else {
                              Get.showSnackbar(const GetSnackBar(
                                message: "Terjadi kesalahan. Silakan coba lagi",
                                duration: Duration(seconds: 2),
                              ));
                            }
                          } else {
                            onUploadPaymentProofClicked(
                              context: context, 
                              orderId: order.orderId ?? "",
                              dateAdded: order.dateAdded ?? "",
                              totalProducts: order.products ?? 0,
                              firstProductImage: order.orderProducts.firstOrNull?.image,
                              firstProductName: order.orderProducts.firstOrNull?.name,
                              uploadPaymentProof: controller.uploadPaymentProof
                            );
                          }
                        },
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
                        ),
                        label: Text(
                          order.midtransLink?.isNotEmpty == true ? "LANJUTKAN PEMBAYARAN" : 'UNGGAH BUKTI TRANSFER',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            fontFamily: "MYRIADPRO"
                          ),
                        ),
                      ),
                    ),
                
                ],
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
