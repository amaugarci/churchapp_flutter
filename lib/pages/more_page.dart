import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:thebibleapp/pages/feedback/feedback_page.dart';

import '../_constants.dart';
import '../components/z_card.dart';
import '../models_providers/theme_provider.dart';
import '../utils/launch_url.dart';

class MorePage extends StatefulWidget {
  MorePage({Key? key}) : super(key: key);

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('More', style: TextStyle(fontWeight: FontWeight.w600))),
      body: ListView(
        children: [
          buildCard(title: 'Change theme', onTap: _changeTheme, icon: Icons.nightlight),
          buildCard(title: 'About us', onTap: () => launchUrl(aboutUsUrl), icon: Icons.more),
          buildCard(title: 'Terms', onTap: () => launchUrl(termsUrl), icon: Icons.text_format_sharp),
          buildCard(title: 'Privacy policy', onTap: () => launchUrl(privacyUrl), icon: Icons.lock),
          buildCard(title: 'Feedback \nWe’d love to hear you', onTap: () => Get.to(() => FeedbackPage()), icon: Icons.feedback),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ZCard(child: Icon(Icons.facebook), onTap: () => launchUrl(facebookUrl)),
              ZCard(child: Icon(AntDesign.instagram), onTap: () => launchUrl(instagramUrl)),
              ZCard(child: Icon(AntDesign.youtube), onTap: () => launchUrl(youtubeUrl)),
              ZCard(child: Icon(AntDesign.twitter), onTap: () => launchUrl(twitterUrl)),
            ],
          )
        ],
      ),
    );
  }

  ZCard buildCard({required String title, required IconData icon, required GestureTapCallback onTap}) {
    return ZCard(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      onTap: onTap,
      child: Row(
        children: [
          ZCard(
            height: 40,
            width: 40,
            margin: EdgeInsets.symmetric(),
            borderRadius: BorderRadius.circular(1000),
            child: Center(child: Icon(icon, size: 20)),
          ),
          SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(height: 1.25))]),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded, size: 18)
        ],
      ),
    );
  }

  _changeTheme() {
    return Get.bottomSheet(Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ZCard(
              margin: EdgeInsets.symmetric(),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              onTap: () {
                Provider.of<ThemeProvider>(context, listen: false).themeMode = ThemeMode.light;
                Get.back();
              },
              child: Row(
                children: [Icon(Icons.wb_sunny_sharp), SizedBox(width: 12), Text('Light theme')],
              )),
          ZCard(
              margin: EdgeInsets.symmetric(),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              onTap: () {
                Provider.of<ThemeProvider>(context, listen: false).themeMode = ThemeMode.dark;
                Get.back();
              },
              child: Row(
                children: [Icon(Icons.nightlight_outlined), SizedBox(width: 8), Text('Dark theme')],
              )),
          ZCard(
              margin: EdgeInsets.symmetric(),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              onTap: () {
                Provider.of<ThemeProvider>(context, listen: false).themeMode = ThemeMode.system;
                Get.back();
              },
              child: Row(
                children: [Icon(Icons.settings), SizedBox(width: 8), Text('System theme')],
              )),
          SizedBox(height: 24)
        ],
      ),
    ));
  }
}
