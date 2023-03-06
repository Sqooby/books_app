import 'package:json_annotation/json_annotation.dart';
part 'book_detail_fragment.g.dart';

@JsonSerializable()
class BookDetailFragment {
  final String title;
  final String html;

  BookDetailFragment({required this.title, required this.html});

  factory BookDetailFragment.fromJson(Map<String, dynamic> json) =>
      _$BookDetailFragmentFromJson(json);
  Map<String, dynamic> toJson() => _$BookDetailFragmentToJson(this);
}
