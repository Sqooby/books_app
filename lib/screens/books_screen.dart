import 'package:books_app/models/collection.dart';
import 'package:books_app/providers/books_provider.dart';
import 'package:books_app/widgets/app_bar.dart';
import 'package:books_app/widgets/book_cover.dart';

import 'package:books_app/widgets/books_widget.dart';
import 'package:books_app/widgets/bottom_navigation_bar.dart';
import 'package:books_app/widgets/cache_infomation.dart';
import 'package:books_app/widgets/fav_books_widget.dart';
import 'package:books_app/widgets/filter_dialog.dart';
import 'package:books_app/widgets/list_label.dart';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:books_app/generated/l10n.dart';

class BooksScreen extends StatelessWidget {
  static String routeName = '/books';

  const BooksScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final collection =
        ModalRoute.of(context)?.settings.arguments as Collection?;
    return ChangeNotifierProvider(
      create: (context) => BooksProvider(),
      child: Scaffold(
        appBar: AppBarWidget(text: collection?.title ?? '', action: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          final provider = context.read<BooksProvider>();
                          return FilterDialogContent(
                            query: provider.query,
                            sortType: provider.sortType,
                            onSaved: provider.changeFilters,
                          );
                        });
                  },
                  icon: const Icon(Icons.filter_alt_outlined));
            }),
          ),
        ]),
        bottomNavigationBar: BottomNavBar(),
        body: BooksContent(
          url: collection?.href ?? '',
        ),
      ),
    );
  }
}

class BooksContent extends StatefulWidget {
  final String url;
  const BooksContent({super.key, required this.url});

  @override
  State<BooksContent> createState() => _BooksContentState();
}

class _BooksContentState extends State<BooksContent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BooksProvider>().fetchBooks(widget.url);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BooksProvider>(
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
                  S.of(context).notDownData,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                    onPressed: () {
                      provider.fetchBooks(widget.url);
                    },
                    child: Text(S.of(context).loadAgain)),
              ],
            ),
          );
        }

        return Stack(
          children: [
            ListView.separated(
                separatorBuilder: (context, index) {
                  if (index == 0) {
                    return const SizedBox.shrink();
                  }
                  return const Divider();
                },
                itemCount: provider.books.length + 1,
                padding: provider.isCache
                    ? const EdgeInsets.only(bottom: 30)
                    : null, //ZMIENIC WYSOKOŚĆ
                itemBuilder: (context, index) {
                  if (index == 0) {
                    if (provider.listFavourite.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListLabel(text: S.of(context).favourites),
                        SizedBox(
                          height: BookCover.coverHeight,
                          child: PageView.builder(
                            controller: provider.controller,
                            onPageChanged: (value) => provider.favIndex = value,
                            itemCount: provider.listFavourite.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (contex, index) {
                              return SizedBox(
                                width: 400,
                                child: FavBooks(
                                  book: provider.listFavourite[index],
                                ),
                              );
                            },
                          ),
                        ),
                        Selector<BooksProvider, int>(
                          selector: (context, provider) {
                            return provider.favIndex;
                          },
                          builder: (context, favIndeks, _) {
                            return Center(
                              child: DotsIndicator(
                                dotsCount: provider.listFavourite.length,
                                position: favIndeks.toDouble(),
                                decorator: DotsDecorator(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  size: const Size(18.0, 9.0),
                                  activeSize: const Size(18.0, 9.0),
                                  activeShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            );
                          },
                        ),
                        ListLabel(text: S.of(context).remaining),
                      ],
                    );
                  }

                  final book = provider.books[index - 1];
                  return BooksWidget(
                    book: book,
                  );
                }),
            if (provider.isCache) ...[
              CacheInformation(
                  onPressed: () => provider.fetchBooks(widget.url)),
            ]
          ],
        );
      },
    );
  }
}
