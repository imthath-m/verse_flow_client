import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

/// Represents a language supported by the Quran API
@JsonSerializable()
class Language {
  /// Language code (e.g., 'ar', 'en', 'fr')
  final String code;
  
  /// Language name in English
  final String name;
  
  /// Native name of the language
  final String nativeName;
  
  /// Direction of text (ltr, rtl)
  final String direction;
  
  /// Number of editions available in this language
  final int editionsCount;
  
  const Language({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.direction,
    required this.editionsCount,
  });
  
  /// Creates a copy of this language with updated values
  Language copyWith({
    String? code,
    String? name,
    String? nativeName,
    String? direction,
    int? editionsCount,
  }) {
    return Language(
      code: code ?? this.code,
      name: name ?? this.name,
      nativeName: nativeName ?? this.nativeName,
      direction: direction ?? this.direction,
      editionsCount: editionsCount ?? this.editionsCount,
    );
  }
  
  /// Checks if this is a right-to-left language
  bool get isRTL => direction.toLowerCase() == 'rtl';
  
  /// Checks if this is a left-to-right language
  bool get isLTR => direction.toLowerCase() == 'ltr';
  
  /// Checks if this is Arabic
  bool get isArabic => code.toLowerCase() == 'ar';
  
  /// Checks if this is English
  bool get isEnglish => code.toLowerCase() == 'en';
  
  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Language &&
        other.code == code &&
        other.name == name &&
        other.nativeName == nativeName &&
        other.direction == direction &&
        other.editionsCount == editionsCount;
  }
  
  /// Hash code
  @override
  int get hashCode {
    return code.hashCode ^
        name.hashCode ^
        nativeName.hashCode ^
        direction.hashCode ^
        editionsCount.hashCode;
  }
  
  /// String representation
  @override
  String toString() {
    return 'Language(code: $code, name: $name, direction: $direction, editions: $editionsCount)';
  }
  
  /// JSON serialization
  factory Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}
