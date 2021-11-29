// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleProgram _$SingleProgramFromJson(Map<String, dynamic> json) =>
    SingleProgram(
      json['id'] as String,
      json['title'] as String,
      json['description'] as String,
      json['runtimeHours'] as String,
      json['seoName'] as String,
    );

Map<String, dynamic> _$SingleProgramToJson(SingleProgram instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'runtimeHours': instance.runtimeHours,
      'seoName': instance.seoName,
    };
