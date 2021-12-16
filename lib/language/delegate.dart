import 'package:flutter/widgets.dart';
import 'package:flutter_router_demo/language.g.dart';
import 'package:flutter_router_demo/language/resources/language.key.g.dart';

class MyLocalizations extends LanguageLocalization with $LanguageResource {
  static MyLocalizations of(BuildContext context) {
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
    return $LanguageEn();
  }
}
