// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'root.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeRoot _$HomeRootFromJson(Map<String, dynamic> json) => HomeRoot(
      (json['appHomeMainFeed'] as List<dynamic>)
          .map((e) => HomeItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeRootToJson(HomeRoot instance) => <String, dynamic>{
      'appHomeMainFeed': instance.list,
    };

HomeItem _$HomeItemFromJson(Map<String, dynamic> json) => HomeItem(
      json['id'] as int,
      json['type'] as String,
      json['title'] as String,
      json['value'] == null
          ? null
          : CarouselInfo.fromJson(json['value'] as Object),
    );

Map<String, dynamic> _$HomeItemToJson(HomeItem instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'value': instance.value,
    };
