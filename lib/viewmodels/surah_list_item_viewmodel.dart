import 'package:flutter/foundation.dart';
import '../models/surah.dart';
import '../services/storage_service.dart';

class SurahListItemViewModel extends ChangeNotifier {
  final Surah _surah;
  final StorageService _storageService;

  bool _isFavorite;
  bool _isDownloaded;
  String? _errorMessage;

  SurahListItemViewModel(this._surah, this._storageService)
    : _isFavorite = false,
      _isDownloaded = false {
    _loadPreferences();
  }

  // Getters
  Surah get surah => _surah;
  bool get isFavorite => _isFavorite;
  bool get isDownloaded => _isDownloaded;
  String? get errorMessage => _errorMessage;

  Future<void> _loadPreferences() async {
    try {
      _isFavorite = _storageService.isFavorite(_surah.number);
      _isDownloaded = _storageService.isDownloaded(_surah.number);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> toggleFavorite() async {
    try {
      if (_isFavorite) {
        await _storageService.removeFromFavorites(_surah.number);
      } else {
        await _storageService.addToFavorites(_surah.number);
      }
      _isFavorite = !_isFavorite;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to update favorite: $e';
      notifyListeners();
    }
  }

  Future<void> markAsDownloaded() async {
    try {
      await _storageService.markAsDownloaded(_surah.number);
      _isDownloaded = true;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to mark as downloaded: $e';
      notifyListeners();
    }
  }

  Future<void> markAsNotDownloaded() async {
    try {
      await _storageService.markAsNotDownloaded(_surah.number);
      _isDownloaded = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to mark as not downloaded: $e';
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
