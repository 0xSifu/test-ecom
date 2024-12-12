import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/user/address/address_response.dart';

abstract class AddressRepository {
  Future<AddressResponse> getAddress();
  Future<dynamic> removeAddress(String addressId);
}

class AddressRepositoryImpl extends AddressRepository {
  final Dio _dio;
  AddressRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<AddressResponse> getAddress() async {
    final dioResp = await _dio.get("account/address");
    final res = AddressResponse.fromMap(dioResp.data);
    return res;
  }

  @override
  Future<dynamic> removeAddress(String addressId) async {
    final dioResp = await _dio.get("account/address/delete&address_id=$addressId");
    // final res = AddressResponse.fromMap(dioResp.data);
    return dioResp.data;
  }
  

}