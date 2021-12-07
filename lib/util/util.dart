import 'package:flutter_router_demo/module/game/model/model.dart';

class MergeUtil {
  MergeUtil._();

  static void merge(List<Game> games, List<Broadcast> broadcastList) {
    for (var game in games) {
      for (var cast in broadcastList) {
        if (game.id == cast.gameID) {
          game.broadcast = cast;
          break;
        }
      }
    }
  }
}
