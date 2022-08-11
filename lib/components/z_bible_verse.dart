import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:share/share.dart';

import '../models/bible.dart';
import '../models_providers/bible_provider.dart';
import 'z_card.dart';

class ZBibleVerse extends StatelessWidget {
  const ZBibleVerse({Key? key, required this.verse, this.showBook = false}) : super(key: key);

  final BibleVerse verse;
  final showBook;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<BibleProvider>(context);
    final String value = showBook ? '${verse.book} ch.${verse.chapter}  v.${verse.verse}' : 'Verse — ${verse.verse}';
//     String shareString = """
// ${verse.book} ch.${verse.chapter}  v.${verse.verse}

// ${verse.text}

// TheBibleApp
// """;

    return ZCard(
      // color: isThemeModeLight ? null : Color(0xFF1B2023),
      onDoubleTap: () => userProvider.toggleFavoriteVerse(bibleVerse: verse),
      // onLongPress: () => Share.share(shareString),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    value,
                    // style: TextStyle(color: isThemeModeLight ? null : Color(0xFF7758F9), fontSize: 16, fontWeight: FontWeight.bold),
                  )),
              Spacer(),
              if (verse.isFavorite) Icon(Icons.favorite, size: 14, color: Color(0xFF02A95D)),
            ],
          ),
          Container(padding: EdgeInsets.symmetric(vertical: 10), child: Text('${verse.text}')),
        ],
      ),
    );
  }
}
