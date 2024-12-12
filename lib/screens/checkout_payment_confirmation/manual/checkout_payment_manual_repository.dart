import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/checkout_payment_confirmation/manual/manual_order_response.dart';

abstract class CheckoutPaymentManualRepository {
  Future<ManualOrderResponse> getInstruction(String redirectUrl);
}

class CheckoutPaymentManualRepositoryImpl extends CheckoutPaymentManualRepository {
  final Dio _dio;
  CheckoutPaymentManualRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<ManualOrderResponse> getInstruction(String redirectUrl) async {
    final dioResp = await _dio.get(redirectUrl);
    final res = jsonEncode(dioResp.data);
    final resp = ManualOrderResponse.fromMap(dioResp.data);
    return resp;
  }
}