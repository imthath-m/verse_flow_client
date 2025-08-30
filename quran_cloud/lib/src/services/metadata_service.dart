import 'package:dio/dio.dart';
import '../api/client.dart';
import '../api/endpoints.dart';
import '../api/exceptions.dart';
import '../models/edition.dart';

/// Service for fetching general metadata and information
class MetadataService {
  final QuranApiClient _client;
  
  /// Creates a new MetadataService instance
  MetadataService({QuranApiClient? client}) : _client = client ?? QuranApiClient();
  
  /// Get all available editions
  Future<List<Edition>> getAllEditions() async {
    try {
      final response = await _client.get(ApiEndpoints.editions);
      final data = response.data as Map<String, dynamic>;
      
      if (data['code'] != 200) {
        throw QuranApiException(
          data['message'] ?? 'Failed to fetch editions',
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
        'Failed to fetch editions',
        originalError: e,
      );
    }
  }
  
  /// Get editions by format
  Future<List<Edition>> getEditionsByFormat(String format) async {
    try {
      final response = await _client.get(ApiEndpoints.editionsByFormat(format));
      final data = response.data as Map<String, dynamic>;
      
      if (data['code'] != 200) {
        throw QuranApiException(
          data['message'] ?? 'Failed to fetch editions for format $format',
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
        'Failed to fetch editions for format $format',
        originalError: e,
      );
    }
  }
  
  /// Get text editions
  Future<List<Edition>> getTextEditions() async {
    return getEditionsByFormat('text');
  }
  
  /// Get audio editions
  Future<List<Edition>> getAudioEditions() async {
    return getEditionsByFormat('audio');
  }
  
  /// Get editions by type
  Future<List<Edition>> getEditionsByType(String type) async {
    final allEditions = await getAllEditions();
    return allEditions.where((edition) => edition.type == type).toList();
  }
  
  /// Get Quran text editions (original Arabic)
  Future<List<Edition>> getQuranTextEditions() async {
    return getEditionsByType('quran');
  }
  
  /// Get translation editions
  Future<List<Edition>> getTranslationEditions() async {
    return getEditionsByType('translation');
  }
  
  /// Get verse-by-verse editions
  Future<List<Edition>> getVerseByVerseEditions() async {
    return getEditionsByType('versebyverse');
  }
  
  /// Get editions by language
  Future<List<Edition>> getEditionsByLanguage(String languageCode) async {
    final allEditions = await getAllEditions();
    return allEditions.where((edition) => edition.language == languageCode).toList();
  }
  
  /// Get editions by direction
  Future<List<Edition>> getEditionsByDirection(String direction) async {
    final allEditions = await getAllEditions();
    return allEditions.where((edition) => edition.direction == direction).toList();
  }
  
  /// Get RTL (right-to-left) editions
  Future<List<Edition>> getRTLEditions() async {
    return getEditionsByDirection('rtl');
  }
  
  /// Get LTR (left-to-right) editions
  Future<List<Edition>> getLTREditions() async {
    return getEditionsByDirection('ltr');
  }
  
  /// Get available languages
  Future<List<String>> getAvailableLanguages() async {
    final allEditions = await getAllEditions();
    final languages = allEditions.map((edition) => edition.language).where((lang) => lang != null).cast<String>().toSet();
    return languages.toList()..sort();
  }
  
  /// Get available formats
  Future<List<String>> getAvailableFormats() async {
    final allEditions = await getAllEditions();
    final formats = allEditions.map((edition) => edition.format).where((format) => format != null).cast<String>().toSet();
    return formats.toList()..sort();
  }
  
  /// Get available types
  Future<List<String>> getAvailableTypes() async {
    final allEditions = await getAllEditions();
    final types = allEditions.map((edition) => edition.type).where((type) => type != null).cast<String>().toSet();
    return types.toList()..sort();
  }
  
  /// Get edition statistics
  Future<Map<String, dynamic>> getEditionStatistics() async {
    final allEditions = await getAllEditions();
    
    final languages = <String, int>{};
    final formats = <String, int>{};
    final types = <String, int>{};
    final directions = <String, int>{};
    
    for (final edition in allEditions) {
      if (edition.language != null) {
        languages[edition.language!] = (languages[edition.language!] ?? 0) + 1;
      }
      if (edition.format != null) {
        formats[edition.format!] = (formats[edition.format!] ?? 0) + 1;
      }
      if (edition.type != null) {
        types[edition.type!] = (types[edition.type!] ?? 0) + 1;
      }
      if (edition.direction != null) {
        directions[edition.direction!] = (directions[edition.direction!] ?? 0) + 1;
      }
    }
    
    return {
      'totalEditions': allEditions.length,
      'languages': languages,
      'formats': formats,
      'types': types,
      'directions': directions,
    };
  }
  
  /// Find edition by identifier
  Future<Edition?> findEditionByIdentifier(String identifier) async {
    final allEditions = await getAllEditions();
    try {
      return allEditions.firstWhere((edition) => edition.identifier == identifier);
    } catch (e) {
      return null;
    }
  }
  
  /// Search editions by name
  Future<List<Edition>> searchEditionsByName(String query) async {
    final allEditions = await getAllEditions();
    final lowercaseQuery = query.toLowerCase();
    
    return allEditions.where((edition) {
      return (edition.name?.toLowerCase() ?? '').contains(lowercaseQuery) ||
             (edition.englishName?.toLowerCase() ?? '').contains(lowercaseQuery);
    }).toList();
  }
  
  /// Get popular editions
  Future<List<Edition>> getPopularEditions() async {
    final allEditions = await getAllEditions();
    
    // Define popular edition identifiers
    final popularIdentifiers = [
      'quran-uthmani', // Uthmani text
      'en.sahih', // Sahih International translation
      'ar.alafasy', // Mishary Rashid Alafasy recitation
      'en.pickthall', // Pickthall translation
      'ar.abdulbasit', // Abdul Basit Abdul Samad recitation
      'en.yusufali', // Yusuf Ali translation
      'ar.ghamdi', // Saad Al-Ghamdi recitation
    ];
    
    final popularEditions = <Edition>[];
    
    for (final identifier in popularIdentifiers) {
      final edition = allEditions.firstWhere(
        (e) => e.identifier == identifier,
        orElse: () => allEditions.first,
      );
      if (edition.identifier == identifier) {
        popularEditions.add(edition);
      }
    }
    
    return popularEditions;
  }
  
  /// Close the service and underlying client
  void close() {
    _client.close();
  }
}
