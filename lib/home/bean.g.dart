// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeStoryProgram _$HomeStoryProgramFromJson(Map<String, dynamic> json) =>
    HomeStoryProgram(
      json['id'] as int,
      json['name'] as String,
      json['releaseDate'] as String,
      json['path'] as String,
    );

Map<String, dynamic> _$HomeStoryProgramToJson(HomeStoryProgram instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'releaseDate': instance.releaseDate,
      'path': instance.path,
    };
