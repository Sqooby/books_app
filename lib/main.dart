import 'package:books_app/models/fav_book.dart';

import 'package:books_app/screens/book_detail_screen.dart';
import 'package:books_app/screens/books_screen.dart';
import 'package:books_app/screens/collections_screen.dart';
import 'package:books_app/screens/reader_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final favs = FavBooks(favs: {});
  await favs.init();
  GetIt.I.registerSingleton<FavBooks>(favs);

  runApp(const MyApp());
}
//try catch

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primaryColor: const Color(0xFFFA8502),
        primarySwatch: Colors.amber,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyLarge: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(3, 0),
                  blurRadius: 30,
                  color: Color.fromRGBO(0, 0, 0, 1),
                )
              ],
            ),
            bodySmall: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    offset: Offset(3, 0),
                    blurRadius: 20,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  )
                ]),
            bodyMedium: const TextStyle(
              fontFamily: "Lato",
              letterSpacing: 2,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Color(0xFFFA8502),
            )),
      ),
      home: const CollectionsScreen(),
      routes: {
        '/books': (context) => const BooksScreen(),
        '/book_detail_screen': (context) => const BookDetailScreen(),
        '/reader': (context) => const ReaderScreen(),
      },
    );
  }
}
