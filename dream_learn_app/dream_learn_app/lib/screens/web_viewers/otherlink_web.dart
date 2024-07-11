import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OtherLinkbyWeb extends StatelessWidget {
  final String? webLink;
  const OtherLinkbyWeb({required this.webLink, super.key});

  WebViewController? _webViewInit(String url) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    final controller = webLink != null && webLink!.isNotEmpty ? _webViewInit(webLink!) : null;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Other Links'),
        backgroundColor: Colors.blue,
      ),
      body: controller == null
          ? Center(
              child: Text(
                'No Other link in this lecture.',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            )
          : WebViewWidget(controller: controller),
    );
  }
}
