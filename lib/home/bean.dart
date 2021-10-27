import 'package:json_annotation/json_annotation.dart';

part 'bean.g.dart';

class HomeStory {
  final int id;
  final String image;
  final String name;
  final String description;
  final String beginDate;
  final int count;
  final List<HomeStoryProgram> programs;

  HomeStory(
    this.id,
    this.image,
    this.name,
    this.description,
    this.beginDate,
    this.count,
    this.programs,
  );

  HomeStory.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        image = _parseImage(json["image"], json["masterImage"]),
        name = json["name"],
        description = json["description"],
        beginDate = json["beginDate"],
        count = int.parse(json["count"]),
        programs = (json["programs"] as List<dynamic>).map((e) => HomeStoryProgram.fromJson(e)).toList();

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'description': description,
        'beginDate': beginDate,
        'count': count,
        'programs': programs,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  static String _parseImage(String? primaryImage, String? secondImage) {
    return primaryImage == null || primaryImage.isEmpty ? secondImage ?? "" : "";
  }
}

@JsonSerializable()
class HomeStoryProgram {
  HomeStoryProgram(
    this.id,
    this.name,
    this.releaseDate,
    this.path,
  );

  final int id;
  final String name;
  final String releaseDate;
  final String path;

  factory HomeStoryProgram.fromJson(Map<String, dynamic> json) => _$HomeStoryProgramFromJson(json);

  Map<String, dynamic> toJson() => _$HomeStoryProgramToJson(this);

  @override
  String toString() => toJson().toString();
}
