import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';
import 'package:ufo_elektronika/screens/information/information_repository.dart';
import 'package:ufo_elektronika/screens/information/information_response.dart';
import 'package:ufo_elektronika/screens/user/notification/notification_response.dart';

class InformationController extends GetxController {
  final InformationRepository _repository;
  final String? _id;
  final String? _notificationId;
  final response = Rx<InformationResponse?>(null);
  final products = RxList<Product>();
  final canLoadMore = false.obs;
  int page = 1;

  InformationController({
    required InformationRepository repository,
    required String? id,
    required String? notificationId,
  }): _repository = repository, _id = id, _notificationId = notificationId;

  @override
  void onInit() {
    super.onInit();
    Future<InformationResponse>? future;
    if (_id != null) {
     future = _repository.getInformation(id: _id, page: page);
    } else if (_notificationId != null) {
      future = _repository.getNotification(id: _notificationId, page: null);
    }
    future
        ?.then((value) {
          response.value = value;
          products.addAll(value.products);
          if (value.limit != null && value.products.isNotEmpty) {
            canLoadMore.value = value.products.length >= (value.limit ?? 0);
          }
          if (canLoadMore.value) {
            page += 1;
          }
        })
        .catchError((error) {
          Get.showSnackbar(const GetSnackBar(
            message: "Terjadi kesalahan. Silakan coba lagi",
            duration: Duration(seconds: 2),
          ));
        });
  }

  void loadMoreProduct() {
    if (_id != null) {
      _repository.getInformation(id: _id, page: page)
        .then((value) {
          products.addAll(value.products);
          canLoadMore.value = value.products.length >= (value.limit ?? 0);
          if (canLoadMore.value) {
            page += 1;
          }
        })
        .catchError((error) {
          Get.showSnackbar(const GetSnackBar(
            message: "Terjadi kesalahan. Silakan coba lagi",
            duration: Duration(seconds: 2),
          ));
        });
    }
  }

}