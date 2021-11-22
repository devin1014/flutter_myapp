import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_router_demo/language/resources.dart';
import 'package:flutter_router_demo/util/logger.dart';

class MyLocalizations extends LanguageResourceGen {
  static MyLocalizations of(BuildContext context) {
    return Localizations.of(context, MyLocalizations);
  }

  MyLocalizations(_json) : super(_json);
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
