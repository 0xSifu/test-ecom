import 'package:dio/dio.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_statuses_response.dart';
import 'package:ufo_elektronika/screens/transaction_detail/transaction_detail_response.dart';

abstract class TransactionDetailRepository {

  Future<TransactionDetailResponse> getTransactionDetail(String transactionId);
  Future<void> addOrderHistory({required String orderId, required TransactionStatus orderStatus});

}

class TransactionDetailRepositoryImpl extends TransactionDetailRepository {
  final Dio _dio;
  TransactionDetailRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<TransactionDetailResponse> getTransactionDetail(String transactionId) async {
    final dioResp = await _dio.get("account/order/info&order_id=$transactionId");
    final res = TransactionDetailResponse.fromMap(dioResp.data);
    return res;
  }

  @override
  Future<void> addOrderHistory({required String orderId, required TransactionStatus orderStatus}) async {
    await _dio.post("checkout/checkout/history&order_id=$orderId", data: FormData.fromMap({
      "order_status_id": orderStatus.rawValue
    }));
    // final res = jsonEncode(dioResp.data);
    // print(res);
    return;
  }
}