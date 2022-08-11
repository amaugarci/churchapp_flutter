import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thebibleapp/_constants.dart';
import 'package:thebibleapp/components/z_card.dart';
import 'package:thebibleapp/pages/hymns/hymns_page.dart';
import 'package:thebibleapp/pages/locations_page.dart';
import 'package:thebibleapp/pages/notifications_page.dart';
import 'package:thebibleapp/pages/prayer/prayer_request_page.dart';
import 'package:thebibleapp/utils/launch_url.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final VideoPlayerController videoPlayerController =
      VideoPlayerController.asset("assets/church.mp4");

  ChewieController? chewieController;
  @override
  void initState() {
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 9 / 20,
      autoPlay: true,
      looping: true,
      autoInitialize: true,
      showControls: false,
    );
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(appName, style: TextStyle(fontWeight: FontWeight.w500))),
      body: ListView(
        children: [
          buildCard(
              image: 'assets/images/ofrenda.jpg',
              label: 'Donate',
              onTap: () => launchUrl(donationUrl)),
          buildCard(
              image: 'assets/prayers.jpg',
              label: 'Prayer request',
              onTap: () => Get.to(() => PrayerRequestPage())),
          buildCard(
              image: 'assets/images/choir.jpg',
              label: 'Hymns',
              onTap: () => Get.to(() => HymnsPage())),
          buildCard(
              image: 'assets/images/geo.jpg',
              label: 'Locations',
              onTap: () => Get.to(() => LocationsPage())),
          buildCard(
              image: 'assets/images/not.jpg',
              label: 'Notifications',
              onTap: () => Get.to(() => NotificationsPage())),
        ],
      ),
    );
  }

  buildCard(
      {required String image,
      required String label,
      required GestureTapCallback onTap}) {
    return ZCard(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        padding: EdgeInsets.all(0),
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.cover))),
            ZCard(
              child: Text(label,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white)),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              color: Color(0xFF1F2630),
            )
          ],
        ));
  }
}
