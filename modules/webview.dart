import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
 String url;

   WebViewScreen(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          initialValue: url,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back , color: Colors.black,),
          onPressed: ()
          {
            Navigator.pop(context);
          },
        ),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        allowsInlineMediaPlayback: true,
        initialUrl: url,
        onWebViewCreated: (controller)
        {

        },
        onPageStarted: (String url)
        {
          this.url = url;
          print('url is :$url');
        },
      ),
    );
  }
}
