import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService instance = StorageService._internal();

  factory StorageService() {
    return instance;
  }

  StorageService._internal();

  static const String _favoritesKey = 'favorites';
  static const String _downloadedSurahsKey = 'downloaded_surahs';
  static const String _defaultLanguageKey = 'default_language';
  static const String _defaultReciterKey = 'default_reciter';
  static const String _defaultTranslationKey = 'default_translation';

  late SharedPreferences _prefs;

  /// Initialize the storage service
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // MARK: - Favorites Management

  /// Get list of favorite surah numbers
  List<int> getFavorites() {
    final String? favoritesJson = _prefs.getString(_favoritesKey);
    if (favoritesJson == null) return [];

    try {
      final List<dynamic> favoritesList = json.decode(favoritesJson);
      return favoritesList.cast<int>();
    } catch (e) {
      return [];
    }
  }

  /// Add surah to favorites
  Future<void> addToFavorites(int surahNumber) async {
    final List<int> favorites = getFavorites();
    if (!favorites.contains(surahNumber)) {
      favorites.add(surahNumber);
      await _prefs.setString(_favoritesKey, json.encode(favorites));
    }
  }

  /// Remove surah from favorites
  Future<void> removeFromFavorites(int surahNumber) async {
    final List<int> favorites = getFavorites();
    favorites.remove(surahNumber);
    await _prefs.setString(_favoritesKey, json.encode(favorites));
  }

  /// Check if surah is favorite
  bool isFavorite(int surahNumber) {
    return getFavorites().contains(surahNumber);
  }

  // MARK: - Downloaded Surahs Management

  /// Get list of downloaded surah numbers
  List<int> getDownloadedSurahs() {
    final String? downloadedJson = _prefs.getString(_downloadedSurahsKey);
    if (downloadedJson == null) return [];

    try {
      final List<dynamic> downloadedList = json.decode(downloadedJson);
      return downloadedList.cast<int>();
    } catch (e) {
      return [];
    }
  }

  /// Mark surah as downloaded
  Future<void> markAsDownloaded(int surahNumber) async {
    final List<int> downloaded = getDownloadedSurahs();
    if (!downloaded.contains(surahNumber)) {
      downloaded.add(surahNumber);
      await _prefs.setString(_downloadedSurahsKey, json.encode(downloaded));
    }
  }

  /// Mark surah as not downloaded
  Future<void> markAsNotDownloaded(int surahNumber) async {
    final List<int> downloaded = getDownloadedSurahs();
    downloaded.remove(surahNumber);
    await _prefs.setString(_downloadedSurahsKey, json.encode(downloaded));
  }

  /// Check if surah is downloaded
  bool isDownloaded(int surahNumber) {
    return getDownloadedSurahs().contains(surahNumber);
  }

  // MARK: - User Preferences

  /// Get default language
  String getDefaultLanguage() {
    return _prefs.getString(_defaultLanguageKey) ?? 'en';
  }

  /// Set default language
  Future<void> setDefaultLanguage(String language) async {
    await _prefs.setString(_defaultLanguageKey, language);
  }

  /// Get default reciter
  String getDefaultReciter() {
    return _prefs.getString(_defaultReciterKey) ?? 'ar.alafasy';
  }

  /// Set default reciter
  Future<void> setDefaultReciter(String reciter) async {
    await _prefs.setString(_defaultReciterKey, reciter);
  }

  /// Get default translation
  String getDefaultTranslation() {
    return _prefs.getString(_defaultTranslationKey) ?? 'en.walk';
  }

  /// Set default translation
  Future<void> setDefaultTranslation(String translation) async {
    await _prefs.setString(_defaultTranslationKey, translation);
  }

  /// Clear all stored data
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
