import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

class Parser {
  Parser._();

  static Future<dynamic> parseAssets(String path) async {
    //TODO:delay a few seconds.
    await Future.delayed(Duration(seconds: Random().nextInt(5)), () {});
    String data = await rootBundle.loadString(path);
    return parse(data, "results");
  }

  static dynamic parse(String? data, [String? root, int? deep]) {
    if (data == null || data.isEmpty) return null;
    dynamic object = json.decode(data);
    if (object is Map && object.isNotEmpty) {
      if (root?.isNotEmpty == true) {
        return object[root];
      } else if (deep != null && deep > 0) {
        return getDeepObject(object, deep);
      }
    }
    return object;
  }

  static dynamic getDeepObject(dynamic obj, int deep) {
    if (obj is! Map) return obj;
    if (obj.length < deep) return obj;
    if (deep == 0) return obj;
    return getDeepObject(obj[obj.keys.first], deep - 1);
  }
}
