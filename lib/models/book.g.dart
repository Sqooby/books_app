// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      liked: json['liked'] as bool?,
      epoch: json['epoch'] as String,
      genre: json['genre'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      coverThumb: json['cover_thumb'] as String,
      kind: json['kind'] as String,
      href: json['href'] as String,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'author': instance.author,
      'cover_thumb': instance.coverThumb,
      'kind': instance.kind,
      'href': instance.href,
      'title': instance.title,
      'genre': instance.genre,
      'epoch': instance.epoch,
      'liked': instance.liked,
    };
