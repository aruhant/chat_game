import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat-game/models/catalog.dart';

final catalogProvider = FutureProvider<Catalog>((ref) async {
  return Catalog.fromJsonString(
      await rootBundle.loadString('assets/BooksDB.json'));
});
