// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recitation _$RecitationFromJson(Map<String, dynamic> json) => Recitation(
  audioUrl: json['audioUrl'] as String,
  edition: json['edition'] as String,
  reciter: json['reciter'] as String,
  format: json['format'] as String,
  quality: json['quality'] as String,
  duration: (json['duration'] as num?)?.toInt(),
  fileSize: (json['fileSize'] as num?)?.toInt(),
);

Map<String, dynamic> _$RecitationToJson(Recitation instance) =>
    <String, dynamic>{
      'audioUrl': instance.audioUrl,
      'edition': instance.edition,
      'reciter': instance.reciter,
      'format': instance.format,
      'quality': instance.quality,
      'duration': instance.duration,
      'fileSize': instance.fileSize,
    };
