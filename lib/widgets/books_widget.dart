import 'package:books_app/providers/books_provider.dart';
import 'package:books_app/screens/book_detail_screen.dart';
import 'package:books_app/widgets/book_cover.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';

class BooksWidget extends StatelessWidget {
  final Book book;

  const BooksWidget({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<BooksProvider>();
    final isFav = provider.checkFav(book);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(BookDetailScreen.routeName, arguments: book);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BookCover(book: book),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 40,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              BookKind(text: book.genre),
                              const SizedBox(
                                width: 10,
                              ),
                              BookKind(text: book.kind),
                              const SizedBox(
                                width: 10,
                              ),
                              BookKind(text: book.epoch),
                            ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BookKind extends StatelessWidget {
  final String text;
  const BookKind({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
