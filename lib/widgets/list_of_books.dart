import 'package:books_app/screens/book_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BooksList extends StatelessWidget {
  final String title;
  final String author;
  final String simpleThumb;
  const BooksList({
    super.key,
    required this.title,
    required this.author,
    required this.simpleThumb,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (() {
        Navigator.of(context).pushNamed(BookDetailScreen.routeName);
      }),
      title: Text(title),
      subtitle: Text(author),
      leading: CachedNetworkImage(
        imageUrl: simpleThumb,
        placeholder: (_, __) => const CircularProgressIndicator(),
        errorWidget: (_, __, ___) => const Icon(Icons.error),
      ),
    );
  }
}
