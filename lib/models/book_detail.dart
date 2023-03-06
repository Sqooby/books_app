import 'package:json_annotation/json_annotation.dart';
part 'book_detail.g.dart';

@JsonSerializable()
class BookDetail {
  final String href;
  final String name;
  final String url;

  BookDetail({required this.href, required this.name, required this.url});

  factory BookDetail.fromJson(Map<String, dynamic> json) =>
      _$BookDetailFromJson(json);
  Map<String, dynamic> toJson() => _$BookDetailToJson(this);
}
