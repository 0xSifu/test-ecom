import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewController extends GetxController {
  final webViewController = WebViewController();
  final progressValue = 0.0.obs;

  Future<bool> get canGoBack => webViewController.canGoBack();
  void goBack() {
    webViewController.goBack();
  }

  @override
  void onInit() {
    super.onInit();
    
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint(url);
            progressValue.value = 0;
          },
          onProgress: (progress) {
            progressValue.value = progress / 100;
          },
          onPageFinished: (url) {
            progressValue.value = 1;
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint(request.url);
            return NavigationDecision.navigate;
          },
        ),
      );
      
//       ..loadHtmlString("""<!DOCTYPE html>
// <html lang="en">
//   <head>
//     <meta charset="UTF-8" />
//     <meta name="viewport" content="width=device-width, initial-scale=1.0" />
//     <title>Document</title>
//   </head>
//   <body>
//     <script type="text/javascript">
//           var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
//           (function(){
//           var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
//             s1.async=true;
//             s1.src='https://embed.tawk.to/594b89f6e9c6d324a4736c10/default';
//             s1.charset='UTF-8';
//             s1.setAttribute('crossorigin','*');
//             s0.parentNode.insertBefore(s1,s0);
//           })();
//           Tawk_API.customStyle = {
//             visibility: {
//               //for desktop only
//               desktop: {
//                 position: 'br', // bottom-right
//                 xOffset: 30, // 15px away from right
//                 yOffset: 0 // 40px up from bottom
//               },
//               // for mobile only
//               mobile: {
//                 position: 'br', // bottom-right
//                 xOffset: 5, // 5px away from right
//                 yOffset: 10, // 50px up from bottom

//               },
//               // change settings of bubble if necessary
//               bubble: {
//                 rotate: '0deg',
//                 xOffset:  30,
//                 yOffset: 0
//               }
//             }
//           }


//           </script>
//   </body>
// </html>""", baseUrl: "https://www.ufoelektronika.com/")
  }

  void loadUrl(String url) {
    if (url.isEmpty) return;
    webViewController.loadRequest(Uri.parse(url));
  }

}