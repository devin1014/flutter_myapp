import 'package:flutter_router_demo/home/model/carousel.dart';
import 'package:flutter_router_demo/home/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'root.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
class HomeRoot {
  HomeRoot(this.banner, this.heroList, this.contentList);

  final HomeBanner banner;
  final List<BaseCarousel> heroList;
  final List<HomeItem> contentList;

  factory HomeRoot.fromJson(Map<String, dynamic> json) {
    final homeBanner = HomeBanner.fromJson(json['tuneInBanner'] as Map<String, dynamic>);
    final homeHeroCarousel = json['homeHeroCarousel'] as List<dynamic>;
    final heroList = homeHeroCarousel.map((e) => BaseCarousel.fromJson(e as Map<String, dynamic>)).toList();
    final appHomeMainFeed = json['appHomeMainFeed'] as List<dynamic>;
    final mainList = appHomeMainFeed.map((e) => HomeItem.fromJson(e as Map<String, dynamic>)).toList();
    return HomeRoot(homeBanner, heroList, mainList);
  }

  Map<String, dynamic> toJson() => _$HomeRootToJson(this);
}

@JsonSerializable(createFactory: false, explicitToJson: true)
class HomeItem {
  static const String itemContentCarousel = "content_carousel";
  static const String itemStories = "stories";
  static const String itemHeadlines = "headlines";
  static const String itemFavoriteTeam = "favorite_team";
  static const String itemNbaTvCarousel = "nbatv_carousel";
  static const String itemCollectionCards = "collection_cards";
  static const String itemTaxonomyCards = "taxonomy_cards";
  static const String itemSingleItem = "single_item";

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

  factory HomeItem.fromJson(Map<String, dynamic> json) => HomeItem(
        json['id'] as int,
        json['type'] as String,
        json['title'] as String,
        json['value'] == null ? null : CarouselInfo.fromJson(json['value'] as Object, json['type'] as String),
      );

  Map<String, dynamic> toJson() => _$HomeItemToJson(this);
}
