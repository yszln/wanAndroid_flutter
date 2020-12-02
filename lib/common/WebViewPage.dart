import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {

  static toWeb(BuildContext context, String url, String title) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => WebViewPage(url: url, title: title)));
  }

  final String url;
  final String title;

  const WebViewPage({Key key, this.url, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WebViewPageState();
  }

}

class WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body:  WebView(
        initialUrl: widget.url,
      ),
    );
  }

}