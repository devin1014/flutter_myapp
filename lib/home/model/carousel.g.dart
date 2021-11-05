// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carousel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$BaseCarouselToJson(BaseCarousel instance) =>
    <String, dynamic>{
      'nbaId': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'link': instance.link,
      'type': instance.type,
      'hero': instance.hero,
    };

LinkCarousel _$LinkCarouselFromJson(Map<String, dynamic> json) => LinkCarousel(
      json['nbaId'] ?? -1,
      json['title'] ?? '',
      json['description'] ?? '',
      json['image'] ?? '',
      json['link'] ?? '',
      json['type'] ?? '',
      json['releaseDate'] as String?,
      json['useUpdatedDate'] as bool? ?? false,
      json['hero'] == null
          ? null
          : HomeHero.fromJson(json['hero'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LinkCarouselToJson(LinkCarousel instance) =>
    <String, dynamic>{
      'nbaId': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'link': instance.link,
      'type': instance.type,
      'hero': instance.hero,
      'releaseDate': instance.releaseDate,
      'useUpdatedDate': instance.useUpdatedDate,
    };

Map<String, dynamic> _$CardCarouselToJson(CardCarousel instance) =>
    <String, dynamic>{
      'nbaId': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'link': instance.link,
      'type': instance.type,
      'hero': instance.hero,
    };

GameCarousel _$GameCarouselFromJson(Map<String, dynamic> json) => GameCarousel(
      json['nbaId'] ?? -1,
      json['title'] ?? '',
      json['description'] ?? '',
      json['image'] ?? '',
      json['link'] ?? '',
      json['type'] ?? '',
      SingleGame.fromJson(json['game'] as Map<String, dynamic>),
      json['hero'] == null
          ? null
          : HomeHero.fromJson(json['hero'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GameCarouselToJson(GameCarousel instance) =>
    <String, dynamic>{
      'nbaId': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'link': instance.link,
      'type': instance.type,
      'hero': instance.hero,
      'game': instance.game,
    };

VideoCarousel _$VideoCarouselFromJson(Map<String, dynamic> json) =>
    VideoCarousel(
      json['nbaId'] ?? -1,
      json['title'] ?? '',
      json['description'] ?? '',
      json['image'] ?? '',
      json['link'] ?? '',
      json['type'] ?? '',
      json['releaseDate'] as String,
      json['entitlements'] as String,
      json['videoIviCaid'] as String,
      SingleProgram.fromJson(json['program'] as Map<String, dynamic>),
      json['hero'] == null
          ? null
          : HomeHero.fromJson(json['hero'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VideoCarouselToJson(VideoCarousel instance) =>
    <String, dynamic>{
      'nbaId': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'link': instance.link,
      'type': instance.type,
      'hero': instance.hero,
      'releaseDate': instance.releaseDate,
      'entitlements': instance.entitlements,
      'videoIviCaid': instance.videoIviCaId,
      'program': instance.program,
    };

EventCarousel _$EventCarouselFromJson(Map<String, dynamic> json) =>
    EventCarousel(
      json['nbaId'] ?? -1,
      json['title'] ?? '',
      json['description'] ?? '',
      json['image'] ?? '',
      json['link'] ?? '',
      json['type'] ?? '',
      json['seoName'] as String,
      json['entitlements'] as String,
      json['datetimeUtc'] as int,
      json['hero'] == null
          ? null
          : HomeHero.fromJson(json['hero'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventCarouselToJson(EventCarousel instance) =>
    <String, dynamic>{
      'nbaId': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'link': instance.link,
      'type': instance.type,
      'hero': instance.hero,
      'seoName': instance.seoName,
      'datetimeUtc': instance.datetimeUtc,
      'entitlements': instance.entitlements,
    };

Map<String, dynamic> _$TvShowCarouselToJson(TvShowCarousel instance) =>
    <String, dynamic>{
      'nbaId': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'link': instance.link,
      'type': instance.type,
      'hero': instance.hero,
      'name': instance.name,
      'permalink': instance.permalink,
      'latest': instance.latest,
      'imagePortrait': instance.imagePortrait,
      'imageLandscape': instance.imageLandscape,
    };
