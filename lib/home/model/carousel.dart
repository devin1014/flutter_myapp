import 'package:flutter_router_demo/game/model/model.dart';
import 'package:flutter_router_demo/program/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'carousel.g.dart';

@JsonSerializable()
class CarouselInfo {
  CarouselInfo(
    this.limit,
    this.isPremium,
    this.isPersonalized,
  );

  @JsonKey(defaultValue: -1)
  final int limit;
  @JsonKey(defaultValue: false)
  final bool isPremium;
  @JsonKey(defaultValue: false)
  final bool isPersonalized;
  @JsonKey(ignore: true)
  List<BaseCarousel> list = [];

  factory CarouselInfo.fromJson(Object object) {
    final CarouselInfo result;
    if (object is Map<String, dynamic>) {
      result = _$CarouselInfoFromJson(object);
      List<dynamic> list = object['content'] ?? object['videos'] ?? object['items'] ?? [object];
      result.list = list.map((e) => BaseCarousel.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      result = CarouselInfo(-1, false, false);
      if (object is List<dynamic>) {
        result.list = object.map((e) => BaseCarousel.fromJson(e as Map<String, dynamic>)).toList();
      }
    }
    return result;
  }
}

@JsonSerializable()
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

  @JsonKey(name: "nbaId")
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
    final type = json['type'];
    switch (type) {
      case carouselTypeVideo:
        return VideoCarousel.fromJson(json);
      case carouselTypeGame:
        return GameCarousel.fromJson(json);
      case carouselTypeHyperLink:
        return LinkCarousel.fromJson(json);
      case carouselTypeCard:
        return CardCarousel.fromJson(json);
      default:
        return LinkCarousel.fromJson(json);
    }
  }
}

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

@JsonSerializable()
class CardCarousel extends BaseCarousel {
  CardCarousel(id, this.name, this.link, image) : super(id, "", "", image, link, BaseCarousel.carouselTypeCard);

  final String name;
  @JsonKey(name: "permalink")
  @override
  final String link;

  factory CardCarousel.fromJson(Map<String, dynamic> json) => _$CardCarouselFromJson(json);
}

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
