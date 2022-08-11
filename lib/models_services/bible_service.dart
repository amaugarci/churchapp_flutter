import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/bible.dart';

class BibleService {
  static Future<List<String>> getBibleLanguages() async {
    Database db = await DatabaseHelper.database;
    List<Map<String, dynamic>> query = await db.rawQuery('SELECT DISTINCT LANGUAGE FROM BIBLE');
    List<String> result = [];

    query.forEach((element) {
      result.add(element['LANGUAGE']);
    });

    return result;
  }

  static Future<List<String>> getBibleBooks({required String language}) async {
    Database db = await DatabaseHelper.database;
    List<Map<String, dynamic>> query = await db.rawQuery("SELECT DISTINCT BOOK_LONG FROM BIBLE WHERE LANGUAGE = '$language'");
    List<String> result = [];

    query.forEach((element) {
      result.add(element['BOOK_LONG']);
    });

    return result;
  }

  static Future<List<BibleChapter>> getBibleBookChapters({required String language, required String book}) async {
    Database db = await DatabaseHelper.database;
    var query = await db.rawQuery("SELECT DISTINCT CHAPTER FROM BIBLE WHERE BOOK_LONG = '$book' AND LANGUAGE = '$language'");
    List<BibleChapter> bibleChapters = [];

    query.forEach((element) {
      bibleChapters.add(BibleChapter(book: book, chapter: checkInt(element['CHAPTER'])));
    });

    return bibleChapters;
  }

  static Future<List<BibleVerse>> getBibleBookVerses({required String language, required String book, required int chapter}) async {
    Database db = await DatabaseHelper.database;
    var query = await db.rawQuery("SELECT * FROM BIBLE WHERE BOOK_LONG = '$book' AND CHAPTER = '$chapter' AND LANGUAGE = '$language'");
    List<BibleVerse> bibleVerses = [];
    query.forEach((element) {
      bibleVerses.add(BibleVerse(
        book: element['BOOK_LONG'].toString(),
        chapter: checkInt(element['CHAPTER']),
        text: element['TEXT'].toString(),
        verse: checkInt(element['VERSE']),
        id: checkInt(element['ROWID']),
        isFavorite: element['FAVORITE'] == 1 ? true : false,
      ));
    });

    return bibleVerses;
  }

  static Future<List<BibleVerse>> getBibleBookVersesFavorites({required String language}) async {
    Database db = await DatabaseHelper.database;
    var query = await db.rawQuery("SELECT * FROM BIBLE WHERE FAVORITE = 1 AND LANGUAGE = '$language'");
    List<BibleVerse> bibleVerses = [];
    query.forEach((element) {
      bibleVerses.add(BibleVerse(
        book: element['BOOK_LONG'].toString(),
        chapter: checkInt(element['CHAPTER']),
        text: element['TEXT'].toString(),
        verse: checkInt(element['VERSE']),
        id: checkInt(element['ROWID']),
        isFavorite: element['FAVORITE'] == 1 ? true : false,
      ));
    });

    return bibleVerses;
  }

  static toggleFavoriteVerse({required BibleVerse bibleVerse}) async {
    print(bibleVerse.isFavorite);
    bibleVerse.isFavorite = !bibleVerse.isFavorite;
    print(bibleVerse.isFavorite);
    Database db = await DatabaseHelper.database;
    try {
      var res = await db.update('BIBLE', bibleVerse.toMap(), where: "ROWID = ?", whereArgs: [bibleVerse.id]);
      print(res);
    } catch (e) {
      print(e);
    }

    return;
  }
}

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;
  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) _databaseHelper = DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  static Future<Database> get database async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '/holybible3.db';

    if (FileSystemEntity.typeSync(path) != FileSystemEntityType.notFound) {
      _database = await openDatabase(path, version: 1, onOpen: (db) {});
    } else {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  static Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '/holybible3.db';
    ByteData data = await rootBundle.load("assets/databases/holybible3.db");
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);
    var database = await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {});
    return database;
  }
}

checkInt(value) {
  if (value is int) {
    return value;
  }
  if (value is double) {
    return value.toInt();
  }
  if (value is String) {
    return int.parse(value);
  }
  return 0;
}
