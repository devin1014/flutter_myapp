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

@JsonSerializable()
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
  @JsonKey(name: "d")
  final String date;
  @JsonKey(name: "st")
  final String startTime;
  @JsonKey(name: "et")
  final String endTime;
  @JsonKey(name: "gs", defaultValue: -1)
  final int gameState;
  @JsonKey(name: "s")
  final int season;
  @JsonKey(name: "h")
  final String homeTeam;
  @JsonKey(name: "hs", defaultValue: -1)
  final int homeScore;
  @JsonKey(name: "hr")
  final String homeRecord;
  @JsonKey(name: "v")
  final String awayTeam;
  @JsonKey(name: "vs", defaultValue: -1)
  final int awayScore;
  @JsonKey(name: "vr")
  final String awayRecord;

  const Game(
    this.id,
    this.cameras,
    this.cameraAngles,
    this.season,
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
  );

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
