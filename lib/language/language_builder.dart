import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart' show BuildStep;
import 'package:source_gen/source_gen.dart';

class MultipleLanguage {
  const MultipleLanguage();
}

class MultipleLanguageGenerator extends GeneratorForAnnotation<MultipleLanguage> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    return "class LanguageResourceGen2{}";
  }
}

Builder languageBuilder(BuilderOptions options) => LibraryBuilder(MultipleLanguageGenerator());
