import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewerScreen extends StatelessWidget {
  const WebViewerScreen({super.key});

  static const routeName = '/web-view';

  @override
  Widget build(BuildContext context) {
    final url = ModalRoute.of(context)!.settings.arguments as String;
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(url));
    print(url);
    return Scaffold(
        appBar: AppBar(), body: WebViewWidget(controller: controller));
  }
}
