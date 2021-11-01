import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

// ------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------
// --- Story
// ------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------
@JsonSerializable()
class Hero {
  Hero(
    this.id,
    this.title,
    this.subTitle,
    this.itemImage,
    this.link,
    this.type,
    this.heroImage,
  );

  //@JsonConverter
  @JsonKey(name: "nbaId")
  final int id;
  final String title;
  final String subTitle;
  @JsonKey(name: "image")
  final String itemImage;
  final String link;
  final String? type;
  @JsonKey(name: "hero", fromJson: _parseHeroImageFromJson, toJson: _getHeroImageToJson)
  final String? heroImage;

  String get image => heroImage ?? itemImage;

  factory Hero.fromJson(Map<String, dynamic> json) => _$HeroFromJson(json);

  Map<String, dynamic> toJson() => _$HeroToJson(this);

  static String? _parseHeroImageFromJson(Object? object) {
    if (object is Map<String, dynamic> && object.containsKey("image")) {
      return object["image"];
    }
    return null;
  }

  static Map<String, dynamic>? _getHeroImageToJson(String? object) {
    if (object == null) return null;
    return {"image": object};
  }

  @override
  fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}

// ------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------
// --- Story
// ------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------
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
