import 'package:json_annotation/json_annotation.dart';

part 'edition.g.dart';

/// Represents an edition of the Quran (text, audio, or translation)
@JsonSerializable()
class Edition {
  /// Unique identifier for the edition
  final String identifier;
  
  /// Language code (e.g., 'ar', 'en', 'fr')
  final String language;
  
  /// Name of the edition in its native language
  final String name;
  
  /// English name of the edition
  final String englishName;
  
  /// Format of the edition (text, audio)
  final String format;
  
  /// Type of the edition (quran, translation, versebyverse)
  final String type;
  
  /// Text direction (ltr, rtl)
  final String direction;
  
  const Edition({
    required this.identifier,
    required this.language,
    required this.name,
    required this.englishName,
    required this.format,
    required this.type,
    required this.direction,
  });
  
  /// Creates a copy of this edition with updated values
  Edition copyWith({
    String? identifier,
    String? language,
    String? name,
    String? englishName,
    String? format,
    String? type,
    String? direction,
  }) {
    return Edition(
      identifier: identifier ?? this.identifier,
      language: language ?? this.language,
      name: name ?? this.name,
      englishName: englishName ?? this.englishName,
      format: format ?? this.format,
      type: type ?? this.type,
      direction: direction ?? this.direction,
    );
  }
  
  /// Checks if this is an audio edition
  bool get isAudio => format == 'audio';
  
  /// Checks if this is a text edition
  bool get isText => format == 'text';
  
  /// Checks if this is a translation
  bool get isTranslation => type == 'translation';
  
  /// Checks if this is the original Quran text
  bool get isQuran => type == 'quran';
  
  /// Checks if this is verse-by-verse format
  bool get isVerseByVerse => type == 'versebyverse';
  
  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Edition &&
        other.identifier == identifier &&
        other.language == language &&
        other.name == name &&
        other.englishName == englishName &&
        other.format == format &&
        other.type == type &&
        other.direction == direction;
  }
  
  /// Hash code
  @override
  int get hashCode {
    return identifier.hashCode ^
        language.hashCode ^
        name.hashCode ^
        englishName.hashCode ^
        format.hashCode ^
        type.hashCode ^
        direction.hashCode;
  }
  
  /// String representation
  @override
  String toString() {
    return 'Edition(identifier: $identifier, language: $language, name: $name, format: $format, type: $type)';
  }
  
  /// JSON serialization
  factory Edition.fromJson(Map<String, dynamic> json) => _$EditionFromJson(json);
  Map<String, dynamic> toJson() => _$EditionToJson(this);
}
