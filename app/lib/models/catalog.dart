import 'dart:convert';

import 'book.dart';
import 'story.dart';

class Catalog {
  Catalog({required this.books, required this.stories});
  final List<Book> books;
  final List<Story> stories;
  // load from json
  factory Catalog.fromJsonString(String string) {
    return Catalog(
      books: List<Book>.from(
          json.decode(string)['books'].map((x) => Book.fromJson(x))),
      stories: List<Story>.from(
          json.decode(string)['stories'].map((x) => Story.fromJson(x))),
    );
  }
}
