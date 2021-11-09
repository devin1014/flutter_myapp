// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'root.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$HomeRootToJson(HomeRoot instance) => <String, dynamic>{
      'tuneInBanner': instance.banner.toJson(),
      'homeHeroCarousel': instance.heroList.map((e) => e.toJson()).toList(),
      'appHomeMainFeed': instance.contentList.map((e) => e.toJson()).toList(),
    };

Map<String, dynamic> _$HomeItemToJson(HomeItem instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'value': instance.value?.toJson(),
    };
