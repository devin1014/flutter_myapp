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
