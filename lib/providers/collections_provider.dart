// ignore_for_file: empty_catches

import 'package:books_app/models/collection.dart';
import 'package:books_app/models/collection_cache.dart';
import 'package:books_app/repositories/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class CollectionsProvider with ChangeNotifier {
  final List<Collection> _collectionList = [];
  List<Collection> get collectionList => _collectionList;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isCache = false;
  bool get isCache => _isCache;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  late String url;

  Future<void> fetchCollections() async {
    _errorMessage = null;
    _isCache = false;
    _isLoading = true;
    notifyListeners();

    List<Collection> collections;

    try {
      final dio = Dio();
      dio.options.connectTimeout = 5000;
      dio.options.receiveTimeout = 5000;
      collections = await ApiClient(dio).getCollections();

      await CollectionCache.save(collections);
    } catch (e) {
      _isCache = true;

      collections = await CollectionCache.load();
    }

    _collectionList.clear();
    _collectionList.addAll(collections);

    _isLoading = false;

    notifyListeners();
  }
}
