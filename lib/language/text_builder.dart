import 'dart:convert';

import 'package:build/build.dart';

/// ---------------------------------------------------------------
/// ---- text builder
/// ---------------------------------------------------------------
class TextBuilder implements Builder {
  TextBuilder(this.options);

  final BuilderOptions options;
  static const defaultOutputPath = "lib/language.g.dart";
  static const _extensions = {
    '.json': ['/../../../lib/language.g.dart']
  };

  @override
  Map<String, List<String>> get buildExtensions => _extensions;

  @override
  Future<void> build(BuildStep buildStep) async {
    //inputId: flutter_router_demo|resources/language/default.json
    final inputId = buildStep.inputId;
    final outputPath = options.config['output'] ?? defaultOutputPath;
    //inputId.path.replaceFirst(inputId.extension, _extensions[inputId.extension]!.first)
    final outputId = AssetId(inputId.package, outputPath);

    final Map<String, dynamic> messages = json.decode(await buildStep.readAsString(inputId));
    final buffer = StringBuffer();
    _buildExplainInfo(buffer, inputId.toString(), messages.length);
    buffer.writeln("abstract class \$LanguageResource {");
    buffer.writeln("\t\$LanguageResource(this._json);\n");
    buffer.writeln("\tfinal Map<String, dynamic> _json;");
    messages.forEach((key, value) {
      buffer.writeln('\n\tString get $key => _json[\'$key\'] ?? \'__$key\';');
    });
    buffer.writeln("}");
    await buildStep.writeAsString(outputId, buffer.toString());
  }

  void _buildExplainInfo(StringBuffer buffer, String inputPath, int fieldSize) {
    buffer.writeln("/// Generated, do not edit");
    buffer.writeln("/// Source: $inputPath");
    buffer.writeln("/// Date: ${DateTime.now()}");
    buffer.writeln("/// Size: $fieldSize");
  }
}
