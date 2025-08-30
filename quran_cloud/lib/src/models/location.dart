import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

/// Represents a location in the Quran (surah and ayah)
@JsonSerializable()
class Location {
  /// Surah number (1-114)
  final int surahNumber;
  
  /// Ayah number within the surah
  final int ayahNumber;
  
  const Location({
    required this.surahNumber,
    required this.ayahNumber,
  });
  
  /// Creates a Location from a string in format "surah:ayah"
  factory Location.fromString(String location) {
    final parts = location.split(':');
    if (parts.length != 2) {
      throw ArgumentError('Invalid location format. Expected "surah:ayah"');
    }
    
    final surahNumber = int.parse(parts[0]);
    final ayahNumber = int.parse(parts[1]);
    
    return Location(surahNumber: surahNumber, ayahNumber: ayahNumber);
  }
  
  /// Converts location to string format "surah:ayah"
  @override
  String toString() => '$surahNumber:$ayahNumber';
  
  /// Creates a copy of this location with updated values
  Location copyWith({
    int? surahNumber,
    int? ayahNumber,
  }) {
    return Location(
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
    );
  }
  
  /// Checks if this location is valid
  bool get isValid {
    return surahNumber >= 1 && surahNumber <= 114 && ayahNumber > 0;
  }
  
  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Location &&
        other.surahNumber == surahNumber &&
        other.ayahNumber == ayahNumber;
  }
  
  /// Hash code
  @override
  int get hashCode => surahNumber.hashCode ^ ayahNumber.hashCode;
  
  /// JSON serialization
  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
