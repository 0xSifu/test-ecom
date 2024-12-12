import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/address_add_update_controller.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/city_response.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/kecamatan_response.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/kelurahan_response.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/provinces_response.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/common/modal_bottom_sheet_default.dart';

class AddressAddUpdateScreen extends GetView<AddressAddUpdateController> {
  static const routeName = "/add-update-address";
  final String? addressId;
  const AddressAddUpdateScreen({super.key, required this.addressId});

  @override
  Widget build(BuildContext context) {
    
    final formKey = GlobalKey<FormState>();
    controller.addressId.value = addressId;

    // input decoration
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
      backgroundColor: Colors.white,
      appBar: UEAppBar(
        title: addressId == null ? 'Tambah Alamat' : "Ubah Alamat",
        showCart: false,
        showNotification: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
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
          ));
        }
        
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: controller.currentAddress.value?.address2,
                    maxLength: 50,
                    onChanged: (value) => controller.addressName.value = value,
                    decoration: inputDecoration.copyWith(
                      hintText: 'Nama Alamat',
                      label: const Text('Nama Alamat'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: controller.currentAddress.value != null ? "${controller.currentAddress.value?.firstname} ${controller.currentAddress.value?.lastname}" : null,
                    onChanged: (value) => controller.receiverName.value = value,
                    maxLength: 50,
                    decoration: inputDecoration.copyWith(
                      hintText: 'Nama Penerima',
                      label: const Text('Nama Penerima'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: controller.currentAddress.value?.phone,
                    onChanged: (value) => controller.phone.value = value,
                    maxLength: 16,
                    keyboardType: TextInputType.phone,
                    decoration: inputDecoration.copyWith(
                      hintText: 'Nomor Telepon Penerima',
                      label: const Text('Nomor Telepon Penerima'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      showAddressBottomSheet<Province>(
                        context: context, 
                        title: "Provinsi", 
                        items: controller.provinces, 
                        onTap: (selectedProvince) {
                          controller.selectProvince(selectedProvince);
                        }, 
                        getName: (selectedProvince) => selectedProvince.name ?? "", 
                        isSelected: (selectedProvince) => selectedProvince.provinceId == controller.province.value?.provinceId
                      );
                    },
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
                          if (controller.province.value != null)
                            const Text(
                              'Provinsi',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          Text(
                            controller.province.value?.name ?? 'Provinsi',
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
                  GestureDetector(
                    onTap: () => showAddressBottomSheet<City>(
                      context: context, 
                      title: "Kota / Kabupaten", 
                      items: controller.cities, 
                      onTap: controller.selectCity, 
                      getName: (selectedCity) => selectedCity.name ?? "", 
                      isSelected: (selectedCity) => selectedCity.cityId == controller.city.value?.cityId
                    ),
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
                          if (controller.city.value != null)
                            const Text(
                              'Kota / Kabupaten',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          Text(
                            controller.city.value?.name ?? controller.currentAddress.value?.city ?? 'Kota / Kabupaten',
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
                  GestureDetector(
                    onTap: () => showAddressBottomSheet<Kecamatan>(
                      context: context, 
                      title: "Kecamatan", 
                      items: controller.kecamatans, 
                      onTap: controller.selectKecamatan, 
                      getName: (selectedKecamatan) => selectedKecamatan.name ?? "", 
                      isSelected: (selectedKecamatan) => selectedKecamatan.kecamatanId == controller.kecamatan.value?.kecamatanId
                    ),
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
                          if (controller.kecamatan.value != null)
                            const Text(
                              'Kecamatan',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          Text(
                            controller.kecamatan.value?.name ?? 'Kecamatan',
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
                  GestureDetector(
                    onTap: () => showAddressBottomSheet<Kelurahan>(
                      context: context, 
                      title: "Kelurahan", 
                      items: controller.kelurahans, 
                      onTap: controller.selectKelurahan, 
                      getName: (selectedKelurahan) => selectedKelurahan.kelurahan ?? "", 
                      isSelected: (selectedKelurahan) => selectedKelurahan.id == controller.kelurahan.value?.id
                    ),
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
                          if (controller.kelurahan.value != null)
                            const Text(
                              'Kelurahan',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          Text(
                            controller.kelurahan.value?.kelurahan ?? 'Kelurahan',
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
                  TextFormField(
                    initialValue: controller.currentAddress.value?.postcode,
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => controller.postalCode.value = value,
                    decoration: inputDecoration.copyWith(
                      hintText: 'Kode Pos',
                      label: const Text('Kode Pos'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Wajib diisi';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: controller.currentAddress.value?.address1,
                    minLines: 2,
                    maxLines: 3,
                    maxLength: 255,
                    onChanged: (value) => controller.address.value = value,
                    decoration: inputDecoration.copyWith(
                      hintText: 'Alamat',
                      label: const Text('Alamat'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  CheckboxListTile(
                    value: controller.isMainAddress.value == true,
                    onChanged: (value) {
                      controller.isMainAddress.value = value == true;
                    },
                    title: const Text('Simpan sebagai alamat utama'),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: const EdgeInsets.all(0),
                  ),
                  const SizedBox(height: 10),
                  
                  if (controller.isSubmitting.value)
                    const Center(child: CircularProgressIndicator()),

                  if (!controller.isSubmitting.value)
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child:  FilledButton(
                        onPressed: controller.isSubmitEnabled == true ? controller.submit : null,
                        child: const Text('Simpan'),
                      )
                    ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void showAddressBottomSheet<T>({
    required BuildContext context, 
    required String title,
    required List<T> items,
    required Function(T) onTap,
    required String Function(T) getName,
    required bool Function(T) isSelected
  }) {
    
    showModalBottomSheet(
      context: context,
      elevation: 0,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
      ),
      builder: (context) => ModalBottomSheetDefault(
        title: title,
        closeButtonLeft: true,
        child: (scrollController) => StatefulBuilder(
          builder: (context, setState) => SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                for (T item in items)
                  GestureDetector(
                    onTap: () {
                      onTap(item);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFF1F1F1),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(getName(item),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (isSelected(item))
                            const Icon(
                              Icons.check,
                              color: AppColor.primaryColor,
                            ),
                        ],
                      )
                    ),
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


