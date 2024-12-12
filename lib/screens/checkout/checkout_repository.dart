import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/checkout/checkout_response.dart';
import 'package:ufo_elektronika/screens/checkout/snap_checkout_response.dart';
import 'package:ufo_elektronika/screens/checkout/process_checkout_request.dart';

abstract class CheckoutRepository {
  Future<CheckoutResponse> loadCheckout({String? addressId});
  Future<SnapCheckoutResponse> processCheckoutSnap(ProcessCheckoutRequest request);
  Future<String> processCheckoutManual(ProcessCheckoutRequest request);
}

class CheckoutRepositoryImpl extends CheckoutRepository {
  final Dio _dio;
  CheckoutRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<CheckoutResponse> loadCheckout({String? addressId}) async {
    String endpoint = "/checkout/checkout";
    if (addressId != null) endpoint += "&address_id=$addressId";
    final dioResp = await _dio.get(endpoint);
    // final res = jsonEncode(dioResp.data);
    final resp = CheckoutResponse.fromMap(dioResp.data);
    return resp;
  }

  @override
  Future<SnapCheckoutResponse> processCheckoutSnap(ProcessCheckoutRequest request) async {
    final map = request.toMap();
    final dioResp = await _dio.post("/checkout/snap/process_order", data: FormData.fromMap(map));
    final res = jsonEncode(dioResp.data);
    final resp = SnapCheckoutResponse.fromMap(dioResp.data);
    return resp;
  }

  @override
  Future<String> processCheckoutManual(ProcessCheckoutRequest request) async {
    final map = request.toMap();
    Response<dynamic> dioResp = await _dio.post("/checkout/payment_methods/addOrder", data: FormData.fromMap(map));
    final res = jsonEncode(dioResp.data);
    final redirection = dioResp.headers.value("location");
    if (dioResp.statusCode == HttpStatus.found && redirection != null) {
      return redirection;
    } else if (dioResp.statusCode == HttpStatus.ok) {
      throw DioException(
        requestOptions: dioResp.requestOptions, 
        response: dioResp
      ); 
    }
    throw DioException(
      requestOptions: dioResp.requestOptions, 
      response: Response(
        requestOptions: dioResp.requestOptions,
        data: {
          "error": "Terjadi Kesalahan. Silakan Coba Lagi"
        }
      )
    );
  }
}