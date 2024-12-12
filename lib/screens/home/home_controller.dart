import 'package:ufo_elektronika/screens/home/home_state.dart';
import 'package:ufo_elektronika/shared/utils/state_controller.dart';

class HomeController extends StateController<HomeState> {
  
  @override
  void onInit() {
    super.onInit();
    futurize(() async => HomeState(showWhiteAppBar: false), initialData: HomeState(showWhiteAppBar: false));
  }

  void onOffsetChanged(double offset) {
    futurize(() async => HomeState(showWhiteAppBar: offset > 50), initialData: HomeState(showWhiteAppBar: offset > 50));
  }
}