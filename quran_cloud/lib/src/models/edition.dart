import 'package:json_annotation/json_annotation.dart';

part 'edition.g.dart';

/// Represents an audio edition of the Quran (arabic or tranlation)
@JsonSerializable()
class AudioEdition {
  /// Unique identifier for the edition
  final String identifier;

  /// Language code (e.g., 'ar', 'en', 'fr')
  final String language;

  /// Name of the edition in its native language
  final String name;

  /// English name of the edition
  final String englishName;

  const AudioEdition({
    required this.identifier,
    required this.language,
    required this.name,
    required this.englishName,
  });

  /// Checks if this is Arabic
  bool get isArabic => language.toLowerCase() == 'ar';

  /// Checks if this is English
  bool get isEnglish => language.toLowerCase() == 'en';

  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AudioEdition && other.identifier == identifier;
  }

  /// Hash code
  @override
  int get hashCode {
    return identifier.hashCode;
  }

  /// String representation
  @override
  String toString() {
    return 'Edition: $identifier';
  }

  /// JSON serialization
  factory AudioEdition.fromJson(Map<String, dynamic> json) =>
      _$AudioEditionFromJson(json);
  Map<String, dynamic> toJson() => _$AudioEditionToJson(this);
}

@JsonSerializable()
class TextEdition extends AudioEdition {
  /// Text direction (ltr, rtl)
  final String direction;

  const TextEdition({
    required super.identifier,
    required super.language,
    required super.name,
    required super.englishName,
    required this.direction,
  });

  /// Checks if this is left-to-right text direction
  bool get isLTR => direction.toLowerCase() == 'ltr';

  /// Checks if this is right-to-left text direction
  bool get isRTL => direction.toLowerCase() == 'rtl';

  /// JSON serialization
  factory TextEdition.fromJson(Map<String, dynamic> json) =>
      _$TextEditionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TextEditionToJson(this);
}
