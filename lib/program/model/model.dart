import 'package:flutter_router_demo/common/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class SingleProgram implements BaseModel {
  SingleProgram(
    this.id,
    this.title,
    this.description,
    this.runtimeHours,
    this.seoName,
  );

  final String id;
  final String title;
  final String description;
  final String runtimeHours;
  final String seoName;

  factory SingleProgram.fromJson(Map<String, dynamic> json) => _$SingleProgramFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SingleProgramToJson(this);
}
