import 'package:ufo_elektronika/screens/home/entities/banner_main_response.dart';
import 'package:ufo_elektronika/screens/home/repositories/home_repository.dart';
import 'package:ufo_elektronika/shared/utils/state_controller.dart';

class YoutubeLiveController extends StateController<BannerMainResponse> {
  final HomeRepository _repository;
  YoutubeLiveController({required HomeRepository repository}): _repository = repository;
  @override
  void onInit() {
    super.onInit();
    futurize(_repository.loadBannerMain);
  }
}