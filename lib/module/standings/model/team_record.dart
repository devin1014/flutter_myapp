import 'package:json_annotation/json_annotation.dart';

part 'team_record.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
class Standings {
  @JsonKey(name: "@LeagueID")
  final String leagueID;
  @JsonKey(name: "@League")
  final String league;
  @JsonKey(name: "@Season")
  final String season;
  @JsonKey(name: "@SeasonType")
  final String seasonType;
  final List<TeamRecord> teamRecords;

  const Standings(
    this.leagueID,
    this.league,
    this.season,
    this.seasonType,
    this.teamRecords,
  );

  factory Standings.fromJson(Map<String, dynamic> json) {
    final root = json["Msg_file"];
    final leagueID = root["@LeagueID"];
    final league = root["@League"];
    final season = root["@Season"];
    final seasonType = root["@SeasonType"];
    final List<dynamic> list = root["Game"]["Msg_standings"]["Team_record"];
    final List<TeamRecord> teamRecords = [];
    for (var element in list) {
      teamRecords.add(TeamRecord.fromJson(element));
    }
    return Standings(leagueID, league, season, seasonType, teamRecords);
  }

  Map<String, dynamic> toJson() => _$StandingsToJson(this);
}

/// "@Conference": "Eastern Conference",
/// "@Division": "Atlantic",
/// "@Team_id": "1610612761",
/// "@Team_name": "Toronto",
/// "@Team_NickName": "Raptors",
/// "@Team_abr": "TOR",
/// "@Wins": "53",
/// "@Losses": "19",
/// "@League_Game_behind": "2.5",
/// "@Game_behind": "0.0",
/// "@Win_pct": "0.736",
/// "@Div_rank": "1",
/// "@Po_rank": "2",
/// "@Po_game_behind": "2.5",
/// "@Clinched": "D",
/// "@Last10": "9-1",
/// "@Last10Home": "7-3",
/// "@Last10Road": "8-2",
/// "@ConferenceWins": "34",
/// "@ConferenceLosses": "11",
/// "@DivisionWins": "9",
/// "@DivisionLosses": "5",
/// "@HomeWins": "26",
/// "@HomeLosses": "10",
/// "@AwayWins": "27",
/// "@AwayLosses": "9",
/// "@Streak": "Won 4",
/// "@HomeStreak": "Won 2",
/// "@RoadStreak": "Won 8",
/// "@WinStreak": "Won 15",
/// "@LoseStreak": "Lost 3",
/// "@AheadAtHalfWins": "37",
/// "@AheadAtHalfLosses": "4",
/// "@BehindAtHalfWins": "15",
/// "@BehindAtHalfLosses": "14",
/// "@TiedAtHalfWins": "1",
/// "@TiedAtHalfLosses": "1",
/// "@AheadAtThirdWins": "48",
/// "@AheadAtThirdLosses": "6",
/// "@BehindAtThirdWins": "3",
/// "@BehindAtThirdLosses": "13",
/// "@TiedAtThirdWins": "2",
/// "@TiedAtThirdLosses": "0",
/// "@OTWins": "2",
/// "@OTLosses": "2",
/// "@ThreePtsOrLessWins": "6",
/// "@ThreePtsOrLessLosses": "4",
/// "@TenPtsOrMoreWins": "23",
/// "@TenPtsOrMoreLosses": "10",
/// "@Score100PlusWins": "51",
/// "@Score100PlusLosses": "11",
/// "@OPPScore100PlusWins": "35",
/// "@OPPScore100PlusLosses": "15",
/// "@OPPOver500Wins": "21",
/// "@OPPOver500Losses": "14",
/// "@LeadInFGPCTWins": "44",
/// "@LeadInFGPCTLosses": "3",
/// "@LeadInRebWins": "29",
/// "@LeadInRebLosses": "3",
/// "@FewerTurnoversWins": "37",
/// "@FewerTurnoversLosses": "9"
@JsonSerializable()
class TeamRecord {
  @JsonKey(name: "@Conference", defaultValue: "")
  final String conference;
  @JsonKey(name: "@Division", defaultValue: "")
  String division;
  @JsonKey(name: "@Team_id", defaultValue: "")
  String teamId;
  @JsonKey(name: "@Team_name", defaultValue: "")
  String teamName;
  @JsonKey(name: "@Team_NickName", defaultValue: "")
  String teamNickName;
  @JsonKey(name: "@Team_abr", defaultValue: "")
  String teamAbr;
  @JsonKey(name: "@Wins", defaultValue: "")
  String wins;
  @JsonKey(name: "@Losses", defaultValue: "")
  String losses;
  @JsonKey(name: "@League_Game_behind", defaultValue: "")
  String leagueGameBehind;
  @JsonKey(name: "@Game_behind", defaultValue: "")
  String gameBehind;
  @JsonKey(name: "@Win_pct", defaultValue: "")
  String winPct;
  @JsonKey(name: "@Div_rank", defaultValue: "")
  String divRank;
  @JsonKey(name: "@Po_rank", defaultValue: "")
  String poRank;
  @JsonKey(name: "@Po_game_behind", defaultValue: "")
  String poGameBehind;
  @JsonKey(name: "@Clinched", defaultValue: "")
  String clinched;
  @JsonKey(name: "@Last10", defaultValue: "")
  String last10;
  @JsonKey(name: "@Last10Home", defaultValue: "")
  String last10Home;
  @JsonKey(name: "@Last10Road", defaultValue: "")
  String last10Road;
  @JsonKey(name: "@ConferenceWins", defaultValue: "")
  String conferenceWins;
  @JsonKey(name: "@ConferenceLosses", defaultValue: "")
  String conferenceLosses;
  @JsonKey(name: "@DivisionWins", defaultValue: "")
  String divisionWins;
  @JsonKey(name: "@DivisionLosses", defaultValue: "")
  String divisionLosses;
  @JsonKey(name: "@HomeWins", defaultValue: "")
  String homeWins;
  @JsonKey(name: "@HomeLosses", defaultValue: "")
  String homeLosses;
  @JsonKey(name: "@AwayWins", defaultValue: "")
  String awayWins;
  @JsonKey(name: "@AwayLosses", defaultValue: "")
  String awayLosses;
  @JsonKey(name: "@Streak", defaultValue: "")
  String streak;
  @JsonKey(name: "@HomeStreak", defaultValue: "")
  String homeStreak;
  @JsonKey(name: "@RoadStreak", defaultValue: "")
  String roadStreak;
  @JsonKey(name: "@WinStreak", defaultValue: "")
  String winStreak;
  @JsonKey(name: "@LoseStreak", defaultValue: "")
  String loseStreak;
  @JsonKey(name: "@AheadAtHalfWins", defaultValue: "")
  String aheadAtHalfWins;
  @JsonKey(name: "@AheadAtHalfLosses", defaultValue: "")
  String aheadAtHalfLosses;
  @JsonKey(name: "@BehindAtHalfWins", defaultValue: "")
  String behindAtHalfWins;
  @JsonKey(name: "@BehindAtHalfLosses", defaultValue: "")
  String behindAtHalfLosses;
  @JsonKey(name: "@TiedAtHalfWins", defaultValue: "")
  String tiedAtHalfWins;
  @JsonKey(name: "@TiedAtHalfLosses", defaultValue: "")
  String tiedAtHalfLosses;
  @JsonKey(name: "@AheadAtThirdWins", defaultValue: "")
  String aheadAtThirdWins;
  @JsonKey(name: "@AheadAtThirdLosses", defaultValue: "")
  String aheadAtThirdLosses;
  @JsonKey(name: "@BehindAtThirdWins", defaultValue: "")
  String behindAtThirdWins;
  @JsonKey(name: "@BehindAtThirdLosses", defaultValue: "")
  String behindAtThirdLosses;
  @JsonKey(name: "@TiedAtThirdWins", defaultValue: "")
  String tiedAtThirdWins;
  @JsonKey(name: "@TiedAtThirdLosses", defaultValue: "")
  String tiedAtThirdLosses;
  @JsonKey(name: "@OTWins", defaultValue: "")
  String oTWins;
  @JsonKey(name: "@OTLosses", defaultValue: "")
  String oTLosses;
  @JsonKey(name: "@ThreePtsOrLessWins", defaultValue: "")
  String threePtsOrLessWins;
  @JsonKey(name: "@ThreePtsOrLessLosses", defaultValue: "")
  String threePtsOrLessLosses;
  @JsonKey(name: "@TenPtsOrMoreWins", defaultValue: "")
  String tenPtsOrMoreWins;
  @JsonKey(name: "@TenPtsOrMoreLosses", defaultValue: "")
  String tenPtsOrMoreLosses;
  @JsonKey(name: "@Score100PlusWins", defaultValue: "")
  String score100PlusWins;
  @JsonKey(name: "@Score100PlusLosses", defaultValue: "")
  String score100PlusLosses;
  @JsonKey(name: "@OPPScore100PlusWins", defaultValue: "")
  String oPPScore100PlusWins;
  @JsonKey(name: "@OPPScore100PlusLosses", defaultValue: "")
  String oPPScore100PlusLosses;
  @JsonKey(name: "@OPPOver500Wins", defaultValue: "")
  String oPPOver500Wins;
  @JsonKey(name: "@OPPOver500Losses", defaultValue: "")
  String oPPOver500Losses;
  @JsonKey(name: "@LeadInFGPCTWins", defaultValue: "")
  String leadInFGPCTWins;
  @JsonKey(name: "@LeadInFGPCTLosses", defaultValue: "")
  String leadInFGPCTLosses;
  @JsonKey(name: "@LeadInRebWins", defaultValue: "")
  String leadInRebWins;
  @JsonKey(name: "@LeadInRebLosses", defaultValue: "")
  String leadInRebLosses;
  @JsonKey(name: "@FewerTurnoversWins", defaultValue: "")
  String fewerTurnoversWins;
  @JsonKey(name: "@FewerTurnoversLosses", defaultValue: "")
  String fewerTurnoversLosses;

  TeamRecord(
      this.conference,
      this.division,
      this.teamId,
      this.teamName,
      this.teamNickName,
      this.teamAbr,
      this.wins,
      this.losses,
      this.leagueGameBehind,
      this.gameBehind,
      this.winPct,
      this.divRank,
      this.poRank,
      this.poGameBehind,
      this.clinched,
      this.last10,
      this.last10Home,
      this.last10Road,
      this.conferenceWins,
      this.conferenceLosses,
      this.divisionWins,
      this.divisionLosses,
      this.homeWins,
      this.homeLosses,
      this.awayWins,
      this.awayLosses,
      this.streak,
      this.homeStreak,
      this.roadStreak,
      this.winStreak,
      this.loseStreak,
      this.aheadAtHalfWins,
      this.aheadAtHalfLosses,
      this.behindAtHalfWins,
      this.behindAtHalfLosses,
      this.tiedAtHalfWins,
      this.tiedAtHalfLosses,
      this.aheadAtThirdWins,
      this.aheadAtThirdLosses,
      this.behindAtThirdWins,
      this.behindAtThirdLosses,
      this.tiedAtThirdWins,
      this.tiedAtThirdLosses,
      this.oTWins,
      this.oTLosses,
      this.threePtsOrLessWins,
      this.threePtsOrLessLosses,
      this.tenPtsOrMoreWins,
      this.tenPtsOrMoreLosses,
      this.score100PlusWins,
      this.score100PlusLosses,
      this.oPPScore100PlusWins,
      this.oPPScore100PlusLosses,
      this.oPPOver500Wins,
      this.oPPOver500Losses,
      this.leadInFGPCTWins,
      this.leadInFGPCTLosses,
      this.leadInRebWins,
      this.leadInRebLosses,
      this.fewerTurnoversWins,
      this.fewerTurnoversLosses);

  factory TeamRecord.fromJson(Map<String, dynamic> json) => _$TeamRecordFromJson(json);

  Map<String, dynamic> toJson() => _$TeamRecordToJson(this);
}
