import 'package:flutter_router_demo/home/model/carousel.dart';
import 'package:json_annotation/json_annotation.dart';

class HomeRoot {
  HomeRoot(this.list);

  @JsonKey(name: "appHomeMainFeed")
  final List<HomeItem> list;

  factory HomeRoot.fromJson(Map<String, dynamic> json) => _$HomeRootFromJson(json);
}

class HomeItem {
  HomeItem(
    this.id,
    this.type,
    this.title,
    this.value,
  );

  final int id;
  final String type;
  final String title;
  final CarouselInfo? value;

  factory HomeItem.fromJson(Map<String, dynamic> json) => _$HomeItemFromJson(json);
}

HomeRoot _$HomeRootFromJson(Map<String, dynamic> json) => HomeRoot(
      (json['appHomeMainFeed'] as List<dynamic>).map((e) => HomeItem.fromJson(e as Map<String, dynamic>)).toList(),
    );

HomeItem _$HomeItemFromJson(Map<String, dynamic> json) => HomeItem(
      json['id'] as int,
      json['type'] as String,
      json['title'] as String,
      json['value'] == null ? null : CarouselInfo.fromJson(json['value'] as Object, json['type'] as String),
    );
