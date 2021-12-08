import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class SingleGame {
  SingleGame(
    this.id,
    this.season,
    this.home,
    this.homeTeamId,
    this.visitor,
    this.visitorTeamId,
  );

  final String id;
  final String season;
  final String home;
  final String homeTeamId;
  final String visitor;
  final String visitorTeamId;

  factory SingleGame.fromJson(Map<String, dynamic> json) => _$SingleGameFromJson(json);

  Map<String, dynamic> toJson() => _$SingleGameToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Game {
  static const gameStateUnavailable = -1;
  static const gameStateUpcoming = 0;
  static const gameStateLive = 1;
  static const gameStateDvr = 2;
  static const gameStateArchive = 3;

  @JsonKey(defaultValue: "")
  final String id;
  @JsonKey(defaultValue: -1)
  final int cameras;
  @JsonKey(defaultValue: "")
  final String cameraAngles;
  @JsonKey(name: "d", defaultValue: "")
  final String date;
  @JsonKey(name: "st", defaultValue: "")
  final String startTime;
  @JsonKey(name: "et", defaultValue: "")
  final String endTime;
  @JsonKey(name: "gs", defaultValue: -1)
  final int gameState;
  @JsonKey(name: "h", defaultValue: "")
  final String homeTeam;
  @JsonKey(name: "hs", defaultValue: -1)
  final int homeScore;
  @JsonKey(name: "hr", defaultValue: "")
  final String homeRecord;
  @JsonKey(name: "v", defaultValue: "")
  final String awayTeam;
  @JsonKey(name: "vs", defaultValue: -1)
  final int awayScore;
  @JsonKey(name: "vr", defaultValue: "")
  final String awayRecord;
  @JsonKey(name: "desc", defaultValue: "")
  final String description;
  Broadcast? broadcast;

  Game(
    this.id,
    this.cameras,
    this.cameraAngles,
    this.date,
    this.startTime,
    this.endTime,
    this.gameState,
    this.awayTeam,
    this.awayScore,
    this.awayRecord,
    this.homeTeam,
    this.homeScore,
    this.homeRecord,
    this.description,
  );

  String get broadcastID => broadcast?.broadcastID ?? "";

  String get broadcastName => broadcast?.broadcasterName ?? "";

  bool get isEvent => homeTeam.isEmpty && awayTeam.isEmpty;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Games {
  Games(this.games);

  final List<Game> games;

  factory Games.fromJson(Map<String, dynamic> json) => _$GamesFromJson(json);

  Map<String, dynamic> toJson() => _$GamesToJson(this);
}

@JsonSerializable()
class Broadcast {
  Broadcast(
    this.gameID,
    this.broadcastID,
    this.broadcasterName,
  );

  @JsonKey(defaultValue: "")
  final String gameID;
  @JsonKey(defaultValue: "")
  final String broadcastID;
  @JsonKey(defaultValue: "")
  final String broadcasterName;

  factory Broadcast.fromJson(Map<String, dynamic> json) => _$BroadcastFromJson(json);

  Map<String, dynamic> toJson() => _$BroadcastToJson(this);
}
