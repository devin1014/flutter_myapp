import 'dart:convert';

import 'package:archive/archive.dart';

class GZipUtil {
  static String encode(String input) {
    final List<int> stringBytes = utf8.encode(input);
    final List<int>? gzipBytes = GZipEncoder().encode(stringBytes);
    if (gzipBytes == null) return input;
    return base64UrlEncode(gzipBytes);
  }

  static String decode(String input) {
    final List<int> stringBytes = base64Url.decode(input);
    final List<int> gzipBytes = GZipDecoder().decodeBytes(stringBytes);
    return utf8.decode(gzipBytes);
  }
}

class Base64Util {
  static String encode(String input) {
    final content = utf8.encode(input);
    return base64Encode(content);
  }

  static String decode(String data) {
    return String.fromCharCodes(base64Decode(data));
  }
}
