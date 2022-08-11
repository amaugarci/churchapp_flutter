class BibleVerse {
  String book;
  int chapter;
  int verse;
  String text;
  int id;
  bool isFavorite;

  BibleVerse({
    this.book = '',
    this.chapter = 0,
    this.text = '',
    this.verse = 0,
    this.id = 0,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() => {
        'BOOK_LONG': book,
        'CHAPTER': chapter,
        'TEXT': text,
        'VERSE': verse,
        'ROWID': id,
        'FAVORITE': isFavorite ? 1 : 0,
      };
}

class BibleChapter {
  String book;
  int chapter;

  BibleChapter({
    this.book = '',
    this.chapter = 0,
  });
}
