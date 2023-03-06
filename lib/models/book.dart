import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'book.g.dart';

@JsonSerializable()
class Book with EquatableMixin {
  final String author;
  @JsonKey(name: 'cover_thumb')
  final String coverThumb;
  final String kind;
  final String href;
  final String title;
  final String genre;
  final String epoch;
  final bool? liked;

  Book({
    required this.liked,
    required this.epoch,
    required this.genre,
    required this.title,
    required this.author,
    required this.coverThumb,
    required this.kind,
    required this.href,
  });
  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);

  @override
  List<Object?> get props =>
      [liked, epoch, genre, title, author, coverThumb, kind, href];
}
