import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class HomeBanner {
  HomeBanner(
    this.image,
    this.mobileImage,
    this.tabletImage,
    this.url,
    this.mobileUrl,
  );

  final String image;
  final String mobileImage;
  final String tabletImage;
  final String url;
  final String mobileUrl;

  factory HomeBanner.fromJson(Map<String, dynamic> json) => _$HomeBannerFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBannerToJson(this);
}

/// ------------------------------------------------------------------------------------------
/// --- Hero
/// ------------------------------------------------------------------------------------------
@JsonSerializable()
class HomeHero {
  const HomeHero(this.image);

  final String image;

  factory HomeHero.fromJson(Map<String, dynamic> json) => _$HomeHeroFromJson(json);

  Map<String, dynamic> toJson() => _$HomeHeroToJson(this);
}

/// ------------------------------------------------------------------------------------------
/// --- Story
/// ------------------------------------------------------------------------------------------
@JsonSerializable()
class Story {
  final int id;
  final String image;
  final String name;
  final String description;
  final String beginDate;
  final List<StoryProgram> programs;

  Story(
    this.id,
    this.image,
    this.name,
    this.description,
    this.beginDate,
    this.programs,
  );

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);
}

@JsonSerializable()
class StoryProgram {
  StoryProgram(
    this.id,
    this.name,
    this.releaseDate,
    this.path,
  );

  final int id;
  final String name;
  final String releaseDate;
  final String path;

  factory StoryProgram.fromJson(Map<String, dynamic> json) => _$StoryProgramFromJson(json);

  Map<String, dynamic> toJson() => _$StoryProgramToJson(this);
}
