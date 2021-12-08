import 'package:flutter_router_demo/util/parser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team.g.dart';

/// "internalid": "39",
/// "teamkey": "NOP",
/// "cityname": "New Orleans",
/// "teamname": "Pelicans",
/// "conference": "Western",
/// "division": "Southwest",
/// "leagueid": "00",
/// "teamid": "1610612740",
/// "primaryhex": "#002b5c",
/// "secondaryhex": "#b4975a",
/// "arena": "Smoothie King Center - New Orleans, LA",
/// "founded": "2002",
/// "headCoach": "Alvin Gentry"
/// "external": false

@JsonSerializable()
class Team {
  @JsonKey(name: "internalid", defaultValue: "")
  final String internalId;
  @JsonKey(name: "teamid")
  final dynamic teamId;
  @JsonKey(name: "teamkey")
  final String teamKey;
  @JsonKey(name: "cityname")
  final String cityName;
  @JsonKey(name: "teamname")
  final String teamName;
  final String conference;
  final String division;
  @JsonKey(name: "primaryhex")
  final String primaryColor;
  @JsonKey(name: "secondaryhex")
  final String secondaryColor;
  final String arena;
  final String founded;
  @JsonKey(name: "headCoach")
  final String coach;
  @JsonKey(defaultValue: false)
  final bool external;

  const Team(
    this.internalId,
    this.teamId,
    this.teamKey,
    this.teamName,
    this.cityName,
    this.arena,
    this.conference,
    this.founded,
    this.division,
    this.coach,
    this.primaryColor,
    this.secondaryColor,
    this.external,
  );

  String get teamStringId => _parseTeamId(teamId);

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  Map<String, dynamic> toJson() => _$TeamToJson(this);

  String _parseTeamId(dynamic teamId) {
    if (teamId == null) return "";
    if (teamId is int) return teamId.toString();
    return teamId.toString();
  }
}

class TeamManager {
  static final TeamManager _instance = TeamManager._();

  static TeamManager getInstance() => _instance;

  TeamManager._();

  final List<Team> teamList = [];
  final Map<String, Team> _teamMap = {};

  void init() async {
    Map<String, dynamic> teams = (await Parser.parseAssets("assets/data/teams.json"))["teams"];
    for (var element in teams.values) {
      final team = Team.fromJson(element as Map<String, dynamic>);
      _instance.teamList.add(team);
      _instance._teamMap[team.teamStringId] = team;
      _instance._teamMap[team.teamKey] = team;
    }
  }

  Team? getTeam(String id) => _instance._teamMap[id];
}
