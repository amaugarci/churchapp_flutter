import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:thebibleapp/components/z_bible_verse.dart';
import 'package:thebibleapp/models/bible.dart';

import 'package:thebibleapp/models_providers/ads_provider.dart';
import 'package:thebibleapp/models_providers/bible_provider.dart';

class UserBibleVersesPage extends StatefulWidget {
  final String title;
  UserBibleVersesPage({Key? key, required this.title}) : super(key: key);

  @override
  _UserBibleVersesPageState createState() => _UserBibleVersesPageState();
}

class _UserBibleVersesPageState extends State<UserBibleVersesPage> {
  List<Object> itemList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adsProvider = Provider.of<AdsProvider>(context);
    itemList = List.from(Provider.of<BibleProvider>(context).bibleVerses);

    if (adsProvider.initializationStatus != null) {
      for (int i = adsProvider.listBannerAdInterval; i <= itemList.length; i += adsProvider.listBannerAdInterval + 1) {
        itemList.insert(
            i,
            BannerAd(
              size: AdSize.banner,
              adUnitId: adsProvider.bannerAdUnitId,
              listener: adsProvider.listener,
              request: AdRequest(),
            )..load());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.title}', style: TextStyle(fontWeight: FontWeight.w600))),
      body: ListView(children: <Widget>[for (var ob in itemList) getItem(ob)]),
    );
  }

  getItem(Object ob) {
    if (ob is BibleVerse) return ZBibleVerse(verse: ob);
    if (ob is AdWithView) return Container(margin: EdgeInsets.symmetric(vertical: 8), height: 50, child: AdWidget(ad: ob));
    return Container();
  }
}
