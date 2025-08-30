import 'package:dio/dio.dart';
import '../api/client.dart';
import '../api/endpoints.dart';
import '../api/exceptions.dart';
import '../models/edition.dart';
import '../models/language.dart';

import '../models/ayah.dart';
import '../models/location.dart';

/// Service for fetching translations and language metadata
class TranslationService {
  final QuranApiClient _client;
  
  /// Creates a new TranslationService instance
  TranslationService({QuranApiClient? client}) : _client = client ?? QuranApiClient();
  
  /// Get list of available languages
  Future<List<Language>> getAvailableLanguages() async {
    try {
      final response = await _client.get(ApiEndpoints.languages);
      final data = response.data as Map<String, dynamic>;
      
      if (data['code'] != 200) {
        throw QuranApiException(
          data['message'] ?? 'Failed to fetch languages',
          statusCode: data['code'],
          responseData: data,
        );
      }
      
      final languagesData = data['data'] as List;
      return languagesData.map((json) => Language.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.error is QuranCloudException) {
        rethrow;
      }
      throw QuranApiException(
        'Failed to fetch languages',
        originalError: e,
      );
    }
  }
  
  /// Get translation editions
  Future<List<Edition>> getTranslationEditions() async {
    try {
      final response = await _client.get(ApiEndpoints.translationEditions());
      final data = response.data as Map<String, dynamic>;
      
      if (data['code'] != 200) {
        throw QuranApiException(
          data['message'] ?? 'Failed to fetch translation editions',
          statusCode: data['code'],
          responseData: data,
        );
      }
      
      final editionsData = data['data'] as List;
      return editionsData.map((json) => Edition.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.error is QuranCloudException) {
        rethrow;
      }
      throw QuranApiException(
        'Failed to fetch translation editions',
        originalError: e,
      );
    }
  }
  
  /// Get editions for a specific language
  Future<List<Edition>> getEditionsForLanguage(String languageCode) async {
    try {
      final response = await _client.get(ApiEndpoints.editionsByLanguage(languageCode));
      final data = response.data as Map<String, dynamic>;
      
      if (data['code'] != 200) {
        throw QuranApiException(
          data['message'] ?? 'Failed to fetch editions for language $languageCode',
          statusCode: data['code'],
          responseData: data,
        );
      }
      
      final editionsData = data['data'] as List;
      return editionsData
          .map((json) => Edition.fromJson(json))
          .where((edition) => edition.isTranslation)
          .toList();
    } on DioException catch (e) {
      if (e.error is QuranCloudException) {
        rethrow;
      }
      throw QuranApiException(
        'Failed to fetch editions for language $languageCode',
        originalError: e,
      );
    }
  }
  
  /// Get translation for a specific surah
  Future<List<Ayah>> getTranslationForSurah(String editionId, int surahNumber) async {
    try {
      final response = await _client.get(ApiEndpoints.surahWithEdition(surahNumber, editionId));
      final data = response.data as Map<String, dynamic>;
      
      if (data['code'] != 200) {
        throw QuranApiException(
          data['message'] ?? 'Failed to fetch translation for surah $surahNumber',
          statusCode: data['code'],
          responseData: data,
        );
      }
      
      final surahData = data['data'] as Map<String, dynamic>;
      final ayahsData = surahData['ayahs'] as List;
      
      return ayahsData.map((json) => Ayah.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.error is QuranCloudException) {
        rethrow;
      }
      throw QuranApiException(
        'Failed to fetch translation for surah $surahNumber',
        originalError: e,
      );
    }
  }
  
  /// Get translation for a range of ayahs
  Future<List<Ayah>> getTranslationForRange(String editionId, Location start, Location end) async {
    if (!start.isValid || !end.isValid) {
      throw ArgumentError('Invalid location range');
    }
    
    if (start.surahNumber > end.surahNumber) {
      throw ArgumentError('Start surah number cannot be greater than end surah number');
    }
    
    final List<Ayah> ayahs = [];
    
    // If same surah, get range within that surah
    if (start.surahNumber == end.surahNumber) {
      final surahAyahs = await getTranslationForSurah(editionId, start.surahNumber);
      return surahAyahs
          .where((ayah) => (ayah.numberInSurah ?? 0) >= start.ayahNumber && (ayah.numberInSurah ?? 0) <= end.ayahNumber)
          .toList();
    } else {
      // Get ayahs from multiple surahs
      for (int surahNum = start.surahNumber; surahNum <= end.surahNumber; surahNum++) {
        final surahAyahs = await getTranslationForSurah(editionId, surahNum);
        final startAyah = surahNum == start.surahNumber ? start.ayahNumber : 1;
        final endAyah = surahNum == end.surahNumber ? end.ayahNumber : surahAyahs.length;
        
        ayahs.addAll(surahAyahs
            .where((ayah) => (ayah.numberInSurah ?? 0) >= startAyah && (ayah.numberInSurah ?? 0) <= endAyah));
      }
    }
    
    return ayahs;
  }
  
  /// Get translation for a specific ayah
  Future<Ayah> getTranslationForAyah(String editionId, Location location) async {
    if (!location.isValid) {
      throw ArgumentError('Invalid location: $location');
    }
    
    try {
      final response = await _client.get(ApiEndpoints.ayahWithEdition(location.toString(), editionId));
      final data = response.data as Map<String, dynamic>;
      
      if (data['code'] != 200) {
        throw QuranApiException(
          data['message'] ?? 'Failed to fetch translation for ayah at $location',
          statusCode: data['code'],
          responseData: data,
        );
      }
      
      final ayahData = data['data'] as Map<String, dynamic>;
      return Ayah.fromJson(ayahData);
    } on DioException catch (e) {
      if (e.error is QuranCloudException) {
        rethrow;
      }
      throw QuranApiException(
        'Failed to fetch translation for ayah at $location',
        originalError: e,
      );
    }
  }
  
  /// Get translation for a specific ayah by numbers
  Future<Ayah> getTranslationForAyahByNumbers(String editionId, int surahNumber, int ayahNumber) async {
    return getTranslationForAyah(editionId, Location(surahNumber: surahNumber, ayahNumber: ayahNumber));
  }
  
  /// Get best translation edition for a language
  Future<Edition?> getBestTranslationForLanguage(String languageCode) async {
    final editions = await getEditionsForLanguage(languageCode);
    
    if (editions.isEmpty) return null;
    
    // Try to find a well-known translation
    final wellKnownIdentifiers = [
      'en.sahih', // Sahih International
      'en.hilali', // Hilali & Khan
      'en.pickthall', // Pickthall
      'en.yusufali', // Yusuf Ali
      'en.maududi', // Maududi
    ];
    
    for (final identifier in wellKnownIdentifiers) {
      final edition = editions.firstWhere(
        (e) => e.identifier == identifier,
        orElse: () => editions.first,
      );
      if (edition.identifier == identifier) {
        return edition;
      }
    }
    
    // Return the first available edition
    return editions.first;
  }
  
  /// Close the service and underlying client
  void close() {
    _client.close();
  }
}
