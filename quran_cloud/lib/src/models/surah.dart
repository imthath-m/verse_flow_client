import 'package:json_annotation/json_annotation.dart';
import 'ayah.dart';

part 'surah.g.dart';

@JsonSerializable()
class Surah {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final int numberOfAyahs;
  final String revelationType;

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => _$SurahFromJson(json);
  Map<String, dynamic> toJson() => _$SurahToJson(this);

  @override
  String toString() {
    return 'Surah $number. $englishName';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Surah && other.number == number;
  }

  @override
  int get hashCode => number.hashCode;
}
