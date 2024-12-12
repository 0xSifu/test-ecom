import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:ufo_elektronika/screens/refund/get_refund_response.dart';
import 'package:ufo_elektronika/screens/refund/post_refund_request.dart';
import 'package:ufo_elektronika/screens/refund/refund_repository.dart';
import 'package:ufo_elektronika/shared/utils/state_controller.dart';

class RefundController extends StateController<RefundDataResponse> {

  final RefundRepository _repository;
  final String orderId;
  RefundController({
    required RefundRepository repository,
    required this.orderId
  }): _repository = repository;

  final selectedReason = Rx<ReturnReason?>(null);
  final medias = RxList<XFile>();
  final bankName = "".obs;
  final accountNo = "".obs;
  final accountName = "".obs;
  final notes = "".obs;
  final isLoadingSubmit = false.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() {
    futurize(() => _repository.getRefundData(orderId));
  }

  void submit() {
    if (selectedReason.value == null) {
        Get.showSnackbar(const GetSnackBar(
          message: "Pilih Alasan terlebih dahulu",
          duration: Duration(seconds: 2),
        ));
      return;
    }
    if (medias.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        message: "Tambahkan foto atau video terlebih dahulu",
        duration: Duration(seconds: 2),
      ));
      return;
    }
    if (bankName.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        message: "Isi Nama Bank Terlebih Dahulu",
        duration: Duration(seconds: 2),
      ));
      return;
    }
    if (accountNo.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        message: "Isi Nomor Rekening Terlebih Dahulu",
        duration: Duration(seconds: 2),
      ));
      return;
    }
    if (accountName.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        message: "Isi Nama Pemilik Rekening Terlebih Dahulu",
        duration: Duration(seconds: 2),
      ));
      return;
    }

    isLoadingSubmit.value = true;

    final videos = medias.where((file) => lookupMimeType(file.path)?.startsWith("image/") == false).toList();
    final photos = medias.where((file) => lookupMimeType(file.path)?.startsWith("image/") == true).toList();
    final request = PostRefundRequest(
      videos: videos,
      photos: photos,
      reason: selectedReason.value?.returnReasonId ?? "", 
      productIds: state?.ordersAll?.product.map((product) => product.productId).whereNotNull().toList() ?? [],
      otherReasonNotes: notes.value, 
      orderId: orderId,
      accountName: accountName.value,
      accountNo: accountNo.value,
      bankName: bankName.value
    );

    _repository.postRefund(request)
      .then((res) {
        isLoadingSubmit.value = false;
        Get.showSnackbar(const GetSnackBar(
          message: "Berhasil mengajukan refund",
        ));
        Get.back();
      })
      .catchError((error) {
        isLoadingSubmit.value = false;
        Get.showSnackbar(const GetSnackBar(
          message: "Terjadi Kesalahan. Silakan Coba Lagi.",
          duration: Duration(seconds: 2),
        ));
      });
  }
}