import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';

import 'package:thebibleapp/data/hymns.dart';

class HymnPage extends StatefulWidget {
  final Hymn hymn;
  HymnPage({Key? key, required this.hymn}) : super(key: key);

  @override
  _HymnPageState createState() => _HymnPageState();
}

class _HymnPageState extends State<HymnPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.hymn.title, style: TextStyle(fontWeight: FontWeight.w600))),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(16),
            child: HtmlWidget(widget.hymn.lyrics, factoryBuilder: () => MyWidgetFactory()),
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
