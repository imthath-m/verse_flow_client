import 'package:json_annotation/json_annotation.dart';
import 'ayah.dart';

part 'translation.g.dart';

/// Represents a translation of Quran text
@JsonSerializable()
class Translation {
  /// The translated text
  final String text;
  
  /// Edition identifier used for this translation
  final String edition;
  
  /// Language code of the translation
  final String language;
  
  /// Associated ayah information
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Ayah? ayah;
  
  const Translation({
    required this.text,
    required this.edition,
    required this.language,
    this.ayah,
  });
  
  /// Creates a copy of this translation with updated values
  Translation copyWith({
    String? text,
    String? edition,
    String? language,
    Ayah? ayah,
  }) {
    return Translation(
      text: text ?? this.text,
      edition: edition ?? this.edition,
      language: language ?? this.language,
      ayah: ayah ?? this.ayah,
    );
  }
  
  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Translation &&
        other.text == text &&
        other.edition == edition &&
        other.language == language &&
        other.ayah == ayah;
  }
  
  /// Hash code
  @override
  int get hashCode {
    return text.hashCode ^
        edition.hashCode ^
        language.hashCode ^
        ayah.hashCode;
  }
  
  /// String representation
  @override
  String toString() {
    return 'Translation(edition: $edition, language: $language, text: ${text.length} chars)';
  }
  
  /// JSON serialization
  factory Translation.fromJson(Map<String, dynamic> json) => _$TranslationFromJson(json);
  Map<String, dynamic> toJson() => _$TranslationToJson(this);
}
