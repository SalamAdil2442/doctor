import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tandrustito/gen/assets.gen.dart';

class AppLocalizations {
  late Locale locale;
  AppLocalizations(this.locale);
  static AppLocalizations? of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  final Map<String, String> _localizedStrings = {};
  Future<bool> load() async {
    if (locale.languageCode == "ku") {
      await _load(Assets.i18n.ku);
    } else if (locale.languageCode == "ar") {
      await _load(Assets.i18n.ar);
    } else {
      await _load(Assets.i18n.en);
    }
    return true;
  }

  _load(String path) async {
    final result = await rootBundle.loadString(path);
    final r = json.decode(result);
    r.forEach((key, value) {
      _localizedStrings[key] = value.toString();
    });
  }

  String translate(String key) {
    return "${_localizedStrings[key]}";
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar', 'ku'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => true;
}
