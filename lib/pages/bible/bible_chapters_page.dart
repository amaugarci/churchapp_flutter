import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../components/z_card.dart';
import '../../models_providers/bible_provider.dart';
import 'bible_verses_page.dart';

class UserBibleChaptersPage extends StatefulWidget {
  final String book;
  UserBibleChaptersPage({Key? key, required this.book}) : super(key: key);

  @override
  _UserBibleChaptersPageState createState() => _UserBibleChaptersPageState();
}

class _UserBibleChaptersPageState extends State<UserBibleChaptersPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<BibleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.book}', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: ListView(
        children: <Widget>[
          for (var chapter in userProvider.bibleChapters)
            ZCard(
              onTap: () {
                userProvider.getBibleBookVerses(book: chapter.book, chapter: chapter.chapter);
                Get.to(() => UserBibleVersesPage(title: '${chapter.book} — Ch. ${chapter.chapter}'), fullscreenDialog: true);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[
                    Text('${chapter.book} — Ch. ${chapter.chapter}'),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 14),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
