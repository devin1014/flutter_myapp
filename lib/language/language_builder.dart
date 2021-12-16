import 'dart:convert';

import 'package:build/build.dart';
import 'package:path/path.dart' as path;

/// ---------------------------------------------------------------
/// ---- language key
/// ---------------------------------------------------------------
class LanguageKeyBuilder implements Builder {
  const LanguageKeyBuilder(this.options);

  final BuilderOptions options;
  static const _extensions = {
    '.key': ['.g.dart']
  };

  @override
  Map<String, List<String>> get buildExtensions => _extensions;

  @override
  Future<void> build(BuildStep buildStep) async {
    //inputId: flutter_router_demo|assets/language/default.json
    print("""
      ****************************************************
      **** build
      ****************************************************
    """);
    if (options.config.isNotEmpty) {
      print("options: ${options.config}");
    }
    final inputId = buildStep.inputId;
    final outputId = AssetId(inputId.package, inputId.path.replaceFirst(".key", ".g.dart"));
    final Map<String, dynamic> messages = json.decode(await buildStep.readAsString(inputId));
    final buffer = StringBuffer();
    buffer.writeln("""
import 'package:${buildStep.inputId.package}/language/delegate.dart';
/// Generated, do not edit
/// Source: ${inputId.toString()}
/// Date: ${DateTime.now()}
/// Size: ${messages.length}
mixin \$LanguageResource on LanguageLocalization {""");
    messages.forEach((key, value) {
      buffer.writeln('\tString get $key => \'__$key\';');
    });
    buffer.writeln("}");
    await buildStep.writeAsString(outputId, buffer.toString());
  }
}

/// ---------------------------------------------------------------
/// ---- language resource
/// ---------------------------------------------------------------
class LanguageResBuilder implements Builder {
  const LanguageResBuilder(this.options);

  final BuilderOptions options;
  static const _extensions = {
    '.json': ['.g.dart']
  };

  @override
  Map<String, List<String>> get buildExtensions => _extensions;

  @override
  Future<void> build(BuildStep buildStep) async {
    //inputId: flutter_router_demo|assets/language/default.json
    print("""
      ****************************************************
      **** build
      ****************************************************
    """);
    if (options.config.isNotEmpty) {
      print("options: ${options.config}");
    }
    final inputId = buildStep.inputId;
    final name = path.basenameWithoutExtension(inputId.path).toUpperCase();
    final outputId = AssetId(inputId.package, inputId.path.replaceFirst(".json", ".g.dart"));
    final fileName = "\$LanguageResource$name";
    final Map<String, dynamic> messages = json.decode(await buildStep.readAsString(inputId));
    final buffer = StringBuffer();
    buffer.writeln("""
import 'package:${buildStep.inputId.package}/language/delegate.dart';
import 'package:${buildStep.inputId.package}/language/resources/_key.g.dart';
/// Generated, do not edit
/// Source: ${inputId.toString()}
/// Date: ${DateTime.now()}
/// Size: ${messages.length}
class $fileName extends LanguageLocalization with \$LanguageResource {""");
    messages.forEach((key, value) {
      buffer.writeln('\t@override String get $key => \'$value\';');
    });
    buffer.writeln("}");
    await buildStep.writeAsString(outputId, buffer.toString());
  }
}
