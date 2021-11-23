import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator.dart';
import 'text_builder.dart';

Builder languageBuilder(BuilderOptions options) => LibraryBuilder(MultipleLanguageGenerator());

Builder textBuilder(BuilderOptions options) => TextBuilder(options);
