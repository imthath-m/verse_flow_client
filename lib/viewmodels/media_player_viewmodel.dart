
import 'package:flutter/material.dart';

class MediaPlayerViewModel extends ChangeNotifier {
  bool _isPlaying = false;
  double _progress = 0.5;
  String _surahName = 'Surah Al-Fatiha';
  String _reciterName = 'Abdul Rahman Al-Sudais';

  bool get isPlaying => _isPlaying;
  double get progress => _progress;
  String get surahName => _surahName;
  String get reciterName => _reciterName;

  void togglePlayPause() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void setProgress(double value) {
    _progress = value;
    notifyListeners();
  }
}
