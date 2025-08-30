import '../utils/constants.dart';

/// API endpoints for Al-Quran Cloud API
class ApiEndpoints {
  static const String _baseUrl = QuranCloudConstants.baseUrl;
  
  /// Get list of all surahs
  static String get surahs => '$_baseUrl/surah';
  
  /// Get specific surah by number
  static String surah(int number) => '$_baseUrl/surah/$number';
  
  /// Get specific ayah by location
  static String ayah(String location) => '$_baseUrl/ayah/$location';
  
  /// Get specific ayah by surah and ayah numbers
  static String ayahByNumbers(int surah, int ayah) => '$_baseUrl/ayah/$surah:$ayah';
  
  /// Get list of all editions
  static String get editions => '$_baseUrl/edition';
  
  /// Get editions by format and type
  static String editionsByFormat(String format, {String? type, String? language}) {
    final params = <String>['format=$format'];
    if (type != null) params.add('type=$type');
    if (language != null) params.add('language=$language');
    return '$_baseUrl/edition?${params.join('&')}';
  }
  
  /// Get audio editions (recitations)
  static String audioEditions({String? language}) {
    return editionsByFormat('audio', type: 'versebyverse', language: language);
  }
  
  /// Get translation editions
  static String translationEditions() {
    return editionsByFormat('text', type: 'translation');
  }
  
  /// Get editions for specific language
  static String editionsByLanguage(String language) {
    return '$_baseUrl/edition?language=$language';
  }
  
  /// Get surah with specific edition
  static String surahWithEdition(int surahNumber, String edition) {
    return '$_baseUrl/surah/$surahNumber/$edition';
  }
  
  /// Get ayah with specific edition
  static String ayahWithEdition(String location, String edition) {
    return '$_baseUrl/ayah/$location/$edition';
  }
  
  /// Get ayah with specific edition by numbers
  static String ayahWithEditionByNumbers(int surah, int ayah, String edition) {
    return '$_baseUrl/ayah/$surah:$ayah/$edition';
  }
  
  /// Get languages list
  static String get languages => '$_baseUrl/edition/language';
  
  /// Get juz by number
  static String juz(int number) => '$_baseUrl/juz/$number';
  
  /// Get juz with specific edition
  static String juzWithEdition(int number, String edition) => '$_baseUrl/juz/$number/$edition';
  
  /// Get page by number
  static String page(int number) => '$_baseUrl/page/$number';
  
  /// Get page with specific edition
  static String pageWithEdition(int number, String edition) => '$_baseUrl/page/$number/$edition';
  
  /// Get hizb by number
  static String hizb(int number) => '$_baseUrl/hizb/$number';
  
  /// Get hizb with specific edition
  static String hizbWithEdition(int number, String edition) => '$_baseUrl/hizb/$number/$edition';
  
  /// Get ruku by number
  static String ruku(int number) => '$_baseUrl/ruku/$number';
  
  /// Get ruku with specific edition
  static String rukuWithEdition(int number, String edition) => '$_baseUrl/ruku/$number/$edition';
  
  /// Get manzil by number
  static String manzil(int number) => '$_baseUrl/manzil/$number';
  
  /// Get manzil with specific edition
  static String manzilWithEdition(int number, String edition) => '$_baseUrl/manzil/$number/$edition';
  
  /// Get sajda ayahs
  static String get sajda => '$_baseUrl/sajda';
  
  /// Get sajda ayahs with specific edition
  static String sajdaWithEdition(String edition) => '$_baseUrl/sajda/$edition';
  
  /// Search in Quran text
  static String search(String query, {String? edition, int? page, int? size}) {
    final params = <String>['q=$query'];
    if (edition != null) params.add('edition=$edition');
    if (page != null) params.add('page=$page');
    if (size != null) params.add('size=$size');
    return '$_baseUrl/search/${Uri.encodeComponent(query)}?${params.join('&')}';
  }
  
  /// Get quran info
  static String get quranInfo => '$_baseUrl/quran';
  
  /// Get quran info with specific edition
  static String quranInfoWithEdition(String edition) => '$_baseUrl/quran/$edition';
}
