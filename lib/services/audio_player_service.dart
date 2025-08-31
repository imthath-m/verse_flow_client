import 'package:quran_cloud/quran_cloud.dart';
import 'package:just_audio/just_audio.dart';
import 'storage_service.dart';

class AudioPlayerService {
  final _audioService = AudioService();
  final _storageService = StorageService();
  final _player = AudioPlayer();

  void play(Surah surah) async {
    final List<String> audioUrls = await _audioService.getSurahAudioUrls(
      surahNumber: surah.number,
      editionIdentifier: _storageService.getDefaultReciter(),
    );
    await _streamAudioSequentially(audioUrls);
  }

  Future<void> _streamAudioSequentially(List<String> urls) async {
    try {
      // Create playlist
      final playlist = ConcatenatingAudioSource(
        children: urls.map((url) => AudioSource.uri(Uri.parse(url))).toList(),
      );

      // Load and start playing
      await _player.setAudioSource(playlist);
      await _player.play();
    } catch (e) {
      print('Error streaming audio: $e');
    }
  }

  // Don't forget to dispose
  void dispose() {
    _player.dispose();
  }
}
