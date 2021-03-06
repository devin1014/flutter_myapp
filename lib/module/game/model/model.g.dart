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
      json['d'] as String? ?? '',
      json['st'] as String? ?? '',
      json['et'] as String? ?? '',
      json['gs'] as int? ?? -1,
      json['v'] as String? ?? '',
      json['vs'] as int? ?? -1,
      json['vr'] as String? ?? '',
      json['h'] as String? ?? '',
      json['hs'] as int? ?? -1,
      json['hr'] as String? ?? '',
      json['desc'] as String? ?? '',
    )..broadcast = json['broadcast'] == null
        ? null
        : Broadcast.fromJson(json['broadcast'] as Map<String, dynamic>);

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'id': instance.id,
      'cameras': instance.cameras,
      'cameraAngles': instance.cameraAngles,
      'd': instance.date,
      'st': instance.startTime,
      'et': instance.endTime,
      'gs': instance.gameState,
      'h': instance.homeTeam,
      'hs': instance.homeScore,
      'hr': instance.homeRecord,
      'v': instance.awayTeam,
      'vs': instance.awayScore,
      'vr': instance.awayRecord,
      'desc': instance.description,
      'broadcast': instance.broadcast?.toJson(),
    };

Games _$GamesFromJson(Map<String, dynamic> json) => Games(
      (json['games'] as List<dynamic>)
          .map((e) => Game.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GamesToJson(Games instance) => <String, dynamic>{
      'games': instance.games.map((e) => e.toJson()).toList(),
    };

Broadcast _$BroadcastFromJson(Map<String, dynamic> json) => Broadcast(
      json['gameID'] as String? ?? '',
      json['broadcastID'] as String? ?? '',
      json['broadcasterName'] as String? ?? '',
    );

Map<String, dynamic> _$BroadcastToJson(Broadcast instance) => <String, dynamic>{
      'gameID': instance.gameID,
      'broadcastID': instance.broadcastID,
      'broadcasterName': instance.broadcasterName,
    };
