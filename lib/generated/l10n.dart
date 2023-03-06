// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Collections`
  String get collections {
    return Intl.message(
      'Collections',
      name: 'collections',
      desc: '',
      args: [],
    );
  }

  /// `Favourites`
  String get favourites {
    return Intl.message(
      'Favourites',
      name: 'favourites',
      desc: '',
      args: [],
    );
  }

  /// `Remaining`
  String get remaining {
    return Intl.message(
      'Remaining',
      name: 'remaining',
      desc: '',
      args: [],
    );
  }

  /// `See more`
  String get seemore {
    return Intl.message(
      'See more',
      name: 'seemore',
      desc: '',
      args: [],
    );
  }

  /// `Load Again!`
  String get loadAgain {
    return Intl.message(
      'Load Again!',
      name: 'loadAgain',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `You operate on cache memory`
  String get cacheInfo {
    return Intl.message(
      'You operate on cache memory',
      name: 'cacheInfo',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Search by phrase`
  String get searchByName {
    return Intl.message(
      'Search by phrase',
      name: 'searchByName',
      desc: '',
      args: [],
    );
  }

  /// `Sort by authors ascending`
  String get sortByAthAsc {
    return Intl.message(
      'Sort by authors ascending',
      name: 'sortByAthAsc',
      desc: '',
      args: [],
    );
  }

  /// `Sort by authors descending`
  String get sortByAthDes {
    return Intl.message(
      'Sort by authors descending',
      name: 'sortByAthDes',
      desc: '',
      args: [],
    );
  }

  /// `Sort by titles ascending`
  String get sortByTitleAsc {
    return Intl.message(
      'Sort by titles ascending',
      name: 'sortByTitleAsc',
      desc: '',
      args: [],
    );
  }

  /// `Sort by titles descending`
  String get sortByTitleDes {
    return Intl.message(
      'Sort by titles descending',
      name: 'sortByTitleDes',
      desc: '',
      args: [],
    );
  }

  /// `Failed to enter data`
  String get notDownData {
    return Intl.message(
      'Failed to enter data',
      name: 'notDownData',
      desc: '',
      args: [],
    );
  }

  /// `Read`
  String get read {
    return Intl.message(
      'Read',
      name: 'read',
      desc: '',
      args: [],
    );
  }

  /// `Also check`
  String get alsoCheck {
    return Intl.message(
      'Also check',
      name: 'alsoCheck',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
