import 'dart:io';

import 'package:get/get.dart';

import 'package:ufo_elektronika/screens/checkout_payment_confirmation/manual/checkout_payment_manual_repository.dart';
import 'package:ufo_elektronika/screens/checkout_payment_confirmation/manual/manual_order_response.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_repository.dart';
import 'package:ufo_elektronika/shared/utils/state_controller.dart';

class Instruction {
  final String title;
  final String desc;
  final bool isOpen;
  Instruction({
    required this.title,
    required this.desc,
    required this.isOpen,
  });

  Instruction copyWith({
    String? title,
    String? desc,
    bool? isOpen,
  }) {
    return Instruction(
      title: title ?? this.title,
      desc: desc ?? this.desc,
      isOpen: isOpen ?? this.isOpen,
    );
  }
}

class CheckoutPaymentManualController extends StateController<ManualOrderResponse> {
  final CheckoutPaymentManualRepository _repository;
  final TransactionRepository _transactionRepository;
  final String _redirectionUrl;
  CheckoutPaymentManualController({
    required CheckoutPaymentManualRepository repository,
    required String redirectionUrl,
    required TransactionRepository transactionRepository
  }): _repository = repository, _redirectionUrl = redirectionUrl, _transactionRepository = transactionRepository;

  final instructions = RxList<Instruction>();
  final canPop = false.obs;

  @override
  void onInit() {
    super.onInit();
    futurize(() => _repository.getInstruction(_redirectionUrl), onFinishLoading: (value) {
      instructions.clear();
      instructions.add(Instruction(
        title: value.paymentInstruction?.subtitle1 ?? "", 
        desc: value.paymentInstruction?.description ?? "", 
        isOpen: true
      ));
      instructions.add(Instruction(
        title: value.paymentInstruction?.subtitle2 ?? "", 
        desc: value.paymentInstruction?.description2 ?? "", 
        isOpen: false
      ));
      instructions.add(Instruction(
        title: value.paymentInstruction?.subtitle3 ?? "", 
        desc: value.paymentInstruction?.description3 ?? "", 
        isOpen: false
      ));
    });
  }

  void toggleOpen(Instruction instruction) {
    final instrIndex = instructions.indexOf(instruction);
    if (instrIndex >= 0) {
      instructions[instrIndex] = instructions[instrIndex].copyWith(isOpen: !instructions[instrIndex].isOpen);
    }
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