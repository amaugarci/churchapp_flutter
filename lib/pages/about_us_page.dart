import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../models_providers/theme_provider.dart';

class AboutUsPage extends StatefulWidget {
  AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('About us', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Text('Change Theme'),
            trailing: RotatedBox(child: Icon(Icons.arrow_forward_ios, size: 18), quarterTurns: 1),
            onTap: () => _showGetDialogTheme(themeProvider),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              'We are living proof, because we are Living Truth. The Word of God is our authority in making excellent choices for everyday living.',
              style: TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              'We believe that we must apply the truth of God’s Word to our lives and that our lives must reflect God’s love and should also reflect His blessings, His miracles, signs and wonders.',
              style: TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              'We are a bible-teaching, bible-believing ministry dedicated to seeking the best God has for His people through excellence in ministry. Join us for Worship … your life will never, ever be the same.',
              style: TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              'Learn more about who we are and what we’re all about through the links below…',
              style: TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }

  void _showGetDialogTheme(ThemeProvider themeProvider) {
    Get.bottomSheet(Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              themeProvider.themeMode = ThemeMode.light;
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Text('Light Theme', style: TextStyle(color: Colors.black)),
                  Spacer(),
                  Icon(FontAwesome.sun_o, color: Colors.black),
                ],
              ),
            ),
          ),
          Divider(height: 0),
          GestureDetector(
            onTap: () {
              themeProvider.themeMode = ThemeMode.dark;
              Navigator.pop(context);
            },
            child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(children: [
                  Text(
                    'Dart Theme',
                    style: TextStyle(color: Colors.black),
                  ),
                  Spacer(),
                  Icon(FontAwesome5.moon, color: Colors.black)
                ])),
          ),
          Divider(height: 0),
          GestureDetector(
            onTap: () {
              themeProvider.themeMode = ThemeMode.system;
              Navigator.pop(context);
            },
            child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(children: [
                  Text(
                    'System Theme',
                    style: TextStyle(color: Colors.black),
                  ),
                  Spacer(),
                  Icon(AntDesign.setting, color: Colors.black)
                ])),
          ),
          if (Platform.isIOS) SizedBox(height: 10)
        ],
      ),
    ));
  }
}
