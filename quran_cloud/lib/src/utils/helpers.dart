import 'package:meta/meta.dart';

/// Utility functions for the quran_cloud package
class QuranCloudHelpers {
  /// Validates if a surah number is within valid range (1-114)
  @visibleForTesting
  static bool isValidSurahNumber(int surahNumber) {
    return surahNumber >= 1 && surahNumber <= 114;
  }
  
  /// Validates if an ayah number is positive
  @visibleForTesting
  static bool isValidAyahNumber(int ayahNumber) {
    return ayahNumber > 0;
  }
  
  /// Formats location as "surah:ayah" string
  static String formatLocation(int surahNumber, int ayahNumber) {
    return '$surahNumber:$ayahNumber';
  }
  
  /// Parses location string in format "surah:ayah"
  static Map<String, int>? parseLocation(String location) {
    try {
      final parts = location.split(':');
      if (parts.length != 2) return null;
      
      final surahNumber = int.parse(parts[0]);
      final ayahNumber = int.parse(parts[1]);
      
      if (!isValidSurahNumber(surahNumber) || !isValidAyahNumber(ayahNumber)) {
        return null;
      }
      
      return {
        'surahNumber': surahNumber,
        'ayahNumber': ayahNumber,
      };
    } catch (e) {
      return null;
    }
  }
  
  /// Delays execution for a specified duration
  static Future<void> delay(Duration duration) async {
    await Future.delayed(duration);
  }
  
  /// Calculates exponential backoff delay
  static Duration calculateBackoffDelay(int attempt, {Duration baseDelay = const Duration(seconds: 1)}) {
    return Duration(milliseconds: baseDelay.inMilliseconds * (1 << attempt));
  }
}
