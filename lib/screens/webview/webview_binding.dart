import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/webview/webview_controller.dart';

class WebViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebviewController());
  }
}