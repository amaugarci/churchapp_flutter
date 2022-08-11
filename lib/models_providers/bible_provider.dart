import 'dart:async';

import 'package:flutter/material.dart';

import '../models/bible.dart';
import '../models_services/bible_service.dart';

class BibleProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future initState() async {
    fetchBibleBooks();
    getBibleLanguages();
    getBibleBookVersesFavorites();
  }

  List<String> _biblebooks = [];
  List<String> get bibleBooks => _biblebooks;

  List<BibleChapter> _bibleChapters = [];
  List<BibleChapter> get bibleChapters => _bibleChapters;

  List<BibleVerse> _bibleVerses = [];
  List<BibleVerse> get bibleVerses => _bibleVerses;

  List<BibleVerse> _bibleVersesFavorites = [];
  List<BibleVerse> get bibleVersesFavorites => _bibleVersesFavorites;

  List<String> _bibleLanguages = [];
  List<String> get bibleLanguages => _bibleLanguages;

  String _language = 'English';
  String get language => _language;

  set language(String language) {
    _language = language;
    fetchBibleBooks();
    notifyListeners();
  }

  Future getBibleLanguages() async {
    _bibleLanguages = await BibleService.getBibleLanguages();
    notifyListeners();
  }

  Future fetchBibleBooks() async {
    _biblebooks = await BibleService.getBibleBooks(language: _language);
    notifyListeners();
  }

  Future getBibleBookChapters({required String book}) async {
    _bibleChapters = await BibleService.getBibleBookChapters(book: book, language: _language);
    _bibleChapters.sort((a, b) => a.chapter.compareTo(b.chapter));
    notifyListeners();
  }

  Future getBibleBookVerses({required String book, required int chapter}) async {
    _bibleVerses = await BibleService.getBibleBookVerses(book: book, chapter: chapter, language: _language);
    _bibleVerses.sort((a, b) => a.verse.compareTo(b.verse));
    notifyListeners();
  }

  Future getBibleBookVersesFavorites() async {
    _bibleVersesFavorites = await BibleService.getBibleBookVersesFavorites(language: _language);
    notifyListeners();
  }

  Future toggleFavoriteVerse({required BibleVerse bibleVerse}) async {
    await BibleService.toggleFavoriteVerse(bibleVerse: bibleVerse);
    getBibleBookVersesFavorites();
    notifyListeners();
  }
}
