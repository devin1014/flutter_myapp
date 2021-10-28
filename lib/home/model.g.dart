// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hero _$HeroFromJson(Map<String, dynamic> json) => Hero(
      json['nbaId'] as int,
      json['title'] as String,
      json['subTitle'] as String,
      json['image'] as String,
      json['link'] as String,
      json['type'] as String?,
      Hero._parseHeroImageFromJson(json['hero']),
    );

Map<String, dynamic> _$HeroToJson(Hero instance) => <String, dynamic>{
      'nbaId': instance.id,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'image': instance.itemImage,
      'link': instance.link,
      'type': instance.type,
      'hero': Hero._getHeroImageToJson(instance.heroImage),
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
