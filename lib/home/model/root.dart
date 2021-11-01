import 'package:flutter_router_demo/home/model/carousel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'root.g.dart';

@JsonSerializable()
class HomeRoot {
  HomeRoot(this.list);

  @JsonKey(name: "appHomeMainFeed")
  final List<HomeItem> list;

  factory HomeRoot.fromJson(Map<String, dynamic> json) => _$HomeRootFromJson(json);
}

@JsonSerializable()
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
