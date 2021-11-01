// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carousel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarouselInfo _$CarouselInfoFromJson(Map<String, dynamic> json) => CarouselInfo(
      json['limit'] as int? ?? -1,
      json['isPremium'] as bool? ?? false,
      json['isPersonalized'] as bool? ?? false,
    );

Map<String, dynamic> _$CarouselInfoToJson(CarouselInfo instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'isPremium': instance.isPremium,
      'isPersonalized': instance.isPersonalized,
    };

BaseCarousel _$BaseCarouselFromJson(Map<String, dynamic> json) => BaseCarousel(
      json['nbaId'] as int,
      json['title'] as String? ?? '',
      json['description'] as String? ?? '',
      json['image'] as String? ?? '',
      json['link'] as String? ?? '',
      json['type'] as String? ?? '',
    );

Map<String, dynamic> _$BaseCarouselToJson(BaseCarousel instance) =>
    <String, dynamic>{
      'nbaId': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'link': instance.link,
      'type': instance.type,
    };

LinkCarousel _$LinkCarouselFromJson(Map<String, dynamic> json) => LinkCarousel(
      json['nbaId'],
      json['title'] ?? '',
      json['description'] ?? '',
      json['image'] ?? '',
      json['link'] ?? '',
      json['type'] ?? '',
      json['releaseDate'] as String?,
      json['useUpdatedDate'] as bool? ?? false,
    );

Map<String, dynamic> _$LinkCarouselToJson(LinkCarousel instance) =>
    <String, dynamic>{
      'nbaId': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'link': instance.link,
      'type': instance.type,
      'releaseDate': instance.releaseDate,
      'useUpdatedDate': instance.useUpdatedDate,
    };

CardCarousel _$CardCarouselFromJson(Map<String, dynamic> json) => CardCarousel(
      json['nbaId'],
      json['name'] as String,
      json['permalink'] as String,
      json['image'] ?? '',
    );

Map<String, dynamic> _$CardCarouselToJson(CardCarousel instance) =>
    <String, dynamic>{
      'nbaId': instance.id,
      'image': instance.image,
      'name': instance.name,
      'permalink': instance.link,
    };

GameCarousel _$GameCarouselFromJson(Map<String, dynamic> json) => GameCarousel(
      json['nbaId'],
      json['title'] ?? '',
      json['description'] ?? '',
      json['image'] ?? '',
      json['link'] ?? '',
      json['type'] ?? '',
      SingleGame.fromJson(json['game'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GameCarouselToJson(GameCarousel instance) =>
    <String, dynamic>{
      'nbaId': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'link': instance.link,
      'type': instance.type,
      'game': instance.game,
    };

VideoCarousel _$VideoCarouselFromJson(Map<String, dynamic> json) =>
    VideoCarousel(
      json['nbaId'],
      json['title'] ?? '',
      json['description'] ?? '',
      json['image'] ?? '',
      json['link'] ?? '',
      json['type'] ?? '',
      json['releaseDate'] as String,
      json['entitlements'] as String,
      json['videoIviCaid'] as String,
      SingleProgram.fromJson(json['program'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VideoCarouselToJson(VideoCarousel instance) =>
    <String, dynamic>{
      'nbaId': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'link': instance.link,
      'type': instance.type,
      'releaseDate': instance.releaseDate,
      'entitlements': instance.entitlements,
      'videoIviCaid': instance.videoIviCaId,
      'program': instance.program,
    };

EventCarousel _$EventCarouselFromJson(Map<String, dynamic> json) =>
    EventCarousel(
      json['nbaId'],
      json['title'] ?? '',
      json['description'] ?? '',
      json['image'] ?? '',
      json['link'] ?? '',
      json['type'] ?? '',
      json['seoName'] as String,
      json['entitlements'] as String,
      json['datetimeUtc'] as int,
    );

Map<String, dynamic> _$EventCarouselToJson(EventCarousel instance) =>
    <String, dynamic>{
      'nbaId': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'link': instance.link,
      'type': instance.type,
      'seoName': instance.seoName,
      'datetimeUtc': instance.datetimeUtc,
      'entitlements': instance.entitlements,
    };
