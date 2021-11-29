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
