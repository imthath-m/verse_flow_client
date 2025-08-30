import 'package:dio/dio.dart';
import '../api/client.dart';
import '../api/endpoints.dart';
import '../api/exceptions.dart';
import '../models/surah.dart';
import '../models/ayah.dart';
import '../models/location.dart';

/// Service for fetching Quran text and surah data
class QuranService {
  final QuranApiClient _client;

  /// Creates a new QuranService instance
  QuranService({QuranApiClient? client}) : _client = client ?? QuranApiClient();

  /// Get list of all surahs
  Future<List<Surah>> getAllSurahs() async {
    try {
      final response = await _client.get(ApiEndpoints.surahs);
      final data = response.data as Map<String, dynamic>;

      if (data['code'] != 200) {
        throw QuranApiException(
          data['message'] ?? 'Failed to fetch surahs',
          statusCode: data['code'],
          responseData: data,
        );
      }

      final surahsData = data['data'] as List;
      return surahsData.map((json) => Surah.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.error is QuranCloudException) {
        rethrow;
      }
      throw QuranApiException('Failed to fetch surahs', originalError: e);
    }
  }

  /// Get specific surah by number
  // Future<Surah> getSurah(int number) async {
  //   if (number < 1 || number > 114) {
  //     throw ArgumentError(
  //       'Invalid surah number: $number. Must be between 1 and 114.',
  //     );
  //   }

  //   try {
  //     final response = await _client.get(ApiEndpoints.surah(number));
  //     final data = response.data as Map<String, dynamic>;

  //     if (data['code'] != 200) {
  //       throw QuranApiException(
  //         data['message'] ?? 'Failed to fetch surah $number',
  //         statusCode: data['code'],
  //         responseData: data,
  //       );
  //     }

  //     final surahData = data['data'] as Map<String, dynamic>;
  //     return Surah.fromJson(surahData);
  //   } on DioException catch (e) {
  //     if (e.error is QuranCloudException) {
  //       rethrow;
  //     }
  //     throw QuranApiException(
  //       'Failed to fetch surah $number',
  //       originalError: e,
  //     );
  //   }
  // }

  /// Get ayahs for a specific surah
  // Future<List<Ayah>> getAyahs(int surahNumber) async {
  //   final surah = await getSurah(surahNumber);
  //   return surah.ayahs ?? [];
  // }

  /// Get ayahs for a range of surahs
  // Future<List<Ayah>> getAyahsRange(Location start, Location end) async {
  //   if (!start.isValid || !end.isValid) {
  //     throw ArgumentError('Invalid location range');
  //   }

  //   if (start.surahNumber > end.surahNumber) {
  //     throw ArgumentError('Start surah number cannot be greater than end surah number');
  //   }

  //   final List<Ayah> ayahs = [];

  //   // If same surah, get range within that surah
  //   if (start.surahNumber == end.surahNumber) {
  //     final surah = await getSurah(start.surahNumber);
  //     if (surah.hasAyahs) {
  //       return surah.getAyahsRange(start.ayahNumber, end.ayahNumber);
  //     }
  //   } else {
  //     // Get ayahs from multiple surahs
  //     for (int surahNum = start.surahNumber; surahNum <= end.surahNumber; surahNum++) {
  //       final surah = await getSurah(surahNum);
  //       if (surah.hasAyahs) {
  //         final startAyah = surahNum == start.surahNumber ? start.ayahNumber : 1;
  //         final endAyah = surahNum == end.surahNumber ? end.ayahNumber : surah.numberOfAyahs;
  //         ayahs.addAll(surah.getAyahsRange(startAyah, endAyah));
  //       }
  //     }
  //   }

  //   return ayahs;
  // }

  /// Get specific ayah by location
  Future<Ayah> getAyah(Location location) async {
    if (!location.isValid) {
      throw ArgumentError('Invalid location: $location');
    }

    try {
      final response = await _client.get(
        ApiEndpoints.ayah(location.toString()),
      );
      final data = response.data as Map<String, dynamic>;

      if (data['code'] != 200) {
        throw QuranApiException(
          data['message'] ?? 'Failed to fetch ayah at $location',
          statusCode: data['code'],
          responseData: data,
        );
      }

      final ayahData = data['data'] as Map<String, dynamic>;
      return Ayah.fromJson(ayahData);
    } on DioException catch (e) {
      if (e.error is QuranCloudException) {
        rethrow;
      }
      throw QuranApiException(
        'Failed to fetch ayah at $location',
        originalError: e,
      );
    }
  }

  /// Get specific ayah by surah and ayah numbers
  Future<Ayah> getAyahByNumbers(int surahNumber, int ayahNumber) async {
    return getAyah(Location(surahNumber: surahNumber, ayahNumber: ayahNumber));
  }

  /// Search in Quran text
  Future<List<Ayah>> search(
    String query, {
    String? edition,
    int? page,
    int? size,
  }) async {
    if (query.trim().isEmpty) {
      throw ArgumentError('Search query cannot be empty');
    }

    try {
      final response = await _client.get(
        ApiEndpoints.search(query, edition: edition, page: page, size: size),
      );
      final data = response.data as Map<String, dynamic>;

      if (data['code'] != 200) {
        throw QuranApiException(
          data['message'] ?? 'Search failed',
          statusCode: data['code'],
          responseData: data,
        );
      }

      final searchData = data['data'] as Map<String, dynamic>;
      final matches = searchData['matches'] as List;

      return matches.map((json) => Ayah.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.error is QuranCloudException) {
        rethrow;
      }
      throw QuranApiException('Search failed', originalError: e);
    }
  }

  /// Close the service and underlying client
  void close() {
    _client.close();
  }
}
