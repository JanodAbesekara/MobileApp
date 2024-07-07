import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen2 extends StatelessWidget {
  const WebViewScreen2({super.key});

    _webViewInit(){
    final  controller = WebViewController()
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
  ..loadRequest(Uri.parse('https://byte-group-project.vercel.app/knowledgebase'));
  return controller;
    }
  @override
  Widget build(BuildContext context) {
final controller=    _webViewInit();
    return Scaffold(
      appBar: AppBar(
        title:const Text('Classes') ,

      ),
      body:WebViewWidget(controller: controller) ,
    );
  }
}