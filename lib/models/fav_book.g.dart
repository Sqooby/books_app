// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavBooks _$FavBooksFromJson(Map<String, dynamic> json) => FavBooks(
      favs: (json['favs'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => Book.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$FavBooksToJson(FavBooks instance) => <String, dynamic>{
      'favs': instance.favs,
    };
