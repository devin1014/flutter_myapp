import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart' show BuildStep;
import 'package:source_gen/source_gen.dart';

class MultipleLanguage {
  const MultipleLanguage();
}

class MultipleLanguageGenerator extends GeneratorForAnnotation<MultipleLanguage> {
  String _buildImportClass(Element element) {
    String path = element.enclosingElement.toString();
    if (path.startsWith("/")) {
      path = path.substring(1);
    }
    path = path.replaceAll("/lib", "");
    return """
    import 'package:$path';
    """;
  }

  String _buildClass(String className, {String? extendsInfo, String? interfaceInfo}) {
    String extendsClass = "";
    if (extendsInfo?.isNotEmpty == true) {
      extendsClass = "extends $extendsInfo ";
    }
    String interfaceClass = "";
    if (interfaceInfo?.isNotEmpty == true) {
      interfaceClass = "interface $interfaceInfo";
    }
    return """
    class $className $extendsClass $interfaceClass
    """;
  }

  String _buildConstruct(String className) {
    return """
    $className(this._json);
    """;
  }

  String _buildField(List<FieldElement>? list) {
    if (list == null || list.isEmpty) return "";
    StringBuffer buffer = StringBuffer();
    for (var element in list) {
      List<String> items = element.toString().split(" ");
      buffer.writeln("@override");
      buffer.writeln("${items[0]} get ${items[1]} => _json[super.${items[1]}] ?? super.${items[1]};");
    }
    return buffer.toString();
  }

  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    final String fileName = element.name ?? element.displayName;
    final String className = "\$${fileName}Gen";
    return """
    ${_buildImportClass(element)}
    ${_buildClass(className, extendsInfo: fileName)}
    {
    ${_buildConstruct(className)}
    final Map<String, dynamic> _json;
    ${_buildField((element as ClassElement).fields)}
    }
    """;
  }
}
