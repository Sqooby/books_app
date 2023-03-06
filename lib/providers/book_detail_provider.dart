import 'package:books_app/models/book_detail_response.dart';
import 'package:books_app/repositories/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BookDetailProvider with ChangeNotifier {
  BookDetailResponse? _response;
  BookDetailResponse? get reponse => _response;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isCache = false;
  bool get isCache => _isCache;

  Future<void> fetchBookDetail(String url) async {
    _errorMessage = null;
    _isLoading = true;
    _isCache = false;
    notifyListeners();

    try {
      final dio = Dio();
      dio.options.connectTimeout = 5000;
      dio.options.receiveTimeout = 5000;
      _response = await ApiClient(dio).getBookDetail(url);

      await _response?.save(url);
    } catch (e) {
      _response = await BookDetailResponse.load(url);
      if (_response == null) {
        _errorMessage = "Nie udalo się pobrać danych";
      }
      _isCache = true;
    }

    _isLoading = false;
    notifyListeners();
  }
}
