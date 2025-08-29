import 'package:flutter_test/flutter_test.dart';
import 'package:verse_flow_client/models/surah.dart';
import 'package:verse_flow_client/services/surah_service.dart';

void main() {
  group('Surah Model Tests', () {
    test('should create Surah from JSON', () {
      final json = {
        'number': 1,
        'name': 'سُورَةُ ٱلْفَاتِحَةِ',
        'englishName': 'Al-Faatiha',
        'englishNameTranslation': 'The Opening',
        'numberOfAyahs': 7,
        'revelationType': 'Meccan',
      };

      final surah = Surah.fromJson(json);

      expect(surah.number, 1);
      expect(surah.name, 'سُورَةُ ٱلْفَاتِحَةِ');
      expect(surah.englishName, 'Al-Faatiha');
      expect(surah.englishNameTranslation, 'The Opening');
      expect(surah.numberOfAyahs, 7);
      expect(surah.revelationType, 'Meccan');
      expect(surah.isFavorite, false);
      expect(surah.isDownloaded, false);
    });

    test('should convert Surah to JSON', () {
      final surah = Surah(
        number: 1,
        name: 'سُورَةُ ٱلْفَاتِحَةِ',
        englishName: 'Al-Faatiha',
        englishNameTranslation: 'The Opening',
        numberOfAyahs: 7,
        revelationType: 'Meccan',
        isFavorite: true,
        isDownloaded: true,
      );

      final json = surah.toJson();

      expect(json['number'], 1);
      expect(json['name'], 'سُورَةُ ٱلْفَاتِحَةِ');
      expect(json['englishName'], 'Al-Faatiha');
      expect(json['englishNameTranslation'], 'The Opening');
      expect(json['numberOfAyahs'], 7);
      expect(json['revelationType'], 'Meccan');
      expect(json['isFavorite'], true);
      expect(json['isDownloaded'], true);
    });

    test('should create copy with new values', () {
      final original = Surah(
        number: 1,
        name: 'سُورَةُ ٱلْفَاتِحَةِ',
        englishName: 'Al-Faatiha',
        englishNameTranslation: 'The Opening',
        numberOfAyahs: 7,
        revelationType: 'Meccan',
      );

      final copy = original.copyWith(
        isFavorite: true,
        isDownloaded: true,
      );

      expect(copy.number, original.number);
      expect(copy.name, original.name);
      expect(copy.isFavorite, true);
      expect(copy.isDownloaded, true);
    });
  });

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
