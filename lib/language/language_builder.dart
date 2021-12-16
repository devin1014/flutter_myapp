import 'dart:convert';

import 'package:build/build.dart';
import 'package:path/path.dart' as path;

/// ---------------------------------------------------------------
/// ---- text builder
/// ---------------------------------------------------------------
class LanguageBuilder implements Builder {
  const LanguageBuilder(this.options);

  final BuilderOptions options;
  static const defaultOutputPath = "lib/language.g.dart";
  static const _extensions = {
    '.json': ['/../../../lib/language.g.dart']
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
    final name = path.basenameWithoutExtension(inputId.path);
    final outputPath = options.config['output'] ?? defaultOutputPath.replaceFirst("*", name);
    //inputId.path.replaceFirst(inputId.extension, _extensions[inputId.extension]!.first)
    final outputId = AssetId(inputId.package, outputPath);

    final fileName = "\$LanguageResource_$name";
    final Map<String, dynamic> messages = json.decode(await buildStep.readAsString(inputId));
    final buffer = StringBuffer();
    buffer.writeln("""
import 'package:${buildStep.inputId.package}/language/delegate.dart';
/// Generated, do not edit
/// Source: ${inputId.toString()}
/// Date: ${DateTime.now()}
/// Size: ${messages.length}
class $fileName with LanguageLocalization {
""");
    messages.forEach((key, value) {
      buffer.writeln('\tString get $key => \'$value\';');
    });
    buffer.writeln("}");
    await buildStep.writeAsString(outputId, buffer.toString());
  }
}
