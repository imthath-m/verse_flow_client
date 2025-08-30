import 'package:json_annotation/json_annotation.dart';
import 'location.dart';

part 'ayah.g.dart';

/// Represents an individual ayah (verse) of the Quran
@JsonSerializable()
class Ayah {
  /// Global ayah number (1-6236)
  final int number;
  
  /// Ayah number within the surah
  final int numberInSurah;
  
  /// Surah number (1-114)
  final int juz;
  
  /// Manzil number
  final int manzil;
  
  /// Page number
  final int page;
  
  /// Ruku number
  final int ruku;
  
  /// Hizb quarter
  final int hizbQuarter;
  
  /// Sajda information
  final bool? sajda;
  
  /// Arabic text of the ayah
  final String text;
  
  /// Location of the ayah
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Location? location;
  
  const Ayah({
    required this.number,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    this.sajda,
    required this.text,
    this.location,
  });
  
  /// Creates an Ayah with location calculated from surah and ayah numbers
  factory Ayah.withLocation({
    required int surahNumber,
    required int ayahNumber,
    required int number,
    required int juz,
    required int manzil,
    required int page,
    required int ruku,
    required int hizbQuarter,
    bool? sajda,
    required String text,
  }) {
    return Ayah(
      number: number,
      numberInSurah: ayahNumber,
      juz: juz,
      manzil: manzil,
      page: page,
      ruku: ruku,
      hizbQuarter: hizbQuarter,
      sajda: sajda,
      text: text,
      location: Location(surahNumber: surahNumber, ayahNumber: ayahNumber),
    );
  }
  
  /// Creates a copy of this ayah with updated values
  Ayah copyWith({
    int? number,
    int? numberInSurah,
    int? juz,
    int? manzil,
    int? page,
    int? ruku,
    int? hizbQuarter,
    bool? sajda,
    String? text,
    Location? location,
  }) {
    return Ayah(
      number: number ?? this.number,
      numberInSurah: numberInSurah ?? this.numberInSurah,
      juz: juz ?? this.juz,
      manzil: manzil ?? this.manzil,
      page: page ?? this.page,
      ruku: ruku ?? this.ruku,
      hizbQuarter: hizbQuarter ?? this.hizbQuarter,
      sajda: sajda ?? this.sajda,
      text: text ?? this.text,
      location: location ?? this.location,
    );
  }
  
  /// Gets the surah number from location or calculates it
  int get surahNumber {
    if (location != null) return location!.surahNumber;
    // This is a fallback - in practice, location should always be provided
    return 1; // Default fallback
  }
  
  /// Gets the ayah number from location or numberInSurah
  int get ayahNumber {
    if (location != null) return location!.ayahNumber;
    return numberInSurah;
  }
  
  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Ayah &&
        other.number == number &&
        other.numberInSurah == numberInSurah &&
        other.juz == juz &&
        other.manzil == manzil &&
        other.page == page &&
        other.ruku == ruku &&
        other.hizbQuarter == hizbQuarter &&
        other.sajda == sajda &&
        other.text == text &&
        other.location == location;
  }
  
  /// Hash code
  @override
  int get hashCode {
    return number.hashCode ^
        numberInSurah.hashCode ^
        juz.hashCode ^
        manzil.hashCode ^
        page.hashCode ^
        ruku.hashCode ^
        hizbQuarter.hashCode ^
        sajda.hashCode ^
        text.hashCode ^
        location.hashCode;
  }
  
  /// String representation
  @override
  String toString() {
    return 'Ayah(number: $number, surah: $surahNumber, ayah: $ayahNumber, text: ${text.length} chars)';
  }
  
  /// JSON serialization
  factory Ayah.fromJson(Map<String, dynamic> json) => _$AyahFromJson(json);
  Map<String, dynamic> toJson() => _$AyahToJson(this);
}
