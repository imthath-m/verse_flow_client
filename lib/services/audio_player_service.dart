import 'package:quran_cloud/quran_cloud.dart';
import 'storage_service.dart';

class AudioPlayer {
  final _audioService = AudioService();
  final _storageService = StorageService();

  void play(Surah surah) async {
    // Implementation to play the audio item
    final List<String> audioUrls = await _audioService.getSurahAudioUrls(
      surahNumber: surah.number,
      editionIdentifier: _storageService.getDefaultReciter(),
    );
  }
}
