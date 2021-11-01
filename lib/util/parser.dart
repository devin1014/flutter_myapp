import 'dart:convert';

import 'package:flutter/services.dart';

class Parser {
  Parser._();

  static Future<dynamic> parseAssets(String path) async {
    await Future.delayed(const Duration(seconds: 2), () {});
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

//TODO: add map function.
// static List<T> parse<T>(String? data, [String? root]) {
//   if (data == null || data.isEmpty) return List.empty();
//   dynamic object = json.decode(data);
//   if (object is List<T>) return object;
//   if (object is Map && object.isNotEmpty) {
//     if (object.length == 1) {
//       return object[object.keys.first] as List<T>;
//     } else if (root != null && root.isNotEmpty && object.containsKey(root)) {
//       final result = object[root];
//       if (result is List<T>) {
//         return result;
//       }
//     }
//   }
//   return List.empty();
// }
}
