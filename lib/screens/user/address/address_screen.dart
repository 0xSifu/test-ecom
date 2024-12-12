import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/user/address/address_controller.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/address_add_update_screen.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/common/modal_bottom_sheet_default.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AddressScreen extends GetView<AddressController> {
  static const routeName = "/address";
  const AddressScreen({super.key});

  void addressOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 0,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
      ),
      builder: (context) => ModalBottomSheetDefault(
        title: 'Pilihan Lainnya',
        closeButtonLeft: true,
        child: (scrollController) => SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Jadikan Alamat Utama dan Pilih',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Hapus Alamat',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: UEAppBar(
        title: 'Alamat',
        showCart: false,
        showNotification: false,
        actions: [
          GestureDetector(
            onTap: () => Get.toNamed(AddressAddUpdateScreen.routeName),
            child: const Text(
              'Tambah alamat',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Obx(() => VisibilityDetector(
        key: const Key("address"),
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction >= 0.9) {
            controller.loadAddress();
          }
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: (controller.address.value?.addresses ?? []).map((e) => Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              padding: const EdgeInsets.all(15),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${e.firstname} ${e.lastname}",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),

                      /* ------------------------- selected address badge ------------------------- */
                      if (e.main != "0")
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColor.primaryColor,
                          ),
                          child: const Text(
                            'Utama',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Text(e.phone ?? ""),
                  const SizedBox(height: 7),
                  Text(e.address1 ??""),
                  const SizedBox(height: 7),
                  // Html(data: "<p>${e.address1 ?? ""}</p>", style: {
                  //   "*": Style(
                  //     padding: HtmlPaddings.zero
                  //   ),
                  //   "p": Style(
                  //     padding: HtmlPaddings.zero
                  //   )
                  // },),
                  const SizedBox(height: 0),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () => Get.toNamed(AddressAddUpdateScreen.routeName, parameters: {
                            "id": e.addressId ?? ""
                          }),
                          child: const Text(
                            'Ubah Alamat',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFFF54F4D)
                          ),
                          onPressed: () {
                            if (e.addressId != null) controller.deleteAddress(e.addressId!);
                          },
                          child: const Text(
                            'Hapus Alamat',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList()
          )
        ),
      )),
    );
  }
}
