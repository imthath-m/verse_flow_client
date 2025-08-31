// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioEdition _$EditionFromJson(Map<String, dynamic> json) => AudioEdition(
  identifier: json['identifier'] as String,
  language: json['language'] as String,
  name: json['name'] as String,
  englishName: json['englishName'] as String,
  format: json['format'] as String?,
  type: json['type'] as String?,
  direction: json['direction'] as String?,
);

Map<String, dynamic> _$EditionToJson(AudioEdition instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'language': instance.language,
      'name': instance.name,
      'englishName': instance.englishName,
      'format': instance.format,
      'type': instance.type,
      'direction': instance.direction,
    };
