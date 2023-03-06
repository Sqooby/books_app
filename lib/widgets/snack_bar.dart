import 'package:books_app/models/collection.dart';
import 'package:books_app/providers/collections_provider.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SnackBarWidget extends StatelessWidget {
  const SnackBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _isCache = context.read<CollectionsProvider>().isCache;
    return _isCache
        ? SnackBar(
            content: const Text(
              'Nie masz połączenia z internetem, działasz na pobranych kolekcjach',
            ),
            action: (SnackBarAction(
              label: 'Przywróć połączenie',
              onPressed: () {},
            )),
          )
        : SnackBar(
            content: const Text(
              'Nie masz połączenia z internetem, działasz na pobranych kolekcjach',
            ),
            action: (SnackBarAction(
              label: 'Przywróć połączenie',
              onPressed: () {},
            )));
  }
}
