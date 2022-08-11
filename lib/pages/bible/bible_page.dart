// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:thebibleapp/components/z_card.dart';
import 'package:thebibleapp/models_providers/bible_provider.dart';
import 'package:thebibleapp/pages/bible/bible_verses_favorites_page.dart';

import 'bible_chapters_page.dart';

class BiblePage extends StatefulWidget {
  BiblePage({Key? key}) : super(key: key);

  @override
  _BiblePageState createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<BibleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bible', style: TextStyle(fontWeight: FontWeight.w600)),
        actions: <Widget>[
          Center(
            child: ZCard(
              child: Text("Favorites"),
              onTap: () => Get.to(() => UserBibleVersesFavoritesPage()),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 8),
          for (var book in userProvider.bibleBooks)
            ZCard(
              onTap: () {
                userProvider.getBibleBookChapters(book: book);
                Get.to(() => UserBibleChaptersPage(book: book), fullscreenDialog: true);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[Text('$book'), Spacer(), Icon(Icons.arrow_forward_ios, size: 14)],
                ),
              ),
            )
        ],
      ),
    );
  }

  // void _showGetDialogTheme(UserProvider userProvider) {
  //   Get.bottomSheet(Container(
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
  //     ),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: [
  //         for (var item in userProvider.bibleLanguages)
  //           GestureDetector(
  //             onTap: () {
  //               userProvider.language = item;
  //               Navigator.pop(context);
  //             },
  //             child: Container(
  //               color: Colors.white,
  //               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  //               child: Row(
  //                 children: [
  //                   Text(item, style: TextStyle(color: Colors.black)),
  //                   Spacer(),
  //                   Icon(Icons.book_outlined, color: Colors.black),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         Divider(height: 0),
  //         if (Platform.isIOS) SizedBox(height: 10)
  //       ],
  //     ),
  //   ));
  // }
}
