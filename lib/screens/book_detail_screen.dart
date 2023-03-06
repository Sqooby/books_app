import 'dart:ui';

import 'package:books_app/models/book.dart';
import 'package:books_app/generated/l10n.dart';

import 'package:books_app/providers/book_detail_provider.dart';

import 'package:books_app/screens/reader_screen.dart';

import 'package:books_app/widgets/author_book.dart';
import 'package:books_app/widgets/book_cover.dart';

import 'package:books_app/widgets/bottom_navigation_bar.dart';
import 'package:books_app/widgets/cache_infomation.dart';
import 'package:books_app/widgets/fav_books_widget.dart';

import 'package:books_app/widgets/image_placeholder.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fl_downloader/fl_downloader.dart';

class BookDetailScreen extends StatelessWidget {
  static String routeName = '/book_detail_screen';

  const BookDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final bookDetail = ModalRoute.of(context)?.settings.arguments as Book?;

    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: (context) => BookDetailProvider(),
          child: BookDetailContent(url: bookDetail?.href ?? ''),
        ),
      ),
    );
  }
}

class BookDetailContent extends StatefulWidget {
  final String url;
  const BookDetailContent({super.key, required this.url});

  @override
  State<BookDetailContent> createState() => _BookDetailContentState();
}

class _BookDetailContentState extends State<BookDetailContent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BookDetailProvider>().fetchBookDetail(widget.url);
    });
    FlDownloader.initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final width = MediaQuery.of(context).size.width;
    final provider = context.watch<BookDetailProvider>();

    final bookDetail = provider.reponse;
    return Consumer<BookDetailProvider>(builder: (context, provider, _) {
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
              const SizedBox(
                height: 100,
              ),
              Text(
                S.of(context).notDownData,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  provider.fetchBookDetail(widget.url);
                },
                child: Text(S.of(context).loadAgain),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(S.of(context).back),
              ),
            ],
          ),
        );
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: height * .7,
            child: Stack(
              fit: StackFit.loose,
              children: [
                SizedBox(
                  height: height * .65,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                    ),
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: bookDetail?.simpleThumb ?? '',
                          placeholder: (_, __) => const ImagePlaceholder(),
                          errorWidget: (_, __, ___) => const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                        BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 10.0,
                            sigmaY: 10.0,
                          ),
                          child: SafeArea(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: SizedBox(
                                    height: height * .30,
                                    width: width * .30,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                        imageUrl: bookDetail?.simpleThumb ?? '',
                                        placeholder: (_, __) =>
                                            const ImagePlaceholder(),
                                        errorWidget: (_, __, ___) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20.0,
                                    bottom: 50,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        bookDetail?.title ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      AuthorBook(
                                        authors: bookDetail?.authors ?? [],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: -30,
                  height: 60,
                  child: CircleAvatar(
                    radius: 90,
                    backgroundColor: const Color(0xFFFA8502),
                    child: IconButton(
                      icon: const Icon(Icons.star_border_sharp),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                ),
                if (bookDetail?.pdf != '') ...[
                  Positioned(
                    bottom: 20,
                    right: 50,
                    height: 60,
                    child: CircleAvatar(
                      radius: 90,
                      backgroundColor: const Color(0xFFFA8502),
                      child: IconButton(
                        icon: const Icon(Icons.download),
                        color: Colors.white,
                        onPressed: () async {
                          final permission =
                              await FlDownloader.requestPermission();

                          await FlDownloader.download(
                            bookDetail?.pdf ?? '',
                          );
                        },
                      ),
                    ),
                  ),
                ],
                Positioned(
                  top: 20,
                  left: 10,
                  height: 50,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: HtmlWidget(
                    bookDetail?.fragmentData.html ?? '',
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        foregroundColor: Theme.of(context).primaryColor,
                        side: BorderSide(
                          width: 2,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () async {
                        final url = Uri.tryParse(bookDetail?.url ?? '');

                        if (url != null && await canLaunchUrl(url)) {
                          launchUrl(url, mode: LaunchMode.externalApplication);
                        }
                      },
                      child: Text(
                        S.of(context).seemore,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(width: 20),
                    if (bookDetail?.html != '') ...[
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              ReaderScreen.routeName,
                              arguments: bookDetail?.html ?? '');
                        },
                        icon: const Icon(
                          Icons.book_outlined,
                          color: Colors.white,
                        ),
                        label: Text(
                          S.of(context).read,
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (provider.isCache) ...[
            CacheInformation(
                onPressed: () => provider.fetchBookDetail(widget.url)),
          ],
          const SizedBox(height: 20),
          if (bookDetail!.children != 0) ...[
            Text(S.of(context).alsoCheck),
            SizedBox(
              height: 100,
              child: PageView.builder(
                  itemBuilder: ((context, index) {
                    return;
                  }),
                  itemCount: bookDetail.children.length),
            )
          ]
        ],
      );
    });
  }
}
