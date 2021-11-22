import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_router_demo/language/resources.dart';
import 'package:flutter_router_demo/util/logger.dart';

class MyLocalizations extends LanguageResource {
  static MyLocalizations of(BuildContext context) {
    return Localizations.of(context, MyLocalizations);
  }

  MyLocalizations(this._json);

  final Map<String, dynamic> _json;

  @override
  String get author => _json[super.author] ?? super.author;

  @override
  String get date => _json[super.date] ?? super.date;

  @override
  String get description => _json[super.description] ?? super.description;

  @override
  String get title => _json[super.title] ?? super.title;

  @override
  String get name => _json[super.name] ?? super.name;
}

/// -----------------------------------------------------------------------------
/// ---- delegate
/// -----------------------------------------------------------------------------
class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  static const LocalizationsDelegate<MyLocalizations> delegate = MyLocalizationsDelegate._();

  const MyLocalizationsDelegate._();

  @override
  bool isSupported(Locale locale) => true;

  @override
  bool shouldReload(covariant LocalizationsDelegate<MyLocalizations> old) => false;

  @override
  Future<MyLocalizations> load(Locale locale) async {
    Map<String, dynamic> result = {};
    try {
      String data = await rootBundle.loadString("resources/language/${_parseName(locale)}.json");
      result = json.decode(data);
    } catch (e) {
      Log.w(e.toString());
      String data = await rootBundle.loadString("resources/language/default.json");
      result = json.decode(data);
    }
    return MyLocalizations(result);
  }

  String _parseName(Locale locale) {
    String scriptCode = "";
    if (locale.scriptCode?.isNotEmpty == true) {
      scriptCode = "_${locale.scriptCode}";
    }
    return (locale.languageCode + scriptCode).toLowerCase();
  }
}

class LogLocalizationsDelegate extends LocalizationsDelegate {
  const LogLocalizationsDelegate._();

  @override
  bool isSupported(Locale locale) {
    Log.i("isSupported: $locale");
    return true;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) {
    Log.i("shouldReload: $old");
    return false;
  }

  @override
  Future load(Locale locale) async {
    Log.i("load: $locale");
    return MyLocalizations(<String, dynamic>{});
  }

  static const LocalizationsDelegate delegate = LogLocalizationsDelegate._();
}
