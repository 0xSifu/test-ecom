import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/login/login_response.dart';
import 'package:ufo_elektronika/screens/webview/webview_screen.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/layouts/default_layout.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LiveChatScreen extends StatefulWidget {
  static const routeName = "/live-chat";
  const LiveChatScreen({super.key});

  @override
  State<LiveChatScreen> createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  late final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  double progressValue = 0;
  bool runOnce = false;

  @override
  void initState() {
    super.initState();
    LoginResponse.listenToLoginDataChanged(Get.find(), (loginResponse) {
        if (loginResponse != null) {
          controller.loadRequest(Uri.parse("https://www.ufoelektronika.com/index.php?route=common/tawkto&customer_id=${loginResponse.data?.customerId}"));
        } else {
          controller.loadRequest(Uri.parse("https://tawk.to/chat/594b89f6e9c6d324a4736c10/default"));
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (runOnce == false) {
      runOnce = true;
      controller.setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint(url);
            setState(() {
              progressValue = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              progressValue = progress / 100;
            });
          },
          onPageFinished: (url) async {
            progressValue = 1;
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint(request.url);
            return NavigationDecision.navigate;
          },
        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        appBar: const UEAppBar(
          title: 'LIVE CHAT',
          showCart: false,
          showNotification: false
        ),
        body: Column(
          children: [
            if (progressValue < 1.0) 
              LinearProgressIndicator(
                value: progressValue,
                backgroundColor: Colors.grey[200],
                minHeight: 2,
                valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColor.primaryColor),
              ),
            Expanded(
              child: WebViewWidget(controller: controller),
            )
          ],
        ),
      ),
    );
  }
}
