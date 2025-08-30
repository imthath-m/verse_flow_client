import 'package:json_annotation/json_annotation.dart';

part 'ayah.g.dart';

/// Represents an individual ayah (verse) of the Quran
@JsonSerializable()
class Ayah {
  /// Global ayah number (1-6236)
  final int number;
  
  /// Arabic text of the ayah
  final String text;
  
  /// Ayah number within the surah
  final int numberInSurah;
  
  const Ayah({
    required this.number,
    required this.text,
    required this.numberInSurah,
  });
  
  /// Creates a copy of this ayah with updated values
  Ayah copyWith({
    int? number,
    String? text,
    int? numberInSurah,
  }) {
    return Ayah(
      number: number ?? this.number,
      text: text ?? this.text,
      numberInSurah: numberInSurah ?? this.numberInSurah,
    );
  }
  
  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Ayah &&
        other.number == number &&
        other.text == text &&
        other.numberInSurah == numberInSurah;
  }
  
  /// Hash code
  @override
  int get hashCode {
    return number.hashCode ^
        text.hashCode ^
        numberInSurah.hashCode;
  }
  
  /// String representation
  @override
  String toString() {
    return 'Ayah(number: $number, numberInSurah: $numberInSurah, text: ${text.length} chars)';
  }
  
  /// JSON serialization
  factory Ayah.fromJson(Map<String, dynamic> json) => _$AyahFromJson(json);
  Map<String, dynamic> toJson() => _$AyahToJson(this);
}
