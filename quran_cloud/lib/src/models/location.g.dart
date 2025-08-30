// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
  surahNumber: (json['surahNumber'] as num).toInt(),
  ayahNumber: (json['ayahNumber'] as num).toInt(),
);

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
  'surahNumber': instance.surahNumber,
  'ayahNumber': instance.ayahNumber,
};
