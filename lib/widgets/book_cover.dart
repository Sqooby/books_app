import 'package:books_app/models/book.dart';
import 'package:books_app/providers/books_provider.dart';
import 'package:books_app/widgets/fav_button.dart';
import 'package:books_app/widgets/image_placeholder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookCover extends StatelessWidget {
  final Book book;

  const BookCover({super.key, required this.book});
  static const coverWidth = 360 * .35;
  static const coverHeight = 500 * .35;

  void _toggleFavourite(BuildContext context) {
    context.read<BooksProvider>().toggleFavourite(book);
  }

  @override
  Widget build(BuildContext context) {
    bool isFav = context.read<BooksProvider>().checkFav(book);
    return Stack(
      children: [
        SizedBox(
          height: coverHeight,
          width: coverWidth,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: book.coverThumb,
              placeholder: (_, __) => const ImagePlaceholder(),
              errorWidget: (_, __, ___) => const Icon(Icons.error),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
                color: const Color(0xFFF88501),
                child: FavButton(
                  isFav: isFav,
                  toggleFav: () => _toggleFavourite,
                )),
          ),
        ),
      ],
    );
  }
}
