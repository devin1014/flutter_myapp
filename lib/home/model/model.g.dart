// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeHero _$HomeHeroFromJson(Map<String, dynamic> json) => HomeHero(
      json['image'] as String,
    );

Map<String, dynamic> _$HomeHeroToJson(HomeHero instance) => <String, dynamic>{
      'image': instance.image,
    };

Story _$StoryFromJson(Map<String, dynamic> json) => Story(
      json['id'] as int,
      json['image'] as String,
      json['name'] as String,
      json['description'] as String,
      json['beginDate'] as String,
      (json['programs'] as List<dynamic>)
          .map((e) => StoryProgram.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'description': instance.description,
      'beginDate': instance.beginDate,
      'programs': instance.programs,
    };

StoryProgram _$StoryProgramFromJson(Map<String, dynamic> json) => StoryProgram(
      json['id'] as int,
      json['name'] as String,
      json['releaseDate'] as String,
      json['path'] as String,
    );

Map<String, dynamic> _$StoryProgramToJson(StoryProgram instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'releaseDate': instance.releaseDate,
      'path': instance.path,
    };
