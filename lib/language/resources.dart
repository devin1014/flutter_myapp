import 'package:flutter/widgets.dart';

abstract class LanguageResource {
  String get name => "name";

  String get title => "title";

  String get description => "description";

  String get author => "author";

  String get date => "date";
}

class LanguageResourceGen extends LanguageResource {
  static LanguageResourceGen of(BuildContext context) {
    return Localizations.of(context, LanguageResourceGen);
  }

  LanguageResourceGen(this._json);

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
