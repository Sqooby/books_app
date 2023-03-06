import 'package:books_app/models/book.dart';
import 'package:books_app/screens/book_detail_screen.dart';
import 'package:books_app/widgets/book_cover.dart';

import 'package:flutter/material.dart';

class FavBooks extends StatelessWidget {
  final Book book;
  const FavBooks({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    const contentPadding = EdgeInsets.all(10.0);
    final mediaQuery = MediaQuery.of(context);
    final widthScreen = mediaQuery.size.width;
    final paddingScreen = mediaQuery.padding.horizontal;
    final width = widthScreen -
        contentPadding.horizontal -
        paddingScreen -
        BookCover.coverWidth;

    return Padding(
      padding: contentPadding,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(BookDetailScreen.routeName, arguments: book);
        },
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(left: BookCover.coverWidth),
              width: width,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(3, 7),
                    spreadRadius: -32,
                    blurRadius: 49,
                    color: Color.fromRGBO(0, 0, 0, 0.63),
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                      color: Color(0xFF3B3B3B),
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    book.author,
                    style: const TextStyle(
                      color: Color(0XFF7B7B7B),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            BookCover(book: book),
          ],
        ),
      ),
    );
  }
}
