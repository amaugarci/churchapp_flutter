import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';

import '../_constants.dart';

const kHtml = podbeanUrl;

class SermonsPage extends StatefulWidget {
  SermonsPage({Key? key}) : super(key: key);

  @override
  _SermonsPageState createState() => _SermonsPageState();
}

class _SermonsPageState extends State<SermonsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text('Sermons', style: TextStyle(fontWeight: FontWeight.w600))),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(1),
            child: HtmlWidget(kHtml, factoryBuilder: () => MyWidgetFactory()),
          ),
        ],
      ),
    );
  }
}

class MyWidgetFactory extends WidgetFactory with WebViewFactory {
  // optional: override getter to configure how WebViews are built
  bool get webViewMediaPlaybackAlwaysAllow => true;
  String? get webViewUserAgent => 'My app';
}
