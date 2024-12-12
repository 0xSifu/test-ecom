
import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/my_reviews/rating_bottomsheet/rating_binding.dart';
import 'package:ufo_elektronika/screens/my_reviews/rating_bottomsheet/rating_bottomsheet.dart';
import 'package:ufo_elektronika/screens/product/product_screen.dart';
import 'package:ufo_elektronika/screens/refund/refund_screen.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_screen.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_statuses_response.dart';
import 'package:ufo_elektronika/screens/transaction/transactions_response.dart';
import 'package:ufo_elektronika/screens/transaction_detail/transaction_detail_controller.dart';
import 'package:ufo_elektronika/shared/providers/midtrans_provider.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/common/modal_bottom_sheet_default.dart';
import 'package:ufo_elektronika/widgets/image.dart';
import 'package:ufo_elektronika/widgets/layouts/default_layout.dart';

class TransactionDetailScreen extends GetView<TransactionDetailController> {
  static const routeName = "/transaction-detail";
  const TransactionDetailScreen({super.key, required this.orderId});
  final String orderId;

  void showRatingBottomSheet(BuildContext context) {
    final detail = controller.state;
    if (detail == null) return;
    RatingBinding(
      products: detail.products
        .map((product) => OrderProduct(
          image: product.image, 
          name: product.name, 
          option: product.optionText, 
          href: product.href, 
          productId: product.productId))
        .toList(),
      orderId: detail.orderId ?? "", 
      dateAdded: detail.dateAdded ?? ""
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
          child: (scrollController) => RatingBottomsheet(scrollController: scrollController, orderId: detail.orderId ?? ""),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.load(orderId);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const UEAppBar(
        title: 'Detail Pesanan',
        showCart: false,
        showNotification: false,
      ),
      body: controller.obx((state) {
        final detail = state;
        if (detail == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return DefaultLayout(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text("Rincian pesanan".toUpperCase(), 
                          style: const TextStyle(
                            color: AppColor.primaryColor, fontWeight: FontWeight.bold,
                            fontFamily: "FuturaLT"
                        )),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("ORDER ID: ${detail.orderId}", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColor.primaryColor)),
                                Text(detail.dateAdded ?? "", style: const TextStyle(fontSize: 9))
                              ],
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Wrap(
                                alignment: WrapAlignment.end,
                                crossAxisAlignment: WrapCrossAlignment.end,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFCCDFEF),
                                      borderRadius: BorderRadius.circular(6)
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                    child: Text(
                                      detail.shippingMethod ?? "", 
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 9, color: AppColor.primaryColor)
                                    )
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const Divider(),

                      // first product
                      InkWell(
                        onTap: () {
                          final productId = detail.products.firstOrNull?.productId;
                          if (productId != null) {
                            Get.toNamed(ProductScreen.routeName, parameters: {"id": productId});
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: UEImage2(detail.products.firstOrNull?.image ?? ""),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(detail.products.firstOrNull?.name ?? "",
                                          style: const TextStyle(
                                            color: AppColor.primaryColor,
                                            fontSize: 13
                                          ),
                                        ),
                                        Text(
                                          detail.products.firstOrNull?.total ?? "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFFBAA1A),
                                            fontSize: 15
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset("assets/icon/ufo-protection.png", width: 29),
                                            const SizedBox(width: 6),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text("Produk ini terproteksi oleh", style: TextStyle(fontSize: 11)),
                                                Row(
                                                  children: [
                                                    const Text("Garansi UFO PRO", style: TextStyle(color: AppColor.primaryColor, fontSize: 11)),
                                                    Text(" ${detail.products.firstOrNull?.garansiName}", style: const TextStyle(fontSize: 11))
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // other product
                      if (controller.showAllProduct.value)
                        Column(
                          children: [
                            for (var product in detail.products.skip(1))
                              Column(
                                children: [
                                  const SizedBox(height: 15),
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        // item
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 70,
                                                  height: 70,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(6),
                                                    child: UEImage2(product.image ?? ""),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(product.name ?? "",
                                                        style: const TextStyle(
                                                          color: AppColor.primaryColor,
                                                          fontSize: 13
                                                        ),
                                                      ),
                                                      Text(
                                                        product.total ?? "",
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Color(0xFFFBAA1A),
                                                          fontSize: 15
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Image.asset("assets/icon/ufo-protection.png", width: 29),
                                                          const SizedBox(width: 6),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const Text("Produk ini terproteksi oleh", style: TextStyle(fontSize: 11)),
                                                              Row(
                                                                children: [
                                                                  const Text("Garansi UFO PRO", style: TextStyle(color: AppColor.primaryColor, fontSize: 11)),
                                                                  Text(" ${product.garansiName}", style: const TextStyle(fontSize: 11))
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                          ],
                        ),
                      
                      if (detail.products.length > 1)
                        // show all product button
                        Center(
                          child: TextButton(
                            style: const ButtonStyle(
                              animationDuration: Duration.zero,
                              splashFactory: NoSplash.splashFactory,
                            ),
                            onPressed: () => controller.showAllProduct.value = !controller.showAllProduct.value,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  controller.showAllProduct.value
                                      ? 'Tampilkan Semua Produk'
                                      : '+1 Barang Lainnya',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(controller.showAllProduct.value
                                    ? Icons.expand_less
                                    : Icons.expand_more),
                              ],
                            ),
                          ),
                        ),

                    ],
                  ),
                ),

                // info pengiriman
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Text(
                          'Info Pengiriman'.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor,
                            fontFamily: "FuturaLT"
                          ),
                        ),
                      ),
                      const Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 100,
                                  child: Text('Kurir', style: TextStyle(fontSize: 12)),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    detail.shippingMethod ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primaryColor,
                                      fontSize: 12
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 100,
                                  child: Text('Alamat', style: TextStyle(fontSize: 12)),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        detail.name ?? "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.primaryColor,
                                          fontSize: 12
                                        ),
                                      ),
                                      Text(detail.telephone ?? "", style: const TextStyle(fontSize: 11)),
                                      Text(detail.paymentAddress ?? "", style: const TextStyle(fontSize: 11)),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                      const Divider(),

                      // status
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var (index, history) in detail.orderHistory.indexed)

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 15),
                                        child: Container(
                                          width: 11,
                                          height: 11,
                                          decoration: BoxDecoration(
                                            color: index == 0 ? const Color(0xFFFED100) : const Color(0xFFE8E8E8),
                                            borderRadius: BorderRadius.circular(6)
                                          ),
                                        ),
                                      ),
                                      Text(history.dateAdded ?? "",
                                        style: const TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(history.text ?? "", style: const TextStyle(fontSize: 11))
                                    ],
                                  ),
                                  if (index < detail.orderHistory.length - 1)
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 0,
                                      vertical: 10,
                                    ),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: AppColor.grayBorder,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                if (detail.shippingMethod?.toLowerCase().contains("collect") == true && detail.noInvoice?.isNotEmpty == true)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Text("BARCODE CLICK & COLLECT", style: TextStyle(
                            fontFamily: "FuturaLT",
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor
                          ),),
                        ),
                        const Divider(height: 1,),
                        const SizedBox(height: 12),
                        Center(
                          child: SvgPicture.string(Barcode.code128().toSvg(detail.noInvoice ?? "")),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),

                // rincian pembayaran
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text(
                          'Rincian Pembayaran'.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "FuturaLT",
                            color: AppColor.primaryColor
                          ),
                        ),
                      ),
                      const Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Metode Pembayaran', style: TextStyle(fontSize: 12)),
                                Text(detail.paymentMethod ?? "", style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Barang', style: TextStyle(fontSize: 12)),
                                Text(detail.products.length.toString(), style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 10),

                            for (var total in detail.totals.where((e) => e.title?.toLowerCase() != "total"))
                              Column(
                                children: [
                                  if (total.title?.toLowerCase() == "total")
                                    const Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      
                                      Text(total.title ?? "", style: const TextStyle(
                                        fontSize: 12
                                      )),
                                      Text(total.text ?? "", style: const TextStyle(
                                        fontSize: 12,
                                      )),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                          ],
                        ),
                      ),
                      const Divider(height: 1),
                      const SizedBox(height: 10),
                      Builder(
                        builder: (context) {
                          final total = detail.totals.firstWhereOrNull((e) => e.title?.toLowerCase() == "total");
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                
                                Text(total?.title ?? "", style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primaryColor
                                )),
                                Text(total?.text ?? "", style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFBAA1A)
                                )),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
                if (detail.orderStatusId == TransactionStatus.shipping || detail.orderStatusId == TransactionStatus.paid)
                  if (controller.isLoadingPostItemReceived.value == true)
                  const Center(child: CircularProgressIndicator())
                  else
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                    child: FilledButton(
                      onPressed: () {
                        controller.postItemReceived(orderId);
                      },
                      child: const Text(
                        'BARANG DITERIMA',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                
                if (detail.orderStatusId == TransactionStatus.waitingForPayment)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                    child: FilledButton(
                      onPressed: () {
                        if (detail.midtransToken?.isNotEmpty == true) {
                          final midtrans = Get.find<MidtransProvider>().getMidtransSDK?.call();
                          if (midtrans != null) {
                            midtrans.setTransactionFinishedCallback((result) {

                            });
                            midtrans.startPaymentUiFlow(token: detail.midtransToken);
                          } else {
                            Get.showSnackbar(const GetSnackBar(
                              message: "Terjadi kesalahan. Silakan coba lagi",
                              duration: Duration(seconds: 2),
                            ));
                          }
                        } else {
                          TransactionScreen.showUploadPaymentProofBottomSheet(
                            context: context, 
                            orderId: orderId, 
                            dateAdded: detail.dateAdded ?? "", 
                            totalProducts: detail.products.length, 
                            firstProductImage: detail.products.firstOrNull?.image,
                            firstProductName: detail.products.firstOrNull?.name,
                            uploadPaymentProof: controller.uploadPaymentProof,
                          );
                        }
                      },
                      child: Text(
                        detail.midtransToken?.isNotEmpty == true ? "Lanjutkan Pembayaran" : 'UNGGAH BUKTI TRANSFER',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),

                if (detail.orderStatusId == TransactionStatus.completed && detail.reviewId == null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFFFED100)
                      ),
                      onPressed: () {
                        showRatingBottomSheet(context);
                      },
                      child: const Text(
                        'BERI PENILAIAN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: AppColor.primaryColor,
                          fontFamily: "MYRIADPRO"
                        ),
                      ),
                    ),
                  ),

                SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: AppColor.primaryColor)
                          ),
                          onPressed: () {
                            Get.toNamed("https://www.ufoelektronika.com/hubungi-customer-care");
                          },
                          child: const Text(
                            'HUBUNGI KAMI',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              fontFamily: "MYRIADPRO",
                              color: AppColor.primaryColor
                            ),
                          ),
                        ),
                      ),
                      if (detail.orderStatusId == TransactionStatus.completed)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                          child: FilledButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(0xFFFCD4D3)
                            ),
                            onPressed: () {
                              Get.toNamed(RefundScreen.routeName, parameters: {"order_id": orderId});
                            },
                            child: const Text(
                              'BATALKAN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                fontFamily: "MYRIADPRO",
                                color: Color(0xFFEF322F)
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
