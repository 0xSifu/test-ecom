
import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/user/address/address_response.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/address_request.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/city_response.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/kecamatan_response.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/kelurahan_response.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/provinces_response.dart';

abstract class AddressAddUpdateRepository {
  Future<Address> getAddressById(String addressId);
  Future<AddressResponse> getAddress();
  Future<ProvinceResponse> getProvinces();
  Future<CityResponse> getCitiesByProvinceId(String provinceId);
  Future<KecamatanResponse> getKecamatansByCityId(String cityId);
  Future<KelurahanResponse> getKelurahansByKecamatanId(String kecamatanId);
  Future<void> submit(AddressRequest addressRequest);
}

class AddressAddUpdateRepositoryImpl extends AddressAddUpdateRepository {

  final Dio _dio;
  AddressAddUpdateRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<Address> getAddressById(String addressId) async {
    final dioResp = await _dio.get("account/address/getForm&address_id=$addressId");
    // print(jsonEncode(dioResp.data));
    return Address.fromMap(dioResp.data);
  }

  @override
  Future<AddressResponse> getAddress() async {
    final dioResp = await _dio.get("account/address");
    final res = AddressResponse.fromMap(dioResp.data);
    return res;
  }

  @override
  Future<ProvinceResponse> getProvinces() async {
    final dioResp = await _dio.get("informations/master/countries");
    final res = ProvinceResponse.fromMap(dioResp.data);
    return res;
  }

  @override
  Future<CityResponse> getCitiesByProvinceId(String provinceId) async {
    final dioResp = await _dio.get("informations/master/zone&country_id=$provinceId");
    final res = CityResponse.fromMap(dioResp.data);
    return res;
  }

  @override
  Future<KecamatanResponse> getKecamatansByCityId(String cityId) async {
    final dioResp = await _dio.get("informations/master/cities&zone_id=$cityId");
    final res = KecamatanResponse.fromMap(dioResp.data);
    return res;
  }

  @override
  Future<KelurahanResponse> getKelurahansByKecamatanId(String kecamatanId) async {
    final dioResp = await _dio.get("informations/master/kelurahan&city_id=$kecamatanId");
    final res = KelurahanResponse.fromMap(dioResp.data);
    return res;
  }

  @override
  Future<void> submit(AddressRequest addressRequest) async {
    final map = addressRequest.toMap();
    await _dio.post("account/address/${addressRequest.addressId != null ? "edit" : "add"}", data: FormData.fromMap(map));
  }
}