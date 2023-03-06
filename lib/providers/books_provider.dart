import 'package:books_app/models/book.dart';
import 'package:books_app/models/books_response.dart';
import 'package:books_app/models/fav_book.dart';
import 'package:books_app/repositories/api.dart';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class BooksProvider with ChangeNotifier {
  late BooksResponse? _response;
  BooksResponse? get response => _response;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final bool _isLiked = false;
  bool get isLiked => _isLiked;

  int _favIndex = 0;
  int get favIndex => _favIndex;

  bool _isCache = false;
  bool get isCache => _isCache;

  set favIndex(int value) {
    _favIndex = value < 0 ? 0 : value;
    notifyListeners();
  }

  // late final List _listFavourite = [];
  List get listFavourite {
    return GetIt.I.get<FavBooks>().getBooks(_url);
  }

  late final String _href;
  String get href => _href;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _query = '';
  String get query => _query;

  SortType _sortType = SortType.none;

  SortType get sortType => _sortType;

  void changeFilters(String query, SortType type) {
    _query = query;
    _sortType = type;
    notifyListeners();
  }

  late String _url;

  late final PageController controller = PageController(initialPage: 0);

  List<Book> get books {
    final _books = (_response?.books ?? [])
        .where((element) =>
            !listFavourite.contains(element) &&
            (element.author.toLowerCase().contains(_query.toLowerCase()) ||
                element.title.toLowerCase().contains(_query.toLowerCase())))
        .toList();

    switch (_sortType) {
      case SortType.authorAsc:
        _books.sort((a, b) => a.author.compareTo(b.author));
        break;
      case SortType.authorDesc:
        _books.sort((a, b) => b.author.compareTo(a.author));

        break;
      case SortType.titleDesc:
        _books.sort((a, b) => b.title.compareTo(a.title));
        break;
      case SortType.titleAsc:
        _books.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortType.none:
    }
    return _books;
  }

  Future<void> fetchBooks(String url) async {
    _url = url;
    _errorMessage = null;
    _isLoading = true;
    _isCache = false;
    notifyListeners();

    try {
      // throw Exception();
      final dio = Dio();
      dio.options.connectTimeout = 5000;
      dio.options.receiveTimeout = 5000;
      _response = await ApiClient(dio).getBooks(url);
      await _response?.save(url);
    } catch (e, stackTrace) {
      _response = await BooksResponse.load(url);
      if (_response == null) {
        _errorMessage = "Nie udalo się pobrać danych";
      }
      _isCache = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  void addFavourite(Book book) {
    GetIt.I.get<FavBooks>().add(_url, book);
    notifyListeners();
  }

  void deleteFavourite(Book book) {
    if (listFavourite.length == _favIndex + 1) {
      controller.jumpToPage(_favIndex);
      favIndex = _favIndex - 1;
    }
    GetIt.I.get<FavBooks>().delete(_url, book);

    notifyListeners();
  }

  bool checkFav(Book book) {
    return GetIt.I.get<FavBooks>().checkBook(_url, book);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggleFavourite(Book book) {
    if (checkFav(book)) {
      deleteFavourite(book);

      return;
    }
    addFavourite(book);
  }

  List<Book> search(String query) {
    if (query.isEmpty) {
      return books;
    }
    return books.where((element) => element.title.contains(query)).toList();
  }
}

enum SortType { none, authorAsc, authorDesc, titleAsc, titleDesc }
