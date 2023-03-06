import 'package:books_app/models/book.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
part 'books_response.g.dart';

@JsonSerializable()
class BooksResponse {
  final List<Book> books;
  final String description;
  final String title;

  BooksResponse({
    required this.books,
    required this.description,
    required this.title,
  });

  Future<void> save(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final json = toJson();
    final result = jsonEncode(json);
    await prefs.setString('books_$url', result);
  }

  static Future<BooksResponse?> load(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'books_$url';

    if (!prefs.containsKey(key)) {
      return null;
    }

    final string = prefs.getString(key);

    if (string == null) {
      return null;
    }

    final json = jsonDecode(string);
    return BooksResponse.fromJson(json);
  }

  factory BooksResponse.fromJson(Map<String, dynamic> json) =>
      _$BooksResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BooksResponseToJson(this);
}
