import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/cart/cart_controller.dart';
import 'package:ufo_elektronika/screens/home/widgets/recommendation/recomendation_product.dart';
import 'package:ufo_elektronika/screens/main/main_controller.dart';
import 'package:ufo_elektronika/screens/main/main_screen.dart';
import 'package:ufo_elektronika/screens/product/product_screen.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_binding.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_controller.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_screen.dart';
import 'package:ufo_elektronika/screens/wishlist/wishlist_screen.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/common/modal_bottom_sheet_default.dart';
import 'package:ufo_elektronika/widgets/image.dart';
import 'package:ufo_elektronika/widgets/layouts/default_layout.dart';
import 'package:ufo_elektronika/widgets/shimmer/cart_shimmer.dart';
import 'package:ufo_elektronika/widgets/tiles/product_tile.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:sizer/sizer.dart' as sizer;

class CartScreen extends GetView<CartController> {
  static const routeName = "/cart";
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isFirstLoading = true;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: UEAppBar(
        title: 'Keranjang',
        showCart: false,
        showNotification: false,
        actions: [
          GestureDetector(
            onTap: () => Get.toNamed(WishlistScreen.routeName),
            child: const SizedBox(
              width: 30,
              height: 40,
              child: Icon(
                Icons.favorite_outline,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 15)
        ],
      ),
      body: VisibilityDetector(
        key: const Key("cart"), 
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction >= 1) {
            controller.load(shouldShowLoading: false);
            isFirstLoading = false;
          }
        },
        child: Builder(
          builder: (context) {
          return Obx(() {
            final isLoading = controller.isLoading.value;
            final cartGroups = controller.cartGroups;
            
            return isLoading
              ? const CartShimmer()
              : Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        const SliverToBoxAdapter(
                          child: SizedBox(height: 7),
                        ),
                        /* -------------------------------- cart list ------------------------------- */
                        if (cartGroups.isNotEmpty)
                          SliverStickyHeader(
                            header: Container(
                              color: Colors.white
                            ),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                childCount: cartGroups.length, (context, groupIndex) {
                                  final group = cartGroups[groupIndex];
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (groupIndex > 0)
                                        const SizedBox(height: 7),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Container(
                                          color: Colors.white,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 40,
                                                child: Checkbox(
                                                  value: group.items.firstWhereOrNull((e) => e.checkout == false) == null, 
                                                  onChanged: (checked) => controller.onGroupCheckedChange(checked: checked == true, cartGroup: group)
                                                ),
                                              ),
                                              Text(group.title)
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      ...group.items.mapIndexed((itemIndex, item) {
                                        final product = item.product;
                                        final index = cartGroups.take(groupIndex).map((e) => e.items.length).sum + itemIndex;
                                        controller.totalItemControllers[index].text = item.quantity.toString();
                                        if (item.quantity == 0) {
                                          return Container();
                                        }
                                        return Container(
                                          margin: const EdgeInsets.only(
                                            // bottom: groupIndex < cartGroups.length - 1 && itemIndex < group.items.length - 1 ? 10 : 0,
                                            left: 10, right: 10
                                          ),
                                          padding: const EdgeInsets.symmetric(vertical: 7),
                                          color: Colors.white,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Get.toNamed(ProductScreen.routeName, parameters: { "id": item.product.productId });
                                                  // controller.onItemCheckedChange(checked: !item.checkout, cartItem: item, cartGroup: group);
                                                },
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 30,
                                                      child: Checkbox(
                                                        value: item.checkout,
                                                        onChanged: (value) => controller.onItemCheckedChange(checked: value == true, cartItem: item, cartGroup: group),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        product.name,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(color: item.stock == false ? Colors.red : AppColor.primaryColor, fontSize: 16),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  const SizedBox(width: 15),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: const Color(0xFFEEEEEE)),
                                                      borderRadius: BorderRadius.circular(6)
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(6),
                                                      child: SizedBox(
                                                        width: 80,
                                                        height: 80,
                                                        child: UEImage2(product.thumb),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: 90,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              controller.onGaransiItemCheckedChange(checked: !(item.garansiChecked == true), cartItem: item, cartGroup: group);
                                                            },
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 30,
                                                                  height: 30,
                                                                  child: Checkbox(
                                                                    value: item.garansiChecked == true,
                                                                    onChanged: (checked) => controller.onGaransiItemCheckedChange(checked: checked == true, cartItem: item, cartGroup: group),//controller.warrantyChecked.value = checked == true
                                                                    
                                                                  ),
                                                                ),
                                                                // Image.asset("assets/icon/ufo-protection.png", height: 30, width: 30),
                                                                // const SizedBox(width: 5),
                                                                Text("Garansi UFO PRO ", style: TextStyle(color: item.stock == false ? Colors.red :  AppColor.primaryColor, fontSize: 12)),
                                                                Text(item.garansiName ?? "", style: TextStyle(fontSize: 12, color: item.stock == false ? Colors.red : null)),
                                                                Text(" + ", style: TextStyle(fontSize: 12, color: item.stock == false ? Colors.red : null)),
                                                                Text("Rp${NumberFormat('#,###').format(item.garansiPrice)}", style: TextStyle(fontSize: 12, color: item.stock == false ? Colors.red : null)),
                                                              ],
                                                            ),
                                                          ),
                                                          ...(item.option?.map((e) => Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                                            child: Text("${e.name} : ${e.value}", style: const TextStyle(color: Colors.grey, fontSize: 11),),
                                                          )) ?? []),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(product.price,
                                                                  style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: item.stock == false ? Colors.red : const Color(0xFFFBAA1A)
                                                                  )
                                                                ),
                                                                Text(item.reward ?? "", style: TextStyle(color: item.stock == false ? Colors.red : null))
                                                              ],
                                                            ),
                                                          ),
                                                          if (item.stock == false)
                                                            const Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 8),
                                                              child: Text("Stok Tidak Tersedia", style: TextStyle(color: Colors.red)),
                                                            )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              

                                              if (item.optionSelect != null && item.optionSelect!.isNotEmpty)
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(height: 4),
                                                      ...item.optionSelect!.map((productOption) {
                                                        return Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(productOption.name ?? ""),
                                                            DropdownButtonFormField(
                                                              isExpanded: true,
                                                              padding: EdgeInsets.zero,
                                                              itemHeight: kMinInteractiveDimension,
                                                              decoration: const InputDecoration(
                                                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFEEEEEE)), gapPadding: 0),
                                                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFEEEEEE)), gapPadding: 0),
                                                                border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFEEEEEE)), gapPadding: 0),
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                                              ),
                                                              value: item.optionValues?[productOption],
                                                              items: productOption.productOptionValue.map((e) => DropdownMenuItem(
                                                                value: e,
                                                                child: Text(e.name ?? ""),
                                                              )).toList(), 
                                                              onChanged: (selectedOptionValue) {
                                                                if (selectedOptionValue != null) {
                                                                  controller.updateOptionValue(cartItem: item, cartGroup: group, option: productOption, value: selectedOptionValue);
                                                                }
                                                            })
                                                          ],
                                                        );
                                                      })

                                                    ],
                                                  ),
                                                ),

                                              
                                              const SizedBox(height: 5),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(),
                                                    // if (controller.isWishlisted(cartItem: item))
                                                    //   Container(),

                                                    // if (!controller.isWishlisted(cartItem: item))
                                                    //   GestureDetector(
                                                    //     onTap: () => controller.onWishlistItem(cartItem: item, cartGroup: group),
                                                    //     child: const Row(
                                                    //       children: [
                                                    //         Icon(Icons.favorite_border_outlined, color: AppColor.yellow),
                                                    //         SizedBox(width: 4),
                                                    //         Text('Pindah ke Wishlist')
                                                    //       ],
                                                    //     ),
                                                    //   ),
                                                    
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () => controller.onRemoveItem(cartItem: item, cartGroup: group),
                                                          child: const Icon(
                                                            Icons.delete,
                                                            color: AppColor.primaryColor,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 15),
                                                        Container(
                                                          padding: const EdgeInsets.all(5),
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              width: 1,
                                                              style: BorderStyle.solid,
                                                              color: Colors.black12,
                                                            ),
                                                            borderRadius: BorderRadius.circular(6),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              const SizedBox(width: 5),
                                                              GestureDetector(
                                                                onTap: () => item.quantity == 1 ? null : controller.onDecreaseItem(cartItem: item, cartGroup: group),
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  color: item.quantity == 1
                                                                      ? Colors.black12
                                                                      : AppColor.primaryColor,
                                                                ),
                                                              ),
                                                              const SizedBox(width: 5),
                                                              SizedBox(
                                                                width: 35,
                                                                child: TextField(
                                                                  controller: controller.totalItemControllers[index],
                                                                  onChanged: (value) {
                                                                    if (value == '') return;
                                                                    controller.onChangeItemQuantity(quantity: int.parse(value), cartItem: item, cartGroup: group);
                                                                  },
                                                                  keyboardType: TextInputType.number,
                                                                  inputFormatters: <TextInputFormatter>[
                                                                    FilteringTextInputFormatter.digitsOnly,
                                                                  ],
                                                                  textAlign: TextAlign.center,
                                                                  decoration: const InputDecoration(
                                                                    isDense: true,
                                                                    contentPadding: EdgeInsets.zero,
                                                                    border: InputBorder.none,
                                                                  ),
                                                                  style: const TextStyle(fontSize: 14),
                                                                ),
                                                              ),
                                                              const SizedBox(width: 5),
                                                              GestureDetector(
                                                                onTap: () => controller.onIncreaseItem(cartItem: item, cartGroup: group),
                                                                child: const Icon(
                                                                  Icons.add,
                                                                  color: AppColor.primaryColor,
                                                                ),
                                                              ),
                                                              const SizedBox(width: 5),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        );
                                      })
                                    ],
                                  );
                            })),
                          ),

                        /* ---------------------------- if cart is empty ---------------------------- */
                        if (cartGroups.isEmpty)
                          SliverToBoxAdapter(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 30,
                                horizontal: 10,
                              ),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Image.asset('assets/icon/ufomen_sad.webp'),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Wah, keranjang belanja kamu masih kosong',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 15),
                                  FilledButton(
                                    onPressed: () {
                                      Get.find<MainController>().tabController.index = 0;
                                      while (Get.currentRoute != MainScreen.routeName) {
                                        Get.back();
                                      }
                                    },
                                    child: const Text('Belanja Sekarang'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        const SliverToBoxAdapter(
                          child: SizedBox(height: 10),
                        ),

                        /* -------------------------- kemungkinan kamu suka ------------------------- */
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Column(
                              children: [
                                const SizedBox(height: 5),
                                const Text(
                                  'REKOMENDASI UNTUK KAMU',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "FuturaLT",
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.primaryColor
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Builder(
                                  builder: (context) {
                                    final productNoOfColumn = sizer.Device.screenType == sizer.ScreenType.tablet ? (sizer.Device.safeWidth / 200).ceil() : 2;
                                    return Column(
                                      children: [
                                        for (var row = 0; row < (controller.recommendedProducts.length ~/ productNoOfColumn); row++)
                                          Column(
                                            children: [
                                              Builder(
                                                builder: (context) {
                                                  final rowWidget = Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [const SizedBox(width: 10)],
                                                  );

                                                  for (var col = 0; col < productNoOfColumn; col++) {
                                                    if (controller.recommendedProducts.length > row*productNoOfColumn+col) {
                                                      rowWidget.children.add(Expanded(child: NewProducttile(product: controller.recommendedProducts[row*productNoOfColumn+col])));
                                                    } else {
                                                      rowWidget.children.add(Expanded(child: Container()));
                                                    }
                                                    rowWidget.children.add(const SizedBox(width: 7));
                                                  }
                                                  rowWidget.children.removeLast();
                                                  rowWidget.children.add(const SizedBox(width: 10));

                                                  return rowWidget;
                                                },
                                              ),
                                              const SizedBox(height: 7),
                                            ],
                                          )
                                      ],
                                    );
                                  },
                                ),
                              ],
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                      final isLoading = controller.isLoading.value;
                    return isLoading
                      ? Container()
                      : Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            color: const Color(0xFFCAE3F9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (controller.couponUsed.value?.code == null)
                                  const Text("Belum ada voucher yang terpakai", style: TextStyle(fontSize: 13))
                                else
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Promo Terpakai", style: TextStyle(fontSize: 13, color: Color(0xFF333333))),
                                      Text("${controller.couponUsed.value?.code}", 
                                        style: const TextStyle(fontSize: 20, color: Color(0xFF0060AF), fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                SizedBox(
                                  height: 30,
                                  child: FilledButton(
                                    onPressed: () {
                                      VoucherBinding().dependencies();
                                      showModalBottomSheet(
                                        context: context, 
                                        isScrollControlled: true,
                                        builder: (context) {
                                        return ModalBottomSheetDefault(
                                          title: "Voucher",
                                          child: (scrollController) {
                                            return VoucherScreen(
                                              source: VoucherClaimSource.cart, 
                                              prevSelectedVoucher: controller.couponUsed.value,
                                              scrollController: scrollController
                                            );
                                          },
                                        );
                                      })
                                      .then((result) async {
                                        await controller.load(shouldShowLoading: false);
                                      });
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: const WidgetStatePropertyAll(Colors.white),
                                      padding: const WidgetStatePropertyAll(
                                        EdgeInsets.symmetric(horizontal: 20),
                                      ),
                                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        side: const BorderSide(color: AppColor.primaryColor)
                                      ))
                                    ),
                                    child: Text(
                                      controller.couponUsed.value?.code == null ? "Pakai Voucher" : "Ganti Voucher",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.primaryColor
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            color: const Color(0xFFF7F7F7),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              color: Colors.white,
                              child: SafeArea(
                                top: false,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total Pesanan',
                                          style: Theme.of(context).textTheme.labelMedium,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(controller.grandTotal.value,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            height: 1,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFFBAA1A)
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context, 
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
                                              ),
                                              builder: (context) {
                                                return ModalBottomSheetDefault(
                                                  title: "RINCIAN BELANJA",
                                                  child: (scrollController) => Wrap(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                                                            child: Column(
                                                              children: [
                                                                if (controller.garansiUFOPro.value != null)
                                                                  Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          const Text("Garansi UFO PRO", style: TextStyle(color: Color(0xFF636363), fontSize: 12)),
                                                                          Text(controller.garansiUFOPro.value!, style: const TextStyle(color: Color(0xFF636363), fontSize: 12))
                                                                        ],
                                                                      ),
                                                                      const SizedBox(height: 8),
                                                                    ],
                                                                  ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    const Text("Jumlah", style: TextStyle(color: Color(0xFF636363), fontSize: 12)),
                                                                    Text(controller.subtotal.value, style: const TextStyle(color: Color(0xFF636363), fontSize: 12))
                                                                  ],
                                                                ),
                                                                const SizedBox(height: 8),
                                                                if (controller.couponUsed.value != null)
                                                                  Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Text("Voucher (${controller.couponUsed.value?.code})", style: const TextStyle(color: Color(0xFF636363), fontSize: 12)),
                                                                      Text(controller.voucherPrice.value ?? "", style: const TextStyle(color: Color(0xFF636363), fontSize: 12))
                                                                    ],
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                          const Divider(color: Color(0xFFEFEFEF),),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                const Text("Total", style: TextStyle(color: AppColor.primaryColor, fontSize: 12, fontWeight: FontWeight.bold)),
                                                                Text(controller.grandTotal.value, style: const TextStyle(color: Color(0xFFFBAA1A), fontSize: 15, fontWeight: FontWeight.bold))
                                                              ],
                                                            ),
                                                          ),
                                                          const Divider(color: Color(0xFFEFEFEF)),
                                                          if (controller.ufoPoin.value != null)
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 15),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  Image.asset("assets/icon/account/ufo-point.webp", width: 27),
                                                                  const SizedBox(width: 4),
                                                                  const Text(
                                                                    "UFO Poin",
                                                                    style: TextStyle(
                                                                      fontFamily: 'MYRIADPRO',
                                                                      fontSize: 12,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: AppColor.primaryColor
                                                                    ),
                                                                  ),
                                                                  const SizedBox(width: 4),
                                                                  Text(
                                                                    controller.ufoPoin.value ?? "",
                                                                    style: const TextStyle(
                                                                      fontFamily: 'MYRIADPRO',
                                                                      fontSize: 12,
                                                                      color: Color(0xFF636363)
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          SafeArea(child: Container())
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                );
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 4),
                                            child: const Text("Lihat Ringkasan", style: TextStyle(
                                              decoration: TextDecoration.underline,
                                              fontSize: 10,
                                              color: AppColor.primaryColor
                                            ),),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: FilledButton(
                                        onPressed: controller.checkout,
                                        style: FilledButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(6)
                                          )
                                        ),
                                        child: const Text(
                                          "Beli Sekarang",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                  })
                ],
              );
          });
      }),
    )
    );
  }
}
