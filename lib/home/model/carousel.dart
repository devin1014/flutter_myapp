import 'package:flutter_router_demo/game/model/model.dart';
import 'package:flutter_router_demo/program/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'carousel.g.dart';

/// -----------------------------------------------------------
/// ---- Carousel Info
/// -----------------------------------------------------------
class CarouselInfo {
  CarouselInfo(
    this.limit,
    this.isPremium,
    this.isPersonalized,
  );

  final int limit;
  final bool isPremium;
  final bool isPersonalized;
  List<BaseCarousel> list = [];

  /// the object is content of 'value'.
  factory CarouselInfo.fromJson(Object object, String type) {
    final CarouselInfo result;
    if (object is Map<String, dynamic>) {
      result = _$CarouselInfoFromJson(object);
      List<dynamic> list = object['content'] ?? object['videos'] ?? object['items'] ?? [object];
      result.list = list.map((e) => BaseCarousel.fromJson(buildJson(e, type))).toList();
    } else {
      result = CarouselInfo(-1, false, false);
      if (object is List<dynamic>) {
        result.list = object.map((e) => BaseCarousel.fromJson(buildJson(e, type))).toList();
      }
    }
    return result;
  }

  static CarouselInfo _$CarouselInfoFromJson(Map<String, dynamic> json) => CarouselInfo(
        json['limit'] as int? ?? -1,
        json['isPremium'] as bool? ?? false,
        json['isPersonalized'] as bool? ?? false,
      );

  static Map<String, dynamic> buildJson(dynamic obj, String type) {
    Map<String, dynamic> result = obj as Map<String, dynamic>;
    result["_parentType"] = type;
    return result;
  }
}

/// -----------------------------------------------------------
/// ---- BaseCarousel
/// -----------------------------------------------------------
@JsonSerializable(createFactory: false)
class BaseCarousel {
  BaseCarousel(
    this.id,
    this.title,
    this.description,
    this.image,
    this.link,
    this.type,
  );

  static const String carouselTypeVideo = "video";
  static const String carouselTypeGame = "game";
  static const String carouselTypePost = "post";
  static const String carouselTypePage = "page";
  static const String carouselTypeHyperLink = "hyperlink";
  static const String carouselTypeEvent = "event";
  static const String carouselTypeCard = "card";
  static const String carouselTypeTvShow = "tv_show";
  static const String _carouselTypeCard = "collection_cards";
  static const String _carouselTypeTvShow = "taxonomy_cards";
  static const String _type = "type";
  static const String _parentType = "_parentType";

  @JsonKey(name: "nbaId", defaultValue: -1)
  final int id;
  @JsonKey(defaultValue: "")
  final String title;
  @JsonKey(defaultValue: "")
  final String description;
  @JsonKey(defaultValue: "")
  final String image;
  @JsonKey(defaultValue: "")
  final String link;
  @JsonKey(defaultValue: "")
  final String type;

  factory BaseCarousel.fromJson(Map<String, dynamic> json) {
    final type = json[_type] ?? json[_parentType] ?? "";
    switch (type) {
      case carouselTypeVideo:
        return VideoCarousel.fromJson(json);
      case carouselTypeGame:
        return GameCarousel.fromJson(json);
      case carouselTypeEvent:
        return EventCarousel.fromJson(json);
      case carouselTypeHyperLink:
        return LinkCarousel.fromJson(json);
      case _carouselTypeTvShow:
        return TvShowCarousel.fromJson(json);
      case _carouselTypeCard:
        return CardCarousel.fromJson(json);
      default:
        return LinkCarousel.fromJson(json);
    }
  }
}

/// -----------------------------------------------------------
/// ---- LinkCarousel
/// -----------------------------------------------------------
@JsonSerializable()
class LinkCarousel extends BaseCarousel {
  LinkCarousel(
    id,
    title,
    description,
    image,
    link,
    type,
    this.releaseDate,
    this.useUpdatedDate,
  ) : super(id, title, description, image, link, type);

  final String? releaseDate;
  @JsonKey(defaultValue: false)
  final bool useUpdatedDate;

  factory LinkCarousel.fromJson(Map<String, dynamic> json) => _$LinkCarouselFromJson(json);
}

/// -----------------------------------------------------------
/// ---- CardCarousel
/// -----------------------------------------------------------
@JsonSerializable()
class CardCarousel extends BaseCarousel {
  CardCarousel(
    id,
    name,
    permalink,
    image,
  ) : super(id, name, name, image, permalink, BaseCarousel.carouselTypeCard);

  factory CardCarousel.fromJson(Map<String, dynamic> json) => _$CardCarouselFromJson(json);

  static CardCarousel _$CardCarouselFromJson(Map<String, dynamic> json) => CardCarousel(
        json['nbaId'] ?? json['id'] ?? -1,
        json['name'] as String,
        json['permalink'] as String,
        json['image'] ?? '',
      );
}

/// -----------------------------------------------------------
/// ---- GameCarousel
/// -----------------------------------------------------------
@JsonSerializable()
class GameCarousel extends BaseCarousel {
  GameCarousel(
    id,
    title,
    description,
    image,
    link,
    type,
    this.game,
  ) : super(id, title, description, image, link, type);

  final SingleGame game;

  factory GameCarousel.fromJson(Map<String, dynamic> json) => _$GameCarouselFromJson(json);
}

/// -----------------------------------------------------------
/// ---- VideoCarousel
/// -----------------------------------------------------------
@JsonSerializable()
class VideoCarousel extends BaseCarousel {
  VideoCarousel(
    id,
    title,
    description,
    image,
    link,
    type,
    this.releaseDate,
    this.entitlements,
    this.videoIviCaId,
    this.program,
  ) : super(id, title, description, image, link, type);
  final String releaseDate;
  final String entitlements;
  @JsonKey(name: "videoIviCaid")
  final String videoIviCaId;
  final SingleProgram program;

  factory VideoCarousel.fromJson(Map<String, dynamic> json) => _$VideoCarouselFromJson(json);
}

/// -----------------------------------------------------------
/// ---- EventCarousel
/// -----------------------------------------------------------
@JsonSerializable()
class EventCarousel extends BaseCarousel {
  EventCarousel(
    id,
    title,
    description,
    image,
    link,
    type,
    this.seoName,
    this.entitlements,
    this.datetimeUtc,
  ) : super(id, title, description, image, link, type);
  final String seoName;
  final int datetimeUtc;
  final String entitlements;

  factory EventCarousel.fromJson(Map<String, dynamic> json) => _$EventCarouselFromJson(json);
}

/// -----------------------------------------------------------
/// ---- TvShow
/// -----------------------------------------------------------
class TvShowCarousel extends BaseCarousel {
  TvShowCarousel(
    id,
    this.name,
    description,
    this.permalink,
    this.latest,
    this.imagePortrait,
    this.imageLandscape,
  ) : super(id, name, description, "", permalink, BaseCarousel.carouselTypeTvShow);

  final String name;
  final String permalink;
  final BaseCarousel? latest;
  final String? imagePortrait;
  final String? imageLandscape;

  factory TvShowCarousel.fromJson(Map<String, dynamic> json) => _$TvShowCarouselFromJson(json);

  static TvShowCarousel _$TvShowCarouselFromJson(Map<String, dynamic> json) {
    final list = json['latest'] as List<dynamic>?;
    final latest = list != null && list.isNotEmpty ? list[0] as Map<String, dynamic> : null;
    final coverImage = json['coverImage'] as Map<String, dynamic>?;

    return TvShowCarousel(
      json['nbaId'] ?? json['id'] ?? -1,
      json['name'] as String,
      json['description'] ?? '',
      json['permalink'] as String,
      latest != null ? BaseCarousel.fromJson(latest) : null,
      coverImage?["portrait"] as String?,
      coverImage?["landscape"] as String?,
    );
  }
}
