import 'package:flutter_test/flutter_test.dart';
import 'package:quran_cloud/quran_cloud.dart';

void main() {
  group('Location Model Tests', () {
    test('should create location with valid parameters', () {
      final location = Location(surahNumber: 1, ayahNumber: 1);
      expect(location.surahNumber, 1);
      expect(location.ayahNumber, 1);
      expect(location.isValid, true);
    });

    test('should create location from string', () {
      final location = Location.fromString('1:1');
      expect(location.surahNumber, 1);
      expect(location.ayahNumber, 1);
    });

    test('should throw error for invalid location string', () {
      expect(() => Location.fromString('invalid'), throwsArgumentError);
    });

    test('should convert to string correctly', () {
      final location = Location(surahNumber: 1, ayahNumber: 1);
      expect(location.toString(), '1:1');
    });

    test('should validate location correctly', () {
      expect(Location(surahNumber: 1, ayahNumber: 1).isValid, true);
      expect(Location(surahNumber: 114, ayahNumber: 6).isValid, true);
      expect(Location(surahNumber: 0, ayahNumber: 1).isValid, false);
      expect(Location(surahNumber: 1, ayahNumber: 0).isValid, false);
      expect(Location(surahNumber: 115, ayahNumber: 1).isValid, false);
    });
  });

  group('Surah Model Tests', () {
    test('should create surah with valid parameters', () {
      final surah = Surah(
        number: 1,
        name: 'الفاتحة',
        englishName: 'Al-Fatiha',
        englishNameTranslation: 'The Opening',
        numberOfAyahs: 7,
        revelationType: 'Meccan',
      );

      expect(surah.number, 1);
      expect(surah.name, 'الفاتحة');
      expect(surah.englishName, 'Al-Fatiha');
      expect(surah.numberOfAyahs, 7);
    });
  });

  group('Edition Model Tests', () {
    test('should create edition with valid parameters', () {
      final edition = AudioEdition(
        identifier: 'en.sahih',
        language: 'en',
        name: 'Sahih International',
        englishName: 'Sahih International',
        format: 'text',
        type: 'translation',
        direction: 'ltr',
      );

      expect(edition.identifier, 'en.sahih');
      expect(edition.language, 'en');
      expect(edition.isText, true);
      expect(edition.isAudio, false);
      expect(edition.isTranslation, true);
      expect(edition.isQuran, false);
      expect(edition.isLTR, true);
      expect(edition.isRTL, false);
    });

    test('should check format correctly', () {
      final textEdition = AudioEdition(
        identifier: 'test',
        language: 'en',
        name: 'Test',
        englishName: 'Test',
        format: 'text',
        type: 'translation',
        direction: 'ltr',
      );

      final audioEdition = AudioEdition(
        identifier: 'test',
        language: 'ar',
        name: 'Test',
        englishName: 'Test',
        format: 'audio',
        type: 'versebyverse',
        direction: 'rtl',
      );

      expect(textEdition.isText, true);
      expect(textEdition.isAudio, false);
      expect(audioEdition.isText, false);
      expect(audioEdition.isAudio, true);
    });
  });

  group('Language Model Tests', () {
    test('should create language with valid parameters', () {
      final language = Language(
        code: 'en',
        name: 'English',
        nativeName: 'English',
        direction: 'ltr',
        editionsCount: 5,
      );

      expect(language.code, 'en');
      expect(language.name, 'English');
      expect(language.isLTR, true);
      expect(language.isRTL, false);
      expect(language.isEnglish, true);
      expect(language.isArabic, false);
    });

    test('should check language properties correctly', () {
      final arabicLanguage = Language(
        code: 'ar',
        name: 'Arabic',
        nativeName: 'العربية',
        direction: 'rtl',
        editionsCount: 10,
      );

      expect(arabicLanguage.isArabic, true);
      expect(arabicLanguage.isEnglish, false);
      expect(arabicLanguage.isRTL, true);
      expect(arabicLanguage.isLTR, false);
    });
  });

  group('QuranCloudHelpers Tests', () {
    test('should validate surah numbers correctly', () {
      expect(QuranCloudHelpers.isValidSurahNumber(1), true);
      expect(QuranCloudHelpers.isValidSurahNumber(114), true);
      expect(QuranCloudHelpers.isValidSurahNumber(0), false);
      expect(QuranCloudHelpers.isValidSurahNumber(115), false);
    });

    test('should validate ayah numbers correctly', () {
      expect(QuranCloudHelpers.isValidAyahNumber(1), true);
      expect(QuranCloudHelpers.isValidAyahNumber(286), true);
      expect(QuranCloudHelpers.isValidAyahNumber(0), false);
      expect(QuranCloudHelpers.isValidAyahNumber(-1), false);
    });

    test('should format location correctly', () {
      expect(QuranCloudHelpers.formatLocation(1, 1), '1:1');
      expect(QuranCloudHelpers.formatLocation(114, 6), '114:6');
    });

    test('should parse location correctly', () {
      final result1 = QuranCloudHelpers.parseLocation('1:1');
      expect(result1?['surahNumber'], 1);
      expect(result1?['ayahNumber'], 1);

      final result2 = QuranCloudHelpers.parseLocation('114:6');
      expect(result2?['surahNumber'], 114);
      expect(result2?['ayahNumber'], 6);

      expect(QuranCloudHelpers.parseLocation('invalid'), null);
      expect(QuranCloudHelpers.parseLocation('1:1:1'), null);
      expect(QuranCloudHelpers.parseLocation('1:0'), null);
      expect(QuranCloudHelpers.parseLocation('0:1'), null);
    });

    test('should calculate backoff delay correctly', () {
      final baseDelay = Duration(seconds: 1);

      expect(
        QuranCloudHelpers.calculateBackoffDelay(0, baseDelay: baseDelay),
        Duration(milliseconds: 1000),
      );
      expect(
        QuranCloudHelpers.calculateBackoffDelay(1, baseDelay: baseDelay),
        Duration(milliseconds: 2000),
      );
      expect(
        QuranCloudHelpers.calculateBackoffDelay(2, baseDelay: baseDelay),
        Duration(milliseconds: 4000),
      );
      expect(
        QuranCloudHelpers.calculateBackoffDelay(3, baseDelay: baseDelay),
        Duration(milliseconds: 8000),
      );
    });
  });

  group('Constants Tests', () {
    test('should have correct base URL', () {
      expect(QuranCloudConstants.baseUrl, 'https://api.alquran.cloud/v1');
    });

    test('should have correct default timeout', () {
      expect(QuranCloudConstants.defaultTimeout, Duration(seconds: 30));
    });

    test('should have correct default retry attempts', () {
      expect(QuranCloudConstants.defaultRetryAttempts, 3);
    });

    test('should have correct language codes', () {
      expect(QuranCloudConstants.defaultArabicLanguage, 'ar');
      expect(QuranCloudConstants.defaultEnglishLanguage, 'en');
    });
  });
}
