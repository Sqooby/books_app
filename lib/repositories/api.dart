import 'package:books_app/models/book_detail_response.dart';
import 'package:books_app/models/books_response.dart';
import 'package:books_app/models/collection.dart';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api.g.dart';

@RestApi(baseUrl: 'https://wolnelektury.pl/api/')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('{href}')
  Future<BookDetailResponse> getBookDetail(
    @Path('href') String href,
  );

  @GET('{url}')
  Future<BooksResponse> getBooks(
    @Path('url') String url,
  );
  @GET("collections/")
  Future<List<Collection>> getCollections();
}
