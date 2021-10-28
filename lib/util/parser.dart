import 'dart:convert';

class Parser {
  Parser._();

  //TODO: add map function.
  static List<T> parse<T>(String? data, [String? root]) {
    if (data == null || data.isEmpty) return List.empty();
    dynamic object = json.decode(data);
    if (object is List<T>) return object;
    if (object is Map && object.isNotEmpty) {
      if (object.length == 1) {
        return object[object.keys.first] as List<T>;
      } else if (root != null && root.isNotEmpty && object.containsKey(root)) {
        final result = object[root];
        if (result is List<T>) {
          return result;
        }
      }
    }
    return List.empty();
  }
}
