import 'dart:io';

import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_repository.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_statuses_response.dart';
import 'package:ufo_elektronika/screens/transaction_detail/transaction_detail_repository.dart';
import 'package:ufo_elektronika/screens/transaction_detail/transaction_detail_response.dart';
import 'package:ufo_elektronika/shared/utils/state_controller.dart';

class TransactionDetailController extends StateController<TransactionDetailResponse> {

  final TransactionDetailRepository _repository;
  final TransactionRepository _transactionRepository;
  TransactionDetailController({
    required TransactionDetailRepository repository, 
    required TransactionRepository transactionRepository
  }): _repository = repository, _transactionRepository = transactionRepository;

  final showAllProduct = false.obs;
  final isLoadingPostItemReceived = false.obs;

  void load(String transactionId) {
    futurize(() => _repository.getTransactionDetail(transactionId));
  }

  void postItemReceived(String transactionId) {
    isLoadingPostItemReceived.value = true;
    _repository.addOrderHistory(orderId: transactionId, orderStatus: TransactionStatus.completed)
      .then((value) {
        isLoadingPostItemReceived.value = false;
      })
      .catchError((error) {
        isLoadingPostItemReceived.value = false;
        Get.showSnackbar(const GetSnackBar(
          message: "Terjadi Kesalahan. Silakan Coba Lagi.",
          duration: Duration(seconds: 2),
        ));
      });
  }

  Future<void> uploadPaymentProof(String orderId, String accountName, File image) async {
   return _transactionRepository.uploadPaymentProof(orderId, accountName, image)
      .then((value) {
        Get.showSnackbar(const GetSnackBar(
          message: "Berhasil mengupload bukti pembayaran",
          duration: Duration(seconds: 3),
        ));
      })
      .catchError((error) {
        Get.showSnackbar(const GetSnackBar(
          message: "Gagal mengupload bukti pembayaran. Silakan coba lagi.",
          duration: Duration(seconds: 3),
        ));
      });
  }
}