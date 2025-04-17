// ignore_for_file: must_be_immutable
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../backend/utils/custom_loading_api.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';

class FlutterWebScreen extends StatelessWidget {
  FlutterWebScreen({
    super.key,
  });

  Map<String, dynamic> arguments = Get.arguments;

  late InAppWebViewController webViewController;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    String title = arguments['title'];
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.navigationScreen);
        return false;
      },
      child: Scaffold(
        appBar: PrimaryAppBar(
          title,
          appbarSize: isTablet()
              ? Dimensions.heightSize * 1.8
              : Dimensions.heightSize * 2.5,
        ),
        //PrimaryAppBar(title),
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    String url = arguments['url'];
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(url)),
          onWebViewCreated: (controller) {
            webViewController = controller;
            controller.addJavaScriptHandler(
              handlerName: 'jsHandler',
              callback: (args) {
                // Handle JavaScript messages from WebView
              },
            );
          },
          onLoadStart: (controller, url) {
            isLoading.value = true;
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: isLoading,
          builder: (context, isLoading, _) {
            return isLoading
                ? const Center(child: CustomLoadingAPI())
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}