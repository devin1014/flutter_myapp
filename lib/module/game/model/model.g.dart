// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleGame _$SingleGameFromJson(Map<String, dynamic> json) => SingleGame(
      json['id'] as String,
      json['season'] as String,
      json['home'] as String,
      json['homeTeamId'] as String,
      json['visitor'] as String,
      json['visitorTeamId'] as String,
    );

Map<String, dynamic> _$SingleGameToJson(SingleGame instance) =>
    <String, dynamic>{
      'id': instance.id,
      'season': instance.season,
      'home': instance.home,
      'homeTeamId': instance.homeTeamId,
      'visitor': instance.visitor,
      'visitorTeamId': instance.visitorTeamId,
    };

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      json['id'] as String? ?? '',
      json['cameras'] as int? ?? -1,
      json['cameraAngles'] as String? ?? '',
      json['s'] as int,
      json['d'] as String,
      json['st'] as String,
      json['et'] as String,
      json['gs'] as int? ?? -1,
      json['v'] as String,
      json['vs'] as int? ?? -1,
      json['vr'] as String,
      json['h'] as String,
      json['hs'] as int? ?? -1,
      json['hr'] as String,
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'id': instance.id,
      'cameras': instance.cameras,
      'cameraAngles': instance.cameraAngles,
      'd': instance.date,
      'st': instance.startTime,
      'et': instance.endTime,
      'gs': instance.gameState,
      's': instance.season,
      'h': instance.homeTeam,
      'hs': instance.homeScore,
      'hr': instance.homeRecord,
      'v': instance.awayTeam,
      'vs': instance.awayScore,
      'vr': instance.awayRecord,
    };

Games _$GamesFromJson(Map<String, dynamic> json) => Games(
      (json['games'] as List<dynamic>)
          .map((e) => Game.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GamesToJson(Games instance) => <String, dynamic>{
      'games': instance.games.map((e) => e.toJson()).toList(),
    };
