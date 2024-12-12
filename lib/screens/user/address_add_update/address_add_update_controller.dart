import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/user/address/address_response.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/address_add_update_repository.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/address_request.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/city_response.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/kecamatan_response.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/kelurahan_response.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/provinces_response.dart';

class AddressAddUpdateController extends GetxController {
  final AddressAddUpdateRepository _repository;
  AddressAddUpdateController({required AddressAddUpdateRepository repository}): _repository = repository;

  final addressId = Rx<String?>(null);
  final currentAddress = Rx<Address?>(null);
  final addressName = "".obs;
  final receiverName = "".obs;
  final phone = "".obs;
  final province = Rx<Province?>(null);
  final city = Rx<City?>(null);
  final kecamatan = Rx<Kecamatan?>(null);
  final kelurahan = Rx<Kelurahan?>(null);
  final postalCode = "".obs;
  final address = "".obs;
  final isMainAddress = false.obs;

  final isSubmitting = false.obs;
  final isLoading = false.obs;
  final provinces = RxList<Province>([]);
  final cities = RxList<City>([]);
  final kecamatans = RxList<Kecamatan>([]);
  final kelurahans = RxList<Kelurahan>([]);

  bool get isSubmitEnabled => true;

  @override
  void onInit() {
    super.onInit();

    _repository.getProvinces()
      .then((value) {
        provinces.assignAll(value.provinces);
        if (addressId.value != null) {
          loadAddress();
        }
      })
      .catchError((error) {

      });
    
    bool skipFirst = false;
    ever(addressId, (callback) {
      if (skipFirst == false) {
        skipFirst = true;
        return;
      }
      loadAddress();
    });
  }

  void loadAddress() {
    isLoading.value = true;
    final addressIdValue = addressId.value;
    if (addressIdValue != null) {
      _repository.getAddressById(addressIdValue)
        .then((value) {
          // print(value);
          isLoading.value = false;
          currentAddress.value = value;
          address.value = value.address1 ?? "";
          addressName.value = value.address2 ?? "";
          receiverName.value = "${value.firstname} ${value.lastname}";
          phone.value = value.phone ?? "";
          postalCode.value = value.postcode ?? "";
          isMainAddress.value = value.defaultAddress ?? false;
          final selectedProvince = provinces.firstWhereOrNull((province) => province.provinceId == value.countryId);
          if (selectedProvince != null) {
            selectProvince(selectedProvince)
            .then((_) {
              final city = cities.firstWhereOrNull((city) => city.cityId == value.zoneId);
              if (city != null) return selectCity(city);
            })
            .then((_) {

              final kecamatan = kecamatans.firstWhereOrNull((kecamatan) => kecamatan.kecamatanId == value.cityId);
              if (kecamatan != null) return selectKecamatan(kecamatan);
            })
            .then((_) {

              final kelurahan = kelurahans.firstWhereOrNull((kelurahan) => kelurahan.id == value.kelId);
              if (kelurahan != null) return selectKelurahan(kelurahan);
            });
          }
        })
        .catchError((error) {
          isLoading.value = false;
          Get.showSnackbar(GetSnackBar(
            message: error is DioException ? error.response?.data["error"] : error.toString(),
            duration: const Duration(seconds: 2),
          ));
          return error;
        });
    }
  }

  Future<void> selectProvince(Province newProvince) {
    province.value = newProvince;
    return _repository.getCitiesByProvinceId(newProvince.provinceId ?? "")
      .then((value) => cities.assignAll(value.cities))
      .catchError((error) {

      });
  }

  Future<void> selectCity(City newCity) {
    city.value = newCity;
    return _repository.getKecamatansByCityId(newCity.cityId ?? "")
    .then((value) => kecamatans.assignAll(value.kecamatans))
    .catchError((error) {

    });
  }

  Future<void> selectKecamatan(Kecamatan newKecamatan) {
    kecamatan.value = newKecamatan;
    return _repository.getKelurahansByKecamatanId(newKecamatan.kecamatanId ?? "")
      .then((value) => kelurahans.assignAll(value.kelurahans))
      .catchError((error) {

      });
  }

  void selectKelurahan(Kelurahan newKelurahan) {
    kelurahan.value = newKelurahan;
  }

  void submit() {
    isSubmitting.value = true;
    final request = AddressRequest(
      fullname: receiverName.value, 
      cityId: kecamatan.value?.kecamatanId ?? "", 
      phone: phone.value, 
      postcode: postalCode.value, 
      zoneId: city.value?.cityId ?? "", 
      countryId: province.value?.provinceId ?? "", 
      kelId: kelurahan.value?.id ?? "", 
      address2: addressName.value, 
      address1: address.value, 
      defaultStr: isMainAddress.value ? "1" : "0", 
      addressId: addressId.value, 
      geoCode: null
    );
    _repository.submit(request)
      .then((value) {
        isSubmitting.value = false;
        Get.back();
      })
      .catchError((error) {
        isSubmitting.value = false;
        Get.showSnackbar(GetSnackBar(
          message: error is DioException ? error.response?.data["error"] : error.toString(),
          duration: const Duration(seconds: 2),
        ));
        return error;
      });
  }
  
}