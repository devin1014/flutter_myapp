import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator.dart';
import 'language_builder.dart';

Builder dart2DartBuilder(BuilderOptions options) => LibraryBuilder(MultipleLanguageGenerator());

Builder languageResBuilder(BuilderOptions options) => LanguageResBuilder(options);

Builder languageKeyBuilder(BuilderOptions options) => LanguageKeyBuilder(options);