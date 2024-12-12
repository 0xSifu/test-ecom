import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/refund/get_refund_response.dart';
import 'package:ufo_elektronika/screens/refund/post_refund_request.dart';

abstract class RefundRepository {
  Future<RefundDataResponse> getRefundData(String orderId);
  Future<void> postRefund(PostRefundRequest request);
}

class RefundRepositoryImpl extends RefundRepository {
  final Dio _dio;
  RefundRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<RefundDataResponse> getRefundData(String orderId) async {
    final dioRes = await _dio.get("account/return&order_id=$orderId");
    final res = jsonEncode(dioRes.data);
    final resp = RefundDataResponse.fromMap(dioRes.data);
    print(dioRes.data);
    return resp;
  }

  @override
  Future<void> postRefund(PostRefundRequest request) async {
    final dioResp = await _dio.post("account/return/add", data: FormData.fromMap(await request.toMap()));
    final res = jsonEncode(dioResp.data);
    print(dioResp.data);
    return;
  }
}