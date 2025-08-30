// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Language _$LanguageFromJson(Map<String, dynamic> json) => Language(
  code: json['code'] as String,
  name: json['name'] as String,
  nativeName: json['nativeName'] as String,
  direction: json['direction'] as String,
  editionsCount: (json['editionsCount'] as num).toInt(),
);

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'nativeName': instance.nativeName,
  'direction': instance.direction,
  'editionsCount': instance.editionsCount,
};
