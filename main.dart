import 'package:books_app/screens/books_screen.dart';
import 'package:books_app/screens/collections_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
//try catch

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const CollectionsScreen(),
      routes: {
        '/books': (context) => const BooksScreen(),
      },
    );
  }
}
