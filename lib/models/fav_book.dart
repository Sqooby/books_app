import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'book.dart';

part 'fav_book.g.dart';

@JsonSerializable()
class FavBooks {
  final Map<String, List<Book>> favs;

  Future<void> init() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    final String? favsString = prefs.getString('favs');
    if (favsString == null) {
      return;
    }
    final Map<String, dynamic> json = jsonDecode(favsString);
    final result = FavBooks.fromJson(json);
    favs.addAll(result.favs);
  }

  void add(String url, Book book) {
    if (!favs.containsKey(url)) {
      favs[url] = [];
    }
    favs[url]?.add(book);
    _save();
  }

  void delete(String url, Book book) {
    favs[url]?.remove(book);
    _save();
  }

  bool checkBook(String url, Book book) {
    return favs[url]?.contains(book) ?? false;
  }

  List<Book> getBooks(String url) {
    return favs[url] ?? [];
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final json = toJson();
    final result = jsonEncode(json);
    await prefs.setString('favs', result);
  }

  FavBooks({required this.favs});
  factory FavBooks.fromJson(Map<String, dynamic> json) =>
      _$FavBooksFromJson(json);
  Map<String, dynamic> toJson() => _$FavBooksToJson(this);
}
