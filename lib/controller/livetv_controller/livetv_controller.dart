import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart'; // General WebView import

class LivetvController extends GetxController {
  var isLoading = false.obs;
  WebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    // Initialize WebViewController
    webViewController = WebViewController();

    // Set platform-specific parameters if needed
    if (GetPlatform.isAndroid) {
      webViewController?.setJavaScriptMode(JavaScriptMode.unrestricted);
      webViewController?.setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Handle loading progress
          },
          onPageStarted: onPageStarted,
          onPageFinished: onPageFinished,
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      );
    } else if (GetPlatform.isIOS || GetPlatform.isMacOS) {
      webViewController?.setJavaScriptMode(JavaScriptMode.unrestricted);
      webViewController?.setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Handle loading progress
          },
          onPageStarted: onPageStarted,
          onPageFinished: onPageFinished,
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      );
    }
    // Optionally, load a URL initially
    webViewController?.loadRequest(Uri.parse('https://www.apintie.sr/tv'));
  }

  void onPageStarted(String url) {
    isLoading.value = true;
  }

  void onPageFinished(String url) {
    isLoading.value = false;

  }
}
