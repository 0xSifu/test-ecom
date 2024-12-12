import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/user/ufopoint/ufopoint_repository.dart';
import 'package:ufo_elektronika/screens/user/ufopoint/ufopoint_response.dart';

class UfoPointController extends GetxController {
  final UfoPointRepository _repository;
  UfoPointController({required UfoPointRepository repository}): _repository = repository;

  final ufoPoint = Rx<UfoPointResponse?>(null);

  @override
  void onInit() {
    super.onInit();
     _repository.getUfoPoints()
      .then((value) {
        ufoPoint.value = value;
      })
      .catchError((error) {
        Get.showSnackbar(const GetSnackBar(
          message: "Ada kesalahan dalam mengambil data. Silakan coba lagi.",
          duration: Duration(seconds: 3),
        ));
      });
  }

  void claim(Coupon coupon) {
    _repository.claim(coupon.code!)
      .then((value) {
        if (value["error"] != null && value["error"]?.toString().isNotEmpty == true) {
          Get.showSnackbar(GetSnackBar(
            message: value["error"]?.toString(),
            duration: const Duration(seconds: 3),
          ));
        } else if (value["success"] != null && value["success"]?.toString().isNotEmpty == true) {
          Get.back(result: "OK");
          Future.delayed(const Duration(milliseconds: 300), () {
            Get.showSnackbar(GetSnackBar(
              message: value["success"]?.toString(),
              duration: const Duration(seconds: 3),
            ));
          });
        } else {
          Get.back(result: "OK");
          Future.delayed(const Duration(milliseconds: 300), () {
            Get.showSnackbar(const GetSnackBar(
              message: "Berhasil klaim voucher",
              duration: Duration(seconds: 3),
            ));
          });
        }
      })
      .catchError((error) {
        Get.showSnackbar(const GetSnackBar(
          message: "Ada kesalahan dalam mengambil data. Silakan coba lagi.",
          duration: Duration(seconds: 3),
        ));
      });

  }
}