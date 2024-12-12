import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ufo_elektronika/providers/cart_provider.dart';
import 'package:ufo_elektronika/screens/compare_product/compare_product_repository.dart';
import 'package:ufo_elektronika/screens/compare_product/compare_product_screen.dart';
import 'package:ufo_elektronika/screens/product/entities/product_detail_response.dart';
import 'package:ufo_elektronika/screens/product/product_repository.dart';
import 'package:ufo_elektronika/shared/utils/state_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ProductController extends StateController<ProductDetailResponse> {
  final ProductRepository _repository;
  final String _productId;
  final CompareProductRepository _compareProductRepository;
  ProductController({
    required ProductRepository repository, 
    required CompareProductRepository compareProductRepository, 
    required String productId
  }): _repository = repository, _compareProductRepository = compareProductRepository, _productId = productId;

  final warrantyChecked = true.obs;
  final optionValues = RxMap<ProductOption, ProductOptionValue>();
  final optionValueErrors = RxMap<ProductOption, String?>();
  final optionValueKeys = RxMap<ProductOption, GlobalKey>();
  final quantity = 1.obs;
  final carouselController = CarouselSliderController();
  final selectedCarouselIndex = 0.obs;
  YoutubePlayerController? youtubePlayerController;
  // late VideoPlayerController videoPlayerController;
  // final videoAspectRatio = 0.0.obs;

  String get finalPrice {
    final price = double.tryParse((state?.special ?? state?.flashSalePrice ?? state?.price ?? "").replaceAll("Rp ", "").replaceAll(".", ""));
    if (price != null) {
      final optionPrice = optionValues.values.where((value) => value.priceOption != null && value.priceOption! > 0).firstOrNull;
      if (optionPrice != null) {
        final thousandFormat = NumberFormat("#,###");
        return "Rp ${thousandFormat.format(optionPrice.priceOption! + price)}";
      }
    }
    return state?.special ?? state?.flashSalePrice ?? state?.price ?? "";
  }

  @override
  void onInit() {
    super.onInit();
    futurize(() => _repository.getProduct(_productId), onFinishLoading: (product) {
      if (product.video?.isNotEmpty == true) {
        // videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(product.video!));
        // videoPlayerController.initialize().then((_) {
        //   videoAspectRatio.value = videoPlayerController.value.aspectRatio;
        // });
        final youtubeId = YoutubePlayer.convertUrlToId(product.video!);
        if (youtubeId != null) {
          youtubePlayerController = YoutubePlayerController(
            initialVideoId: youtubeId,
            flags: const YoutubePlayerFlags(
              mute: false,
              autoPlay: false,
              disableDragSeek: true,
              loop: false,
              isLive: false,
              forceHD: false,
              enableCaption: false,
            )
          );
        }
      }
      for (var element in product.options) {
        optionValueKeys[element] = GlobalKey(debugLabel: element.name);
      }
    });
  }

  bool get eligibleToAddToCart {
    bool eligible = true;
    state?.options.forEach((element) {
      if (optionValues[element] == null) {
        Get.showSnackbar(GetSnackBar(
          message: "${element.name} required",
          duration: const Duration(seconds: 2),
        ));
        optionValueErrors[element] = "${element.name} required";
        eligible = false;
        Scrollable.ensureVisible(optionValueKeys[element]!.currentContext!);
      } else {
        optionValueErrors[element] = null;
      }
    });
    return eligible;
  }

  Future<void> addToCompareProduct() async {
    try {
      await _compareProductRepository.addToCompareProduct(productId: _productId);
      Get.showSnackbar(GetSnackBar(
        message: "Berhasil menambahkan produk untuk dibandingkan",
        duration: const Duration(seconds: 2),
        mainButton: TextButton(
          child: const Text("Lihat"),
          onPressed: () {
            Get.toNamed(CompareProductScreen.routeName);
          },
        ),
      ));
    } catch (error) {
      Get.showSnackbar(const GetSnackBar(
        message: "Terjadi kesalahan. Silakan coba lagi",
        duration: Duration(seconds: 2),
      ));
    }
  }
}