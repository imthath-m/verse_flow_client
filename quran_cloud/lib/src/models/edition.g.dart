// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioEdition _$AudioEditionFromJson(Map<String, dynamic> json) => AudioEdition(
  identifier: json['identifier'] as String,
  language: json['language'] as String,
  name: json['name'] as String,
  englishName: json['englishName'] as String,
  direction: json['direction'] as String?,
);

Map<String, dynamic> _$AudioEditionToJson(AudioEdition instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'language': instance.language,
      'name': instance.name,
      'englishName': instance.englishName,
      'direction': instance.direction,
    };
