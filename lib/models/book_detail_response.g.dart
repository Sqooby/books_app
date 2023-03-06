// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookDetailResponse _$BookDetailResponseFromJson(Map<String, dynamic> json) =>
    BookDetailResponse(
      url: json['url'] as String,
      title: json['title'] as String,
      fragmentData: BookDetailFragment.fromJson(
          json['fragment_data'] as Map<String, dynamic>),
      children: (json['children'] as List<dynamic>)
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
      epochs: (json['epochs'] as List<dynamic>)
          .map((e) => BookDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      kinds: (json['kinds'] as List<dynamic>)
          .map((e) => BookDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      authors: (json['authors'] as List<dynamic>)
          .map((e) => BookDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      genres: (json['genres'] as List<dynamic>)
          .map((e) => BookDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      simpleThumb: json['simple_thumb'] as String,
      pdf: json['pdf'] as String,
      html: json['html'] as String,
    );

Map<String, dynamic> _$BookDetailResponseToJson(BookDetailResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'fragment_data': instance.fragmentData,
      'children': instance.children,
      'epochs': instance.epochs,
      'kinds': instance.kinds,
      'authors': instance.authors,
      'genres': instance.genres,
      'simple_thumb': instance.simpleThumb,
      'url': instance.url,
      'pdf': instance.pdf,
      'html': instance.html,
    };
