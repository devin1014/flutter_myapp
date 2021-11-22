import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator.dart';

class MultipleLanguage {
  const MultipleLanguage();
}

Builder languageBuilder(BuilderOptions options) => LibraryBuilder(MultipleLanguageGenerator());
