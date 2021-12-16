import 'package:flutter/widgets.dart';
import 'package:flutter_router_demo/language/resources/_key.g.dart';
import 'package:flutter_router_demo/language/resources/en.g.dart';

class MyLocalizations extends LanguageLocalization with $LanguageResource {
  static $LanguageResource of(BuildContext context) {
    return Localizations.of(context, LanguageLocalization);
  }
}

abstract class LanguageLocalization {
  String getLanguage() => runtimeType.toString();
}

/// -----------------------------------------------------------------------------
/// ---- delegate
/// -----------------------------------------------------------------------------
class LanguageLocalizationsDelegate extends LocalizationsDelegate<LanguageLocalization> {
  static LanguageLocalizationsDelegate delegate = LanguageLocalizationsDelegate._();

  LanguageLocalizationsDelegate._();

  @override
  bool isSupported(Locale locale) => true;

  @override
  bool shouldReload(covariant LocalizationsDelegate<LanguageLocalization> old) => false;

  @override
  Future<LanguageLocalization> load(Locale locale) async {
    //TODO:
    return $LanguageResourceEN();
  }
}
