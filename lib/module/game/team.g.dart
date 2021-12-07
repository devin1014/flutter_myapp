// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      json['internalid'] as String? ?? '',
      json['teamid'],
      json['teamkey'] as String,
      json['teamname'] as String,
      json['cityname'] as String,
      json['arena'] as String,
      json['conference'] as String,
      json['founded'] as String,
      json['division'] as String,
      json['headCoach'] as String,
      json['primaryhex'] as String,
      json['secondaryhex'] as String,
      json['external'] as bool? ?? false,
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'internalid': instance.internalId,
      'teamid': instance.teamId,
      'teamkey': instance.teamKey,
      'cityname': instance.cityName,
      'teamname': instance.teamName,
      'conference': instance.conference,
      'division': instance.division,
      'primaryhex': instance.primaryColor,
      'secondaryhex': instance.secondaryColor,
      'arena': instance.arena,
      'founded': instance.founded,
      'headCoach': instance.coach,
      'external': instance.external,
    };
