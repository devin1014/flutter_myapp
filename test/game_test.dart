// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_router_demo/module/game/model/model.dart';
import 'package:flutter_router_demo/util/parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("parse test", () async {
    const path = "assets/data/schedule_1129.json";
    final List<Game> list = [];
    final result = await Parser.parseAssets(path);
    for (var element in (result["games"] as List)) {
      list.add(Game.fromJson(element));
    }
    expect(list[0].id, "0022100292");
    expect(list[0].gameState, 3);
    expect(list[0].date, "2021-11-27T18:00:00.000");
  });
}
