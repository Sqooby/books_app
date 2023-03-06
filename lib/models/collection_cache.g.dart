// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_cache.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionCache _$CollectionCacheFromJson(Map<String, dynamic> json) =>
    CollectionCache(
      collections: (json['collections'] as List<dynamic>)
          .map((e) => Collection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CollectionCacheToJson(CollectionCache instance) =>
    <String, dynamic>{
      'collections': instance.collections,
    };
