import 'package:flutter_test/flutter_test.dart';
import 'package:quran_cloud/quran_cloud.dart';
import 'package:verse_flow_client/services/surah_service.dart';

void main() {
  group('Surah Service Tests', () {
    test('should search surahs by number', () {
      final surahs = [
        Surah(
          number: 1,
          name: 'سُورَةُ ٱلْفَاتِحَةِ',
          englishName: 'Al-Faatiha',
          englishNameTranslation: 'The Opening',
          numberOfAyahs: 7,
          revelationType: 'Meccan',
        ),
        Surah(
          number: 2,
          name: 'سُورَةُ البَقَرَةِ',
          englishName: 'Al-Baqara',
          englishNameTranslation: 'The Cow',
          numberOfAyahs: 286,
          revelationType: 'Medinan',
        ),
      ];

      final service = SurahService();
      final results = service.searchSurahs(surahs, '1');

      expect(results.length, 1);
      expect(results.first.number, 1);
    });

    test('should search surahs by English name', () {
      final surahs = [
        Surah(
          number: 1,
          name: 'سُورَةُ ٱلْفَاتِحَةِ',
          englishName: 'Al-Faatiha',
          englishNameTranslation: 'The Opening',
          numberOfAyahs: 7,
          revelationType: 'Meccan',
        ),
        Surah(
          number: 2,
          name: 'سُورَةُ البَقَرَةِ',
          englishName: 'Al-Baqara',
          englishNameTranslation: 'The Cow',
          numberOfAyahs: 286,
          revelationType: 'Medinan',
        ),
      ];

      final service = SurahService();
      final results = service.searchSurahs(surahs, 'Al-Faatiha');

      expect(results.length, 1);
      expect(results.first.englishName, 'Al-Faatiha');
    });

    test('should return empty list for no matches', () {
      final surahs = [
        Surah(
          number: 1,
          name: 'سُورَةُ ٱلْفَاتِحَةِ',
          englishName: 'Al-Faatiha',
          englishNameTranslation: 'The Opening',
          numberOfAyahs: 7,
          revelationType: 'Meccan',
        ),
      ];

      final service = SurahService();
      final results = service.searchSurahs(surahs, 'nonexistent');

      expect(results.length, 0);
    });

    test('should return all surahs for empty query', () {
      final surahs = [
        Surah(
          number: 1,
          name: 'سُورَةُ ٱلْفَاتِحَةِ',
          englishName: 'Al-Faatiha',
          englishNameTranslation: 'The Opening',
          numberOfAyahs: 7,
          revelationType: 'Meccan',
        ),
        Surah(
          number: 2,
          name: 'سُورَةُ البَقَرَةِ',
          englishName: 'Al-Baqara',
          englishNameTranslation: 'The Cow',
          numberOfAyahs: 286,
          revelationType: 'Medinan',
        ),
      ];

      final service = SurahService();
      final results = service.searchSurahs(surahs, '');

      expect(results.length, 2);
    });
  });
}
