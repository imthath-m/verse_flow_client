import 'package:json_annotation/json_annotation.dart';

part 'surah.g.dart';

@JsonSerializable()
class Surah {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final int numberOfAyahs;
  final String revelationType;
  
  // Additional properties for app functionality
  @JsonKey(defaultValue: false)
  bool isFavorite;
  
  @JsonKey(defaultValue: false)
  bool isDownloaded;

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
    this.isFavorite = false,
    this.isDownloaded = false,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => _$SurahFromJson(json);
  Map<String, dynamic> toJson() => _$SurahToJson(this);

  @override
  String toString() {
    return 'Surah(number: $number, name: $name, englishName: $englishName, englishNameTranslation: $englishNameTranslation, numberOfAyahs: $numberOfAyahs, revelationType: $revelationType, isFavorite: $isFavorite, isDownloaded: $isDownloaded)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Surah && other.number == number;
  }

  @override
  int get hashCode => number.hashCode;

  Surah copyWith({
    int? number,
    String? name,
    String? englishName,
    String? englishNameTranslation,
    int? numberOfAyahs,
    String? revelationType,
    bool? isFavorite,
    bool? isDownloaded,
  }) {
    return Surah(
      number: number ?? this.number,
      name: name ?? this.name,
      englishName: englishName ?? this.englishName,
      englishNameTranslation: englishNameTranslation ?? this.englishNameTranslation,
      numberOfAyahs: numberOfAyahs ?? this.numberOfAyahs,
      revelationType: revelationType ?? this.revelationType,
      isFavorite: isFavorite ?? this.isFavorite,
      isDownloaded: isDownloaded ?? this.isDownloaded,
    );
  }
}
