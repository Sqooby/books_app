import 'package:books_app/generated/l10n.dart';
import 'package:books_app/providers/collections_provider.dart';
import 'package:books_app/screens/books_screen.dart';
import 'package:books_app/widgets/app_bar.dart';
import 'package:books_app/widgets/bottom_navigation_bar.dart';
import 'package:books_app/widgets/cache_infomation.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CollectionsProvider(),
      child: Scaffold(
        appBar: AppBarWidget(
          text: S.of(context).collections,
          action: const [],
        ),
        body: const CollectionContent(),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}

class CollectionContent extends StatefulWidget {
  const CollectionContent({super.key});

  @override
  State<CollectionContent> createState() => CollectionContentState();
}

class CollectionContentState extends State<CollectionContent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CollectionsProvider>().fetchCollections();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CollectionsProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (provider.errorMessage != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  provider.errorMessage ?? '',
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    provider.fetchCollections();
                  },
                  child: const Text("Załaduj ponownie! "),
                ),
              ],
            ),
          );
        }

        return Stack(
          children: [
            ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: provider.collectionList.length,
              itemBuilder: (context, index) {
                final collection = provider.collectionList[index];
                return ListTile(
                  title: Text(
                    collection.title,
                    style: const TextStyle(
                        color: Color(0xff4C4C4C),
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      BooksScreen.routeName,
                      arguments: collection,
                    );
                  },
                );
              },
            ),
            if (provider.isCache) ...[
              CacheInformation(onPressed: provider.fetchCollections),
            ]
          ],
        );
      },
    );
  }
}
