import 'package:dio/dio.dart';
import '../api/client.dart';
import '../api/endpoints.dart';
import '../api/exceptions.dart';
import '../models/edition.dart';
import '../models/recitation.dart';

/// Service for fetching audio recitations and metadata
class AudioService {
  final QuranApiClient _client;

  /// Creates a new RecitationService instance
  AudioService({QuranApiClient? client}) : _client = client ?? QuranApiClient();

  /// Get all available audio recitation editions
  Future<List<AudioEdition>> getAvailableRecitations() async {
    try {
      final response = await _client.get(
        ApiEndpoints.audioEditions(language: 'ar'),
      );
      final data = response.data as Map<String, dynamic>;

      if (data['code'] != 200) {
        throw QuranApiException(
          data['message'] ?? 'Failed to fetch recitation editions',
          statusCode: data['code'],
          responseData: data,
        );
      }

      final editionsData = data['data'] as List;
      return editionsData.map((json) => AudioEdition.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.error is QuranCloudException) {
        rethrow;
      }
      throw QuranApiException(
        'Failed to fetch recitation editions',
        originalError: e,
      );
    }
  }

  /// Get audio recitations for a specific language
  Future<List<AudioEdition>> getRecitationsForLanguage(
    String languageCode,
  ) async {
    try {
      final response = await _client.get(
        ApiEndpoints.audioEditions(language: languageCode),
      );
      final data = response.data as Map<String, dynamic>;

      if (data['code'] != 200) {
        throw QuranApiException(
          data['message'] ??
              'Failed to fetch recitations for language $languageCode',
          statusCode: data['code'],
          responseData: data,
        );
      }

      final editionsData = data['data'] as List;
      return editionsData.map((json) => AudioEdition.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.error is QuranCloudException) {
        rethrow;
      }
      throw QuranApiException(
        'Failed to fetch recitations for language $languageCode',
        originalError: e,
      );
    }
  }

  /// Get Arabic recitations (most common use case)
  Future<List<AudioEdition>> getArabicRecitations() async {
    return getRecitationsForLanguage('ar');
  }

  /// Get translation audio recitations (limited languages available)
  Future<List<AudioEdition>> getTranslationRecitations() async {
    final allRecitations = await getAvailableRecitations();
    return allRecitations.where((edition) => edition.language != 'ar').toList();
  }

  /// Get best Arabic recitation edition
  Future<AudioEdition?> getBestArabicRecitation() async {
    final recitations = await getArabicRecitations();

    if (recitations.isEmpty) return null;

    // Try to find a well-known reciter
    final wellKnownIdentifiers = [
      'ar.alafasy', // Mishary Rashid Alafasy
      'ar.abdulbasit', // Abdul Basit Abdul Samad
      'ar.ghamdi', // Saad Al-Ghamdi
      'ar.sudais', // Abdul Rahman Al-Sudais
      'ar.shuraim', // Saud Al-Shuraim
    ];

    for (final identifier in wellKnownIdentifiers) {
      final recitation = recitations.firstWhere(
        (r) => r.identifier == identifier,
        orElse: () => recitations.first,
      );
      if (recitation.identifier == identifier) {
        return recitation;
      }
    }

    // Return the first available recitation
    return recitations.first;
  }

  /// Get the list of audio URLs for all verses in a surah
  /// [surahNumber] is the number of the surah (1-114)
  /// [editionIdentifier] is the identifier of the audio edition (e.g. 'ar.alafasy')
  /// [numberOfVerses] is the total number of verses in the surah
  /// [quality] is the bitrate of the audio files (32, 40, 48, 64, 128, or 192)
  Future<List<String>> getSurahAudioUrls({
    required int surahNumber,
    String editionIdentifier = 'ar.alafasy',
    String? translationIdentifier,
  }) async {
    try {
      // Get the first verse to validate the edition and get the correct verse numbers
      final location = '$surahNumber:1/$editionIdentifier';
      final response = await _client.get(ApiEndpoints.ayah(location));
      final data = response.data as Map<String, dynamic>;

      if (data['code'] != 200) {
        throw QuranApiException(
          data['message'] ?? 'Failed to fetch audio URL',
          statusCode: data['code'],
          responseData: data,
        );
      }

      // Extract verse number from the response
      final responseData = data['data'] as Map<String, dynamic>;
      final firstVerseNumber = responseData['number'] as int;
      final surahInfo = responseData['surah'] as Map<String, dynamic>;
      final numberOfVerses = surahInfo['numberOfAyahs'] as int;

      // Generate URLs for all verses using the CDN pattern
      List<String> urls = [];
      for (int i = 0; i < numberOfVerses; i++) {
        final verseNumber = firstVerseNumber + i;
        final url =
            'https://cdn.islamic.network/quran/audio/128/$editionIdentifier/$verseNumber.mp3';
        urls.add(url);
        if (translationIdentifier != null) {
          // Add translation audio URL if provided
          final translationUrl =
              'https://cdn.islamic.network/quran/audio/192/$translationIdentifier/$verseNumber.mp3';
          urls.add(translationUrl);
        }
      }

      return urls;
    } on DioException catch (e) {
      if (e.error is QuranCloudException) {
        rethrow;
      }
      throw QuranApiException(
        'Failed to fetch audio URLs for surah $surahNumber',
        originalError: e,
      );
    }
  }

  /// Get audio URL for a specific ayah
  String getAudioUrl(String editionId, int surahNumber, int ayahNumber) {
    // Audio files are served directly from CDN
    return 'https://cdn.islamic.network/quran/audio/$editionId/$surahNumber/$ayahNumber.mp3';
  }

  /// Get audio URL for a specific ayah with location
  String getAudioUrlForLocation(String editionId, String location) {
    final parts = location.split(':');
    if (parts.length != 2) {
      throw ArgumentError('Invalid location format. Expected "surah:ayah"');
    }

    final surahNumber = int.parse(parts[0]);
    final ayahNumber = int.parse(parts[1]);

    return getAudioUrl(editionId, surahNumber, ayahNumber);
  }

  /// Get audio URL for a range of ayahs
  List<String> getAudioUrlsForRange(
    String editionId,
    int surahNumber,
    int startAyah,
    int endAyah,
  ) {
    final urls = <String>[];

    for (int ayah = startAyah; ayah <= endAyah; ayah++) {
      urls.add(getAudioUrl(editionId, surahNumber, ayah));
    }

    return urls;
  }

  /// Get audio URL for an entire surah
  List<String> getAudioUrlsForSurah(
    String editionId,
    int surahNumber,
    int surahAyahs,
  ) {
    return getAudioUrlsForRange(editionId, surahNumber, 1, surahAyahs);
  }

  /// Create a Recitation object for a specific ayah
  Recitation createRecitation({
    required String editionId,
    required String reciter,
    required int surahNumber,
    required int ayahNumber,
    String format = 'mp3',
    String quality = 'high',
    int? duration,
    int? fileSize,
  }) {
    return Recitation(
      audioUrl: getAudioUrl(editionId, surahNumber, ayahNumber),
      edition: editionId,
      reciter: reciter,
      format: format,
      quality: quality,
      duration: duration,
      fileSize: fileSize,
    );
  }

  /// Get popular reciters
  List<String> getPopularReciters() {
    return [
      'Mishary Rashid Alafasy',
      'Abdul Basit Abdul Samad',
      'Saad Al-Ghamdi',
      'Abdul Rahman Al-Sudais',
      'Saud Al-Shuraim',
      'Mahmoud Khalil Al-Husary',
      'Muhammad Siddiq Al-Minshawi',
      'Ahmed Al-Ajmi',
    ];
  }

  /// Get recitation by reciter name
  Future<AudioEdition?> getRecitationByReciter(String reciterName) async {
    final recitations = await getArabicRecitations();

    // Try to find by name (case insensitive)
    final recitation = recitations.firstWhere(
      (r) =>
          (r.name.toLowerCase()).contains(reciterName.toLowerCase()) ||
          (r.englishName.toLowerCase()).contains(reciterName.toLowerCase()),
      orElse: () => recitations.first,
    );

    return recitation;
  }

  /// Close the service and underlying client
  void close() {
    _client.close();
  }
}
