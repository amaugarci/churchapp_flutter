import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:get/get.dart';
import 'package:thebibleapp/components/z_card.dart';
import 'package:thebibleapp/data/hymns.dart';
import 'package:thebibleapp/pages/hymns/hymn_page.dart';

class HymnsPage extends StatefulWidget {
  HymnsPage({Key? key}) : super(key: key);

  @override
  _HymnsPageState createState() => _HymnsPageState();
}

class _HymnsPageState extends State<HymnsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hymns', style: TextStyle(fontWeight: FontWeight.w600))),
      body: ListView(
        children: <Widget>[
          for (var hymn in getHymns())
            ZCard(
                onTap: () => Get.to(() => HymnPage(hymn: hymn)),
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                child: Row(
                  children: [
                    Text(hymn.title, style: TextStyle(fontWeight: FontWeight.w600)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ))
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
