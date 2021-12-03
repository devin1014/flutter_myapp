import 'model/model.dart';

extension GameExtension on Game {
  bool isArchive() => gameState == Game.gameStateArchive || gameState == Game.gameStateDvr;

  bool isLive() => gameState == Game.gameStateLive;

  bool isUpcoming() => gameState == Game.gameStateUpcoming;

  bool isUnAvailable() => gameState == Game.gameStateUnavailable;
}

List<DateTime> buildDates() {
  final list = <DateTime>[];
  final now = DateTime.now();
  for (var i = -30; i < 0; i++) {
    list.add(now.add(Duration(days: i)));
  }
  list.add(now);
  for (var i = 1; i <= 30; i++) {
    list.add(now.add(Duration(days: i)));
  }
  return list;
}
