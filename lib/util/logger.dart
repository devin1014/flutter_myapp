import 'package:logger/logger.dart';

class Log {
  static final _logger = Logger(
    printer: PrettyPrinter(methodCount: 0, errorMethodCount: 5, printTime: false),
  );

  static v(dynamic message) {
    _logger.v(message);
  }

  static d(dynamic message) {
    _logger.d(message);
  }

  static i(dynamic message) {
    _logger.i(message);
  }

  static w(dynamic message) {
    _logger.w(message);
  }

  static e(dynamic message) {
    _logger.e(message);
  }
}
