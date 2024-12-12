import 'package:flutter/material.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/common/modal_bottom_sheet_default.dart';
import 'package:ufo_elektronika/widgets/layouts/default_layout.dart';

class AddressUpdateScreen extends StatefulWidget {
  const AddressUpdateScreen({super.key, this.addressId});
  final String? addressId;

  @override
  State<AddressUpdateScreen> createState() => _AddressUpdateScreenState();
}

class _AddressUpdateScreenState extends State<AddressUpdateScreen> {
  final _formKey = GlobalKey<FormState>();

  // input controller
  final TextEditingController addressNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // loading state
  bool _isLoading = true;
  // data address
  Map<String, dynamic> _dataAddress = {};

  // data province
  List<Map<String, dynamic>> _province = [];
  // data city
  List<Map<String, dynamic>> _city = [];
  // data kecamatan
  List<Map<String, dynamic>> _kecamatan = [];
  // data kelurahan
  List<Map<String, dynamic>> _kelurahan = [];
  // selected area name
  final Map<String, dynamic> _areaName = {};

  // input decoration
  static InputDecoration inputDecoration = const InputDecoration(
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

  /* ---------------------------- Dummy fetch data ---------------------------- */
  Future<void> _fetchData() async {
    // Simulate a refresh operation (e.g., fetching updated data)
    await Future.delayed(
      const Duration(milliseconds: 500),
      () {
        if (mounted) {
          // set state
          setState(() {
            _dataAddress = {
              'addressName': 'John Doe',
              'name': 'Jogn Doe',
              'phone': '089123123123',
              'province': 2,
              'city': 1,
              'kecamatan': 2,
              'kelurahan': 2,
              'zip': 12345,
              'address': 'Jl Merdeka Raya No 17',
              'mainAddress': true,
            };
            _areaName['province'] = 'DKI Jakarta';
            _areaName['city'] = 'Kota Jakarta Barat';
            _areaName['kecamatan'] = 'Grogol Petamburan';
            _areaName['kelurahan'] = 'Grogol';

            // data province
            _province = [
              {'id': 1, 'name': 'Banten'},
              {'id': 2, 'name': 'DKI Jakarta'},
              {'id': 3, 'name': 'Jawa Tengah'},
              {'id': 4, 'name': 'Jawa Timur'},
              {'id': 5, 'name': 'Jawa Timur'},
            ];

            // data city
            _city = [
              {'id': 1, 'name': 'Kota Jakarta Barat'},
              {'id': 2, 'name': 'Kota Jakarta Pusat'},
              {'id': 3, 'name': 'Kota Jakarta Selatan'},
              {'id': 4, 'name': 'Kota Jakarta Timur'},
            ];

            // data kecamatan
            _kecamatan = [
              {'id': 1, 'name': 'Cengkkareng'},
              {'id': 2, 'name': 'Grogol Petamburan'},
              {'id': 3, 'name': 'Kalideres'},
              {'id': 4, 'name': 'Kebon Jeruk'},
            ];

            // data kelurahan
            _kelurahan = [
              {'id': 1, 'name': 'Tomang'},
              {'id': 2, 'name': 'Grogol'},
              {'id': 3, 'name': 'Jelambar'},
              {'id': 4, 'name': 'Jelambar Baru'},
            ];

            // set input value
            addressNameController.text = _dataAddress['addressName'];
            nameController.text = _dataAddress['name'];
            phoneController.text = _dataAddress['phone'];
            zipController.text = _dataAddress['zip'].toString();
            addressController.text = _dataAddress['address'];

            _isLoading = false;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _fetchData();
  }

  void selectArea(String type, BuildContext context) {
    // bottom sheet title
    String title = '';
    // area list
    List<Map<String, dynamic>> items = [];

    if (type == 'province') {
      title = 'Provinsi';
      items = _province;
    }
    if (type == 'city') {
      title = 'Kota / Kabupaten';
      items = _city;
    }
    if (type == 'kecamatan') {
      title = 'Kecamatan';
      items = _kecamatan;
    }
    if (type == 'kelurahan') {
      title = 'Kelurahan';
      items = _kelurahan;
    }

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
                for (var item in items)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _dataAddress[type] = item['id'];
                        _areaName[type] = item['name'];
                      });

                      areaOnChange();
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
                          Text(
                            item['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (item['id'] == _dataAddress[type])
                            const Icon(
                              Icons.check,
                              color: AppColor.primaryColor,
                            ),
                        ],
                      ),
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

  void areaOnChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const UEAppBar(
        title: 'Ubah Alamat',
        showCart: false,
        showNotification: false,
      ),
      body: DefaultLayout(
        child: _isLoading
            ? const Center(
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
              ))
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: addressNameController,
                          maxLength: 50,
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
                          controller: nameController,
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
                          controller: phoneController,
                          maxLength: 16,
                          keyboardType: TextInputType.number,
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
                          onTap: () => selectArea('province', context),
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
                                if (_areaName['province'] != null)
                                  const Text(
                                    'Provinsi',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                Text(
                                  _areaName['province'] ?? 'Provinsi',
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
                          onTap: () => selectArea('city', context),
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
                                if (_areaName['city'] != null)
                                  const Text(
                                    'Kota / Kabupaten',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                Text(
                                  _areaName['city'] ?? 'Kota / Kabupaten',
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
                          onTap: () => selectArea('kecamatan', context),
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
                                if (_areaName['kecamatan'] != null)
                                  const Text(
                                    'Kecamatan',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                Text(
                                  _areaName['kecamatan'] ?? 'Kecamatan',
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
                          onTap: () => selectArea('kelurahan', context),
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
                                if (_areaName['kelurahan'] != '')
                                  const Text(
                                    'Kelurahan',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                Text(
                                  _areaName['kelurahan'] != ''
                                      ? _areaName['kelurahan']
                                      : 'Kelurahan',
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
                          controller: zipController,
                          maxLength: 5,
                          keyboardType: TextInputType.number,
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
                          controller: addressController,
                          minLines: 2,
                          maxLines: 3,
                          maxLength: 255,
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
                          value: _dataAddress['mainAddress'],
                          onChanged: (value) {
                            setState(() {
                              _dataAddress['mainAddress'] =
                                  !_dataAddress['mainAddress'];
                            });
                          },
                          title: const Text('Simpan sebagai alamat utama'),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Simpan'),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
