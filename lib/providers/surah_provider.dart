import 'package:flutter/foundation.dart';
import '../models/surah.dart';
import '../services/surah_service.dart';
import '../services/storage_service.dart';

enum SurahListState { loading, success, error }

class SurahProvider extends ChangeNotifier {
  final SurahService _surahService = SurahService();
  final StorageService _storageService = StorageService();
  
  // State variables
  SurahListState _state = SurahListState.loading;
  List<Surah> _allSurahs = [];
  List<Surah> _filteredSurahs = [];
  String _searchQuery = '';
  String? _errorMessage;
  
  // Getters
  SurahListState get state => _state;
  List<Surah> get allSurahs => _allSurahs;
  List<Surah> get filteredSurahs => _filteredSurahs;
  String get searchQuery => _searchQuery;
  String? get errorMessage => _errorMessage;
  
  /// Initialize the provider and load data
  Future<void> initialize() async {
    try {
      _setState(SurahListState.loading);
      
      // Initialize storage service
      await _storageService.init();
      
      // Load surah list from bundled JSON
      _allSurahs = await _surahService.loadSurahList();
      
      // Update with stored preferences
      _allSurahs = _storageService.updateSurahsWithPreferences(_allSurahs);
      
      // Set filtered surahs to all surahs initially
      _filteredSurahs = List.from(_allSurahs);
      
      _setState(SurahListState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(SurahListState.error);
    }
  }
  
  /// Search surahs by query
  void searchSurahs(String query) {
    _searchQuery = query;
    
    if (query.isEmpty) {
      _filteredSurahs = List.from(_allSurahs);
    } else {
      _filteredSurahs = _surahService.searchSurahs(_allSurahs, query);
    }
    
    notifyListeners();
  }
  
  /// Clear search
  void clearSearch() {
    _searchQuery = '';
    _filteredSurahs = List.from(_allSurahs);
    notifyListeners();
  }
  
  /// Toggle favorite status for a surah
  Future<void> toggleFavorite(Surah surah) async {
    try {
      if (surah.isFavorite) {
        await _storageService.removeFromFavorites(surah.number);
      } else {
        await _storageService.addToFavorites(surah.number);
      }
      
      // Update the surah in both lists
      _updateSurahInList(_allSurahs, surah.number, !surah.isFavorite, null);
      _updateSurahInList(_filteredSurahs, surah.number, !surah.isFavorite, null);
      
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to update favorite: $e';
      notifyListeners();
    }
  }
  
  /// Mark surah as downloaded
  Future<void> markAsDownloaded(int surahNumber) async {
    try {
      await _storageService.markAsDownloaded(surahNumber);
      
      // Update the surah in both lists
      _updateSurahInList(_allSurahs, surahNumber, null, true);
      _updateSurahInList(_filteredSurahs, surahNumber, null, true);
      
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to mark as downloaded: $e';
      notifyListeners();
    }
  }
  
  /// Mark surah as not downloaded
  Future<void> markAsNotDownloaded(int surahNumber) async {
    try {
      await _storageService.markAsNotDownloaded(surahNumber);
      
      // Update the surah in both lists
      _updateSurahInList(_allSurahs, surahNumber, null, false);
      _updateSurahInList(_filteredSurahs, surahNumber, null, false);
      
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to mark as not downloaded: $e';
      notifyListeners();
    }
  }
  
  /// Get surah by number
  Surah? getSurahByNumber(int number) {
    return _surahService.getSurahByNumber(_allSurahs, number);
  }
  
  /// Get favorite surahs
  List<Surah> getFavoriteSurahs() {
    return _allSurahs.where((surah) => surah.isFavorite).toList();
  }
  
  /// Get downloaded surahs
  List<Surah> getDownloadedSurahs() {
    return _allSurahs.where((surah) => surah.isDownloaded).toList();
  }
  
  /// Refresh data
  Future<void> refresh() async {
    await initialize();
  }
  
  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
  
  // Private helper methods
  
  void _setState(SurahListState newState) {
    _state = newState;
    notifyListeners();
  }
  
  void _updateSurahInList(List<Surah> list, int surahNumber, bool? isFavorite, bool? isDownloaded) {
    final index = list.indexWhere((surah) => surah.number == surahNumber);
    if (index != -1) {
      final surah = list[index];
      list[index] = surah.copyWith(
        isFavorite: isFavorite ?? surah.isFavorite,
        isDownloaded: isDownloaded ?? surah.isDownloaded,
      );
    }
  }
}
