import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_router_demo/language.g.dart';
import 'package:flutter_router_demo/util/logger.dart';

class MyLocalizations extends $LanguageResource with LanguageLocalization {
  static MyLocalizations of(BuildContext context) {
    return Localizations.of(context, LanguageLocalization);
  }

  MyLocalizations(_json) : super(_json);
}

class LanguageLocalizationParser extends AbstractLocalizationParser {
  const LanguageLocalizationParser() : super();

  @override
  String getLocalizationFile(Locale locale) {
    String scriptCode = "";
    if (locale.scriptCode?.isNotEmpty == true) {
      scriptCode = "_${locale.scriptCode}";
    }
    return (locale.languageCode + scriptCode + ".json").toLowerCase();
  }

  @override
  String getLocalizationLibPath() => "resources/language";

  @override
  T build<T extends LanguageLocalization>(Map<String, dynamic> json) {
    return MyLocalizations(json) as T;
  }
}

mixin LanguageLocalization {}

abstract class AbstractLocalizationParser {
  const AbstractLocalizationParser();

  String getLocalizationLibPath();

  String getLocalizationFile(Locale locale);

  String _getPath(Locale locale) => "${getLocalizationLibPath()}/${getLocalizationFile(locale)}";

  String getDefaultPath() => "${getLocalizationLibPath()}/default.json";

  T build<T extends LanguageLocalization>(Map<String, dynamic> json);
}

/// -----------------------------------------------------------------------------
/// ---- delegate
/// -----------------------------------------------------------------------------
class LanguageLocalizationsDelegate extends LocalizationsDelegate<LanguageLocalization> {
  static LocalizationsDelegate<LanguageLocalization> delegate = LanguageLocalizationsDelegate._();

  LanguageLocalizationsDelegate._();

  @override
  bool isSupported(Locale locale) => true;

  @override
  bool shouldReload(covariant LocalizationsDelegate<LanguageLocalization> old) => false;

  LanguageLocalizationParser parser = const LanguageLocalizationParser();

  @override
  Future<LanguageLocalization> load(Locale locale) async {
    Map<String, dynamic> result = {};
    try {
      result = json.decode(await rootBundle.loadString(parser._getPath(locale)));
    } catch (e) {
      Log.w(e.toString());
      result = json.decode(await rootBundle.loadString(parser.getDefaultPath()));
    }
    return parser.build(result);
  }
}
