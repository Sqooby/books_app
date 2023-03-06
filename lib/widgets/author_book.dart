import 'package:books_app/models/book_detail.dart';
import 'package:flutter/material.dart';

class AuthorBook extends StatelessWidget {
  final List<BookDetail> authors;
  const AuthorBook({super.key, required this.authors});

  String authorNames() {
    final result = authors.map((e) => e.name).join(', ');
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'by ${authorNames()}',
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
