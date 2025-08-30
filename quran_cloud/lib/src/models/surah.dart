import 'package:json_annotation/json_annotation.dart';
import 'ayah.dart';

part 'surah.g.dart';

/// Represents a surah (chapter) of the Quran
@JsonSerializable()
class Surah {
  /// Surah number (1-114)
  final int number;
  
  /// Arabic name of the surah
  final String name;
  
  /// English name of the surah
  final String englishName;
  
  /// English translation of the name
  final String englishNameTranslation;
  
  /// Number of ayahs in the surah
  final int numberOfAyahs;
  
  /// Type of revelation (Meccan or Medinan)
  final String revelationType;
  
  /// List of ayahs in the surah (optional, may be null if not loaded)
  final List<Ayah>? ayahs;
  
  /// Additional metadata
  final Map<String, dynamic>? additionalData;
  
  const Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
    this.ayahs,
    this.additionalData,
  });
  
  /// Creates a copy of this surah with updated values
  Surah copyWith({
    int? number,
    String? name,
    String? englishName,
    String? englishNameTranslation,
    int? numberOfAyahs,
    String? revelationType,
    List<Ayah>? ayahs,
    Map<String, dynamic>? additionalData,
  }) {
    return Surah(
      number: number ?? this.number,
      name: name ?? this.name,
      englishName: englishName ?? this.englishName,
      englishNameTranslation: englishNameTranslation ?? this.englishNameTranslation,
      numberOfAyahs: numberOfAyahs ?? this.numberOfAyahs,
      revelationType: revelationType ?? this.revelationType,
      ayahs: ayahs ?? this.ayahs,
      additionalData: additionalData ?? this.additionalData,
    );
  }
  
  /// Checks if this surah has ayahs loaded
  bool get hasAyahs => ayahs != null && ayahs!.isNotEmpty;
  
  /// Gets the number of loaded ayahs
  int get loadedAyahsCount => ayahs?.length ?? 0;
  
  /// Checks if this is a Meccan surah
  bool get isMeccan => revelationType.toLowerCase() == 'meccan';
  
  /// Checks if this is a Medinan surah
  bool get isMedinan => revelationType.toLowerCase() == 'medinan';
  
  /// Gets a specific ayah by its number in the surah
  Ayah? getAyah(int ayahNumber) {
    if (!hasAyahs) return null;
    try {
      return ayahs!.firstWhere((ayah) => ayah.numberInSurah == ayahNumber);
    } catch (e) {
      return null;
    }
  }
  
  /// Gets a range of ayahs
  List<Ayah> getAyahsRange(int start, int end) {
    if (!hasAyahs) return [];
    if (start < 1 || end > numberOfAyahs || start > end) return [];
    
    return ayahs!
        .where((ayah) => (ayah.numberInSurah ?? 0) >= start && (ayah.numberInSurah ?? 0) <= end)
        .toList();
  }
  
  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Surah &&
        other.number == number &&
        other.name == name &&
        other.englishName == englishName &&
        other.englishNameTranslation == englishNameTranslation &&
        other.numberOfAyahs == numberOfAyahs &&
        other.revelationType == revelationType &&
        other.ayahs == ayahs &&
        other.additionalData == additionalData;
  }
  
  /// Hash code
  @override
  int get hashCode {
    return number.hashCode ^
        name.hashCode ^
        englishName.hashCode ^
        englishNameTranslation.hashCode ^
        numberOfAyahs.hashCode ^
        revelationType.hashCode ^
        ayahs.hashCode ^
        additionalData.hashCode;
  }
  
  /// String representation
  @override
  String toString() {
    return 'Surah(number: $number, name: $name, ayahs: $numberOfAyahs, loaded: $loadedAyahsCount)';
  }
  
  /// JSON serialization
  factory Surah.fromJson(Map<String, dynamic> json) => _$SurahFromJson(json);
  Map<String, dynamic> toJson() => _$SurahToJson(this);
}
