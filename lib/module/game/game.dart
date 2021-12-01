import 'model/model.dart';

extension GameExtension on Game {
  bool isArchive() => gameState == Game.gameStateArchive || gameState == Game.gameStateDvr;

  bool isLive() => gameState == Game.gameStateLive;

  bool isUpcoming() => gameState == Game.gameStateUpcoming;

  bool isUnAvailable() => gameState == Game.gameStateUnavailable;
}
