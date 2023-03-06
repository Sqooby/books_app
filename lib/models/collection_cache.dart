import 'dart:convert';

import 'package:books_app/models/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'collection_cache.g.dart';

@JsonSerializable()
class CollectionCache {
  final List<Collection> collections;

  CollectionCache({required this.collections});

  factory CollectionCache.fromJson(Map<String, dynamic> json) =>
      _$CollectionCacheFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionCacheToJson(this);

  static Future<void> save(List<Collection> collections) async {
    final prefs = await SharedPreferences.getInstance();

    final json = CollectionCache(collections: collections).toJson();
    final string = jsonEncode(json);
    await prefs.setString('collectionCache', string);
  }

  static Future<List<Collection>> load() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('collectionCache')) {
      return [];
    }

    final string = prefs.getString('collectionCache');

    if (string == null) {
      return [];
    }

    final json = jsonDecode(string);
    final result = CollectionCache.fromJson(json);
    return result.collections;
  }
}
