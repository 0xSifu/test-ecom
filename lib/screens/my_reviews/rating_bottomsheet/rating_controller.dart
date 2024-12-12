import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ufo_elektronika/screens/my_reviews/rating_bottomsheet/rating_repository.dart';
import 'package:ufo_elektronika/screens/my_reviews/rating_bottomsheet/rating_request.dart';
import 'package:ufo_elektronika/screens/transaction/transactions_response.dart';
import 'package:mime/mime.dart';

class RatingController extends GetxController {
  final RatingRepository _repository;
  final List<OrderProduct> products;
  final String orderId;
  final String dateAdded;
  RatingController({
    required RatingRepository repository,
    required this.products,
    required this.orderId, 
    required this.dateAdded
  }): _repository = repository;

  @override
  void onInit() {
    super.onInit();
    for (var product in products) {
      ratings[product] = 5;
      notes[product] = "";
      medias[product] = [];
      isRateLoading[product] = false;
      isRated[product] = false;
    }
  }
  
  final ratings = RxMap<OrderProduct, int>();
  final notes = RxMap<OrderProduct, String>();
  final medias = RxMap<OrderProduct, List<XFile>>();
  final isRateLoading = RxMap<OrderProduct, bool>();
  final isRated = RxMap<OrderProduct, bool>();

  void rate(OrderProduct product) async {
    try {
      isRateLoading[product] = true;
      final request = RatingRequest(
        videos: medias[product]?.where((file) => lookupMimeType(file.path)?.startsWith("image/") == false).toList() ?? [], 
        photos: medias[product]?.where((file) => lookupMimeType(file.path)?.startsWith("image/") == true).toList() ?? [], 
        text: notes[product] ?? "",
        productId: product.productId ?? "", 
        rating: ratings[product].toString(), 
        orderId: orderId
      );
      await _repository.rate(request);
      isRateLoading[product] = false;
      isRated[product] = true;
      Get.showSnackbar(
        const GetSnackBar(
          message: "Berhasil memberi penilaian untuk produk ini",
          duration: Duration(seconds: 2),
        )
      );

    } catch (error) {
      isRateLoading[product] = false;
      Get.showSnackbar(GetSnackBar(
          message: error is DioException ? error.response?.data["error"].toString() : "Terjadi kesalahan. Silakan coba lagi",
          duration: const Duration(seconds: 3),
        ));
    }
  }

  void deleteMedia(OrderProduct product, int index) {
    final productMedias = medias[product] ?? [];
    productMedias.removeAt(index);
    medias[product] = productMedias;
    
  }
}