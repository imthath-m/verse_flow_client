import 'package:flutter/material.dart';
import 'package:quran_cloud/quran_cloud.dart';
import '../services/audio_player_service.dart';

class MediaPlayerViewModel extends ChangeNotifier {
  final AudioPlayerService _audioPlayerService = AudioPlayerService();
  double _progress = 0.5;
  Surah? _currentSurah;

  MediaPlayerState _state = MediaPlayerState.stopped;
  MediaPlayerState get state => _state;
  double get progress => _progress;
  String get surahName => _currentSurah?.englishName ?? '';
  Surah? get currentSurah => _currentSurah;

  void setSurah(Surah surah) {
    _currentSurah = surah;
    _progress = 0.0;
    _state = MediaPlayerState.stopped;
    notifyListeners();
  }

  void play() {
    if (_currentSurah == null) return;

    _audioPlayerService.play(_currentSurah!);
    _state = MediaPlayerState.playing;
    notifyListeners();
  }

  void pause() {
    if (_state == MediaPlayerState.playing) {
      _audioPlayerService.pause();
      _state = MediaPlayerState.paused;
      notifyListeners();
    }
  }

  void resume() {
    if (_state == MediaPlayerState.paused) {
      _audioPlayerService.resume();
      _state = MediaPlayerState.playing;
      notifyListeners();
    }
  }

  void stop() {
    if (_state != MediaPlayerState.stopped) {
      _audioPlayerService.stop();
      _state = MediaPlayerState.stopped;
      _progress = 0.0;
      notifyListeners();
    }
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

enum MediaPlayerState { playing, paused, stopped }
