import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/surah.dart';

class SurahService {
  static const String _surahListPath = 'assets/data/surah_list.json';
  
  List<Surah>? _cachedSurahs;
  
  /// Load surah list from bundled JSON file
  Future<List<Surah>> loadSurahList() async {
    try {
      // Return cached data if available
      if (_cachedSurahs != null) {
        return _cachedSurahs!;
      }
      
      // Load JSON from assets
      final String jsonString = await rootBundle.loadString(_surahListPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      
      // Parse surah list
      final List<dynamic> surahList = jsonData['data'] as List<dynamic>;
      _cachedSurahs = surahList
          .map((json) => Surah.fromJson(json as Map<String, dynamic>))
          .toList();
      
      return _cachedSurahs!;
    } catch (e) {
      throw Exception('Failed to load surah list: $e');
    }
  }
  
  /// Search surahs by query (number, name, or translation)
  List<Surah> searchSurahs(List<Surah> surahs, String query) {
    if (query.isEmpty) return surahs;
    
    final String lowerQuery = query.toLowerCase();
    
    return surahs.where((surah) {
      return surah.number.toString().contains(lowerQuery) ||
             surah.name.toLowerCase().contains(lowerQuery) ||
             surah.englishName.toLowerCase().contains(lowerQuery) ||
             surah.englishNameTranslation.toLowerCase().contains(lowerQuery);
    }).toList();
  }
  
  /// Get surah by number
  Surah? getSurahByNumber(List<Surah> surahs, int number) {
    try {
      return surahs.firstWhere((surah) => surah.number == number);
    } catch (e) {
      return null;
    }
  }
  
  /// Clear cached data (useful for testing or memory management)
  void clearCache() {
    _cachedSurahs = null;
  }
}
