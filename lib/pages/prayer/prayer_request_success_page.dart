import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:thebibleapp/components/z_button.dart';
import 'package:thebibleapp/models_providers/app_provider.dart';

import '../../_navbar_page.dart';

class PrayerRequestSuccessPage extends StatefulWidget {
  PrayerRequestSuccessPage({Key? key}) : super(key: key);

  @override
  _PrayerRequestSuccessPageState createState() => _PrayerRequestSuccessPageState();
}

class _PrayerRequestSuccessPageState extends State<PrayerRequestSuccessPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Message sent!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, height: 1.4, fontWeight: FontWeight.bold),
            ),
          ),
          Center(child: Image.asset('assets/images/success.png', height: 250)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Thanks for your message our team will review and action shortly.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
          ),
          SizedBox(height: 50),
          ZButton(
            margin: EdgeInsets.symmetric(horizontal: 40),
            color: Colors.blue,
            text: 'Back to home',
            onTap: () {
              Provider.of<AppProvider>(context, listen: false).setSelectedPageIndex = 0;
              Get.offAll(() => NavbarPage());
            },
          )
        ],
      ),
    );
  }
}
