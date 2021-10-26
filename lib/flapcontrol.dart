import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FlapControl extends StatefulWidget {
  FlapControl({Key key}) : super(key: key);

  @override
  _FlapControlState createState() => _FlapControlState();
}

class _FlapControlState extends State<FlapControl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('플랩 컨트롤 페이지')),
      body: SafeArea(
        child: WebView(
          initialUrl: 'http://119.206.148.231:8080',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}