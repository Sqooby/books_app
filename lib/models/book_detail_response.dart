import 'dart:convert';

import 'package:books_app/models/book.dart';
import 'package:books_app/models/book_detail_fragment.dart';
import 'package:books_app/models/book_detail.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'book_detail_response.g.dart';

@JsonSerializable()
class BookDetailResponse {
  final String title;
  @JsonKey(name: 'fragment_data')
  final BookDetailFragment fragmentData;
  final List<Book> children;
  final List<BookDetail> epochs;
  final List<BookDetail> kinds;
  final List<BookDetail> authors;
  final List<BookDetail> genres;
  @JsonKey(name: 'simple_thumb')
  final String simpleThumb;
  final String url;
  final String pdf;
  final String html;

  BookDetailResponse({
    required this.url,
    required this.title,
    required this.fragmentData,
    required this.children,
    required this.epochs,
    required this.kinds,
    required this.authors,
    required this.genres,
    required this.simpleThumb,
    required this.pdf,
    required this.html,
  });

  factory BookDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$BookDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BookDetailResponseToJson(this);

  Future<void> save(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final json = toJson();
    final result = jsonEncode(json);
    await prefs.setString('books_detail_$url', result);
  }

  static Future<BookDetailResponse?> load(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'books_detail_$url';

    if (!prefs.containsKey(key)) {
      return null;
    }

    final string = prefs.getString(key);

    if (string == null) {
      return null;
    }

    final json = jsonDecode(string);

    return BookDetailResponse.fromJson(json);
  }
}
