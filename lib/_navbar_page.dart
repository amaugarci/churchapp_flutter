import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thebibleapp/pages/bible/bible_page.dart';
import 'package:thebibleapp/pages/events/events_page.dart';
import 'package:thebibleapp/pages/home_page.dart';
import 'package:thebibleapp/pages/more_page.dart';

import 'package:thebibleapp/pages/sermons_page.dart';

import 'models_providers/app_provider.dart';

class NavbarPage extends StatefulWidget {
  _NavbarPageState createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  int index = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
        body: appPages.elementAt(appProvider.selectedPageIndex),
        bottomNavigationBar: Container(
          height: Platform.isIOS ? 83 : 66,
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            iconSize: 24,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(height: 1.8, fontSize: 8.5),
            unselectedLabelStyle: const TextStyle(height: 1.8, fontSize: 8.7),
            type: BottomNavigationBarType.fixed,
            currentIndex: appProvider.selectedPageIndex,
            onTap: (index) {
              appProvider.setSelectedPageIndex = index;
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.holiday_village, size: 24), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.video_call_sharp, size: 24), label: "Live"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_add_sharp, size: 24),
                  label: "Bible"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_sharp, size: 24),
                  label: "Events"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.explore, size: 24), label: "More"),
            ],
          ),
        ));
  }

  /* ----------------------------- NOTE AppPages ----------------------------- */
  List<Widget> appPages = [
    HomePage(),
    SermonsPage(),
    BiblePage(),
    EventsPage(),
    MorePage(),
  ];
}
