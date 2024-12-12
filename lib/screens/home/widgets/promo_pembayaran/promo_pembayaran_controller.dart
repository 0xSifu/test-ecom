import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/home/repositories/home_repository.dart';
import 'package:ufo_elektronika/screens/home/widgets/promo_pembayaran/promo_pembayaran_response.dart';
import 'package:ufo_elektronika/shared/utils/state_controller.dart';

class PromoPembayaranController extends StateController<PromoPembayaranResponse> {
  final HomeRepository _repository;
  PromoPembayaranController({required HomeRepository repository}): _repository = repository;
  final scrollController = ScrollController();
  final currentOffset = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    futurize(_repository.loadPromoPembayaran);
    scrollController.addListener(() {
      currentOffset.value = scrollController.offset;
    });
  }

}