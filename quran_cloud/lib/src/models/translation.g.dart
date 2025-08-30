// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Translation _$TranslationFromJson(Map<String, dynamic> json) => Translation(
  text: json['text'] as String,
  edition: json['edition'] as String,
  language: json['language'] as String,
);

Map<String, dynamic> _$TranslationToJson(Translation instance) =>
    <String, dynamic>{
      'text': instance.text,
      'edition': instance.edition,
      'language': instance.language,
    };
