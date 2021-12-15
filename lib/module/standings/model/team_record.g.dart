// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamRecord _$TeamRecordFromJson(Map<String, dynamic> json) => TeamRecord(
      json['@Conference'] as String? ?? '',
      json['@Division'] as String? ?? '',
      json['@Team_id'] as String? ?? '',
      json['@Team_name'] as String? ?? '',
      json['@Team_NickName'] as String? ?? '',
      json['@Team_abr'] as String? ?? '',
      json['@Wins'] as String? ?? '',
      json['@Losses'] as String? ?? '',
      json['@League_Game_behind'] as String? ?? '',
      json['@Game_behind'] as String? ?? '',
      json['@Win_pct'] as String? ?? '',
      json['@Div_rank'] as String? ?? '',
      json['@Po_rank'] as String? ?? '',
      json['@Po_game_behind'] as String? ?? '',
      json['@Clinched'] as String? ?? '',
      json['@Last10'] as String? ?? '',
      json['@Last10Home'] as String? ?? '',
      json['@Last10Road'] as String? ?? '',
      json['@ConferenceWins'] as String? ?? '',
      json['@ConferenceLosses'] as String? ?? '',
      json['@DivisionWins'] as String? ?? '',
      json['@DivisionLosses'] as String? ?? '',
      json['@HomeWins'] as String? ?? '',
      json['@HomeLosses'] as String? ?? '',
      json['@AwayWins'] as String? ?? '',
      json['@AwayLosses'] as String? ?? '',
      json['@Streak'] as String? ?? '',
      json['@HomeStreak'] as String? ?? '',
      json['@RoadStreak'] as String? ?? '',
      json['@WinStreak'] as String? ?? '',
      json['@LoseStreak'] as String? ?? '',
      json['@AheadAtHalfWins'] as String? ?? '',
      json['@AheadAtHalfLosses'] as String? ?? '',
      json['@BehindAtHalfWins'] as String? ?? '',
      json['@BehindAtHalfLosses'] as String? ?? '',
      json['@TiedAtHalfWins'] as String? ?? '',
      json['@TiedAtHalfLosses'] as String? ?? '',
      json['@AheadAtThirdWins'] as String? ?? '',
      json['@AheadAtThirdLosses'] as String? ?? '',
      json['@BehindAtThirdWins'] as String? ?? '',
      json['@BehindAtThirdLosses'] as String? ?? '',
      json['@TiedAtThirdWins'] as String? ?? '',
      json['@TiedAtThirdLosses'] as String? ?? '',
      json['@OTWins'] as String? ?? '',
      json['@OTLosses'] as String? ?? '',
      json['@ThreePtsOrLessWins'] as String? ?? '',
      json['@ThreePtsOrLessLosses'] as String? ?? '',
      json['@TenPtsOrMoreWins'] as String? ?? '',
      json['@TenPtsOrMoreLosses'] as String? ?? '',
      json['@Score100PlusWins'] as String? ?? '',
      json['@Score100PlusLosses'] as String? ?? '',
      json['@OPPScore100PlusWins'] as String? ?? '',
      json['@OPPScore100PlusLosses'] as String? ?? '',
      json['@OPPOver500Wins'] as String? ?? '',
      json['@OPPOver500Losses'] as String? ?? '',
      json['@LeadInFGPCTWins'] as String? ?? '',
      json['@LeadInFGPCTLosses'] as String? ?? '',
      json['@LeadInRebWins'] as String? ?? '',
      json['@LeadInRebLosses'] as String? ?? '',
      json['@FewerTurnoversWins'] as String? ?? '',
      json['@FewerTurnoversLosses'] as String? ?? '',
    );

Map<String, dynamic> _$TeamRecordToJson(TeamRecord instance) =>
    <String, dynamic>{
      '@Conference': instance.conference,
      '@Division': instance.division,
      '@Team_id': instance.teamId,
      '@Team_name': instance.teamName,
      '@Team_NickName': instance.teamNickName,
      '@Team_abr': instance.teamAbr,
      '@Wins': instance.wins,
      '@Losses': instance.losses,
      '@League_Game_behind': instance.leagueGameBehind,
      '@Game_behind': instance.gameBehind,
      '@Win_pct': instance.winPct,
      '@Div_rank': instance.divRank,
      '@Po_rank': instance.poRank,
      '@Po_game_behind': instance.poGameBehind,
      '@Clinched': instance.clinched,
      '@Last10': instance.last10,
      '@Last10Home': instance.last10Home,
      '@Last10Road': instance.last10Road,
      '@ConferenceWins': instance.conferenceWins,
      '@ConferenceLosses': instance.conferenceLosses,
      '@DivisionWins': instance.divisionWins,
      '@DivisionLosses': instance.divisionLosses,
      '@HomeWins': instance.homeWins,
      '@HomeLosses': instance.homeLosses,
      '@AwayWins': instance.awayWins,
      '@AwayLosses': instance.awayLosses,
      '@Streak': instance.streak,
      '@HomeStreak': instance.homeStreak,
      '@RoadStreak': instance.roadStreak,
      '@WinStreak': instance.winStreak,
      '@LoseStreak': instance.loseStreak,
      '@AheadAtHalfWins': instance.aheadAtHalfWins,
      '@AheadAtHalfLosses': instance.aheadAtHalfLosses,
      '@BehindAtHalfWins': instance.behindAtHalfWins,
      '@BehindAtHalfLosses': instance.behindAtHalfLosses,
      '@TiedAtHalfWins': instance.tiedAtHalfWins,
      '@TiedAtHalfLosses': instance.tiedAtHalfLosses,
      '@AheadAtThirdWins': instance.aheadAtThirdWins,
      '@AheadAtThirdLosses': instance.aheadAtThirdLosses,
      '@BehindAtThirdWins': instance.behindAtThirdWins,
      '@BehindAtThirdLosses': instance.behindAtThirdLosses,
      '@TiedAtThirdWins': instance.tiedAtThirdWins,
      '@TiedAtThirdLosses': instance.tiedAtThirdLosses,
      '@OTWins': instance.oTWins,
      '@OTLosses': instance.oTLosses,
      '@ThreePtsOrLessWins': instance.threePtsOrLessWins,
      '@ThreePtsOrLessLosses': instance.threePtsOrLessLosses,
      '@TenPtsOrMoreWins': instance.tenPtsOrMoreWins,
      '@TenPtsOrMoreLosses': instance.tenPtsOrMoreLosses,
      '@Score100PlusWins': instance.score100PlusWins,
      '@Score100PlusLosses': instance.score100PlusLosses,
      '@OPPScore100PlusWins': instance.oPPScore100PlusWins,
      '@OPPScore100PlusLosses': instance.oPPScore100PlusLosses,
      '@OPPOver500Wins': instance.oPPOver500Wins,
      '@OPPOver500Losses': instance.oPPOver500Losses,
      '@LeadInFGPCTWins': instance.leadInFGPCTWins,
      '@LeadInFGPCTLosses': instance.leadInFGPCTLosses,
      '@LeadInRebWins': instance.leadInRebWins,
      '@LeadInRebLosses': instance.leadInRebLosses,
      '@FewerTurnoversWins': instance.fewerTurnoversWins,
      '@FewerTurnoversLosses': instance.fewerTurnoversLosses,
    };
