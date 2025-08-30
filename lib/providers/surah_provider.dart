import 'package:flutter/foundation.dart';
import '../models/surah.dart';
import '../services/surah_service.dart';

enum SurahListState { loading, success, error }

class SurahProvider extends ChangeNotifier {
  final SurahService _surahService = SurahService();

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

      // Load surah list from bundled JSON
      _allSurahs = await _surahService.loadSurahList();

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

  /// Get surah by number
  Surah? getSurahByNumber(int number) {
    return _surahService.getSurahByNumber(_allSurahs, number);
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
}
