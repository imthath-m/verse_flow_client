import 'package:flutter/material.dart';
import 'package:quran_cloud/quran_cloud.dart';
import '../services/audio_player_service.dart';

class MediaPlayerViewModel extends ChangeNotifier {
  final AudioPlayerService _audioPlayerService = AudioPlayerService();
  bool _isPlaying = false;
  double _progress = 0.5;
  Surah? _currentSurah;
  String _reciterName = 'Abdul Rahman Al-Sudais';

  bool get isPlaying => _isPlaying;
  double get progress => _progress;
  String get surahName => _currentSurah?.englishName ?? '';
  String get reciterName => _reciterName;
  Surah? get currentSurah => _currentSurah;

  void setSurah(Surah surah) {
    _currentSurah = surah;
    _progress = 0.0;
    _isPlaying = false;
    notifyListeners();
  }

  void togglePlayPause() {
    if (_currentSurah == null) return;

    _isPlaying = !_isPlaying;
    if (_isPlaying) {
      _audioPlayerService.play(_currentSurah!);
    } else {
      _audioPlayerService.pause();
    }
    notifyListeners();
  }

  void setProgress(double value) {
    _progress = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayerService.dispose();
    super.dispose();
  }
}
