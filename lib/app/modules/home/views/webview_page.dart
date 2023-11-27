import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/controllers/WebView_Controller.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  WebviewPage({Key? key}) : super(key: key);
  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Coffee')),
      body: WebViewWidget(controller: controller),
    );
  }
}
