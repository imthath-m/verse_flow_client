import 'package:flutter_test/flutter_test.dart';
import 'package:quran_cloud/quran_cloud.dart';

void main() {
  group('Integration Tests', () {
    late QuranService quranService;
    late TranslationService translationService;
    late RecitationService recitationService;
    late MetadataService metadataService;

    setUp(() {
      quranService = QuranService();
      translationService = TranslationService();
      recitationService = RecitationService();
      metadataService = MetadataService();
    });

    tearDown(() {
      quranService.close();
      translationService.close();
      recitationService.close();
      metadataService.close();
    });

    test('should fetch all surahs from API', () async {
      final surahs = await quranService.getAllSurahs();

      expect(surahs, isNotEmpty);
      expect(surahs.length, 114);

      // Check first surah (Al-Fatiha)
      final firstSurah = surahs.first;
      expect(firstSurah.number, 1);
      expect(firstSurah.name, isNotEmpty); // API returns with diacritics
      expect(firstSurah.englishName, 'Al-Faatiha');
      expect(firstSurah.numberOfAyahs, 7);

      // Check last surah (An-Nas)
      final lastSurah = surahs.last;
      expect(lastSurah.number, 114);
      expect(lastSurah.name, isNotEmpty); // API returns with diacritics
      expect(lastSurah.englishName, 'An-Naas');
    }, timeout: Timeout(Duration(minutes: 2)));

    test('should fetch specific ayah', () async {
      final ayah = await quranService.getAyah(
        Location(surahNumber: 1, ayahNumber: 1),
      );

      expect(ayah.numberInSurah, 1);
      expect(ayah.text, isNotEmpty);
      expect(ayah.text, anyOf(contains('بِسْمِ'), contains('بِسۡمِ')));
    }, timeout: Timeout(Duration(minutes: 2)));

    test('should fetch translation editions', () async {
      final editions = await translationService.getTranslationEditions();

      expect(editions, isNotEmpty);

      // Check that all editions are translations
      for (final edition in editions) {
        expect(edition.isTranslation, true);
        expect(edition.isText, true);
      }

      // Check for English translation
      final englishEditions = editions
          .where((e) => e.language == 'en')
          .toList();
      expect(englishEditions, isNotEmpty);
    }, timeout: Timeout(Duration(minutes: 2)));

    test('should fetch Arabic recitations', () async {
      final recitations = await recitationService.getArabicRecitations();

      expect(recitations, isNotEmpty);

      // Check that we have some recitations
      expect(recitations.isNotEmpty, true);

      // Check that we have at least one Arabic recitation
      final arabicRecitations = recitations
          .where((r) => r.language == 'ar')
          .toList();
      expect(arabicRecitations.isNotEmpty, true);

      // Check for popular reciters
      final alafasy = recitations
          .where((r) => r.identifier == 'ar.alafasy')
          .toList();
      expect(alafasy, isNotEmpty);
    }, timeout: Timeout(Duration(minutes: 2)));

    test('should get audio URL for ayah', () {
      final audioUrl = recitationService.getAudioUrl('ar.alafasy', 1, 1);

      expect(audioUrl, isNotEmpty);
      expect(audioUrl, contains('cdn.islamic.network'));
      expect(audioUrl, contains('ar.alafasy'));
      expect(audioUrl, contains('1/1.mp3'));
    });

    test('should fetch all editions', () async {
      final editions = await metadataService.getAllEditions();

      expect(editions, isNotEmpty);

      // Check for different types
      final textEditions = editions.where((e) => e.isText).toList();
      final audioEditions = editions.where((e) => e.isAudio).toList();

      expect(textEditions, isNotEmpty);
      expect(audioEditions, isNotEmpty);
    }, timeout: Timeout(Duration(minutes: 2)));

    test('should search in Quran text', () async {
      final results = await quranService.search('بِسْمِ');

      expect(results, isNotEmpty);

      // Check that we have some search results
      expect(results.isNotEmpty, true);

      // Check that results contain Arabic text
      for (final ayah in results) {
        expect(ayah.text, isNotEmpty);
        expect(ayah.text, contains('ل')); // Contains Arabic characters (lam)
      }
    }, timeout: Timeout(Duration(minutes: 2)));

    test('should handle invalid location', () async {
      expect(
        () => quranService.getAyah(Location(surahNumber: 0, ayahNumber: 1)),
        throwsArgumentError,
      );

      expect(
        () => quranService.getAyah(Location(surahNumber: 1, ayahNumber: 0)),
        throwsArgumentError,
      );
    });

    test('should handle empty search query', () async {
      expect(() => quranService.search(''), throwsArgumentError);

      expect(() => quranService.search('   '), throwsArgumentError);
    });
  });
}
