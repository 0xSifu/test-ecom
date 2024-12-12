import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_statuses_response.dart';
import 'package:ufo_elektronika/screens/transaction/transactions_response.dart';

abstract class TransactionRepository {
  Future<List<TransactionStatusesResponse>> getTransactionStatuses();
  Future<TransactionsResponse> searchByProductNameAndOrderId();
  Future<TransactionsResponse> getTransactions({
    required int page, 
    required String? search, 
    required String? periode, 
    required String? orderStatus,
    required bool isClickAndCollectOn
  });
  Future<void> uploadPaymentProof(String orderId, String accountName, File image);
}

class TransactionRepositoryImpl extends TransactionRepository {
  final Dio _dio;
  TransactionRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<List<TransactionStatusesResponse>> getTransactionStatuses() async {
    final dioResp = await _dio.get("informations/order_status");
    final res = List<TransactionStatusesResponse>.from(dioResp.data.map((x) => TransactionStatusesResponse.fromMap(x)));
    List<TransactionStatusesResponse> list = [];
    for (var status in res) {
      if (list.firstWhereOrNull((element) => element.orderStatusId == status.orderStatusId) == null) {
        list.add(status);
      }
    }
    return list;
  }

  @override
  Future<TransactionsResponse> searchByProductNameAndOrderId() async {
    final dioResp = await _dio.post("account/order/checkProductName");
    final res = TransactionsResponse.fromMap(dioResp.data);
    return res;
  }

  @override
  Future<TransactionsResponse> getTransactions({
    required int page, 
    required String? search, 
    required String? periode, 
    required String? orderStatus,
    required bool isClickAndCollectOn
  }) async {
    // final orderStatus = search?.isNotEmpty == true ? int.tryParse(search!) : null;
    final queryParam = {
      "page": page,
      "name": search?.isNotEmpty == true && orderStatus == null ? search : null,
      "order_status": orderStatus,
      "periode": periode?.isNotEmpty == true ? periode : null,
      "click_and_collect": isClickAndCollectOn ? 1 : null
    };
    queryParam.removeWhere((key, value) => value == null);
    final dioResp = await _dio.get("account/order", queryParameters: queryParam);
    final res = TransactionsResponse.fromMap(dioResp.data);
    return res;
  }

  @override
  Future<void> uploadPaymentProof(String orderId, String accountName, File image) async {
    await _dio.post("checkout/payment_confirmation", data: FormData.fromMap({
      "order_id": orderId,
      "atas_nama_rekening": accountName,
      "image": await MultipartFile.fromFile(image.path, contentType: MediaType.parse(lookupMimeType(image.path) ?? ""))
    }));
  }
}