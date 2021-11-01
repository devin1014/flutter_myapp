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
}
