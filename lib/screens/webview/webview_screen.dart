import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/webview/webview_controller.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/layouts/default_layout.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends GetView<WebviewController> {
  static const routeName = "/webview";
  final String? title;
  final String url;
  const WebViewScreen({
    super.key,
    this.title,
    required this.url
  });

  @override
  Widget build(BuildContext context) {
    controller.webViewController.loadRequest(Uri.parse(url));
    return Obx(() => Scaffold(
      appBar: UEAppBar(
        title: title ?? '',
        showCart: false,
        showNotification: false,
        onBackClicked: () async {
          if (await controller.canGoBack) {
            controller.goBack();
          } else {
            Get.back();
          }
        },
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: controller.progressValue.value == 1
              ? Container()
              : LinearProgressIndicator(
                  value: controller.progressValue.value,
                  backgroundColor: Colors.grey[200],
                  minHeight: 2,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColor.primaryColor),
                ),
        ),
      ),
      body: DefaultLayout(
        child: WebViewWidget(controller: controller.webViewController),
      ),
    ));
  }
}
