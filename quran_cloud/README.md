# Quran Cloud Package

A Flutter package for integrating with the Al-Quran Cloud API to provide Quran data, recitations, and translations.

## Features

- 📖 **Quran Text**: Fetch Arabic text and surah metadata
- 🎵 **Audio Recitations**: Get audio URLs for various reciters
- 🌍 **Translations**: Access translations in multiple languages
- 🔍 **Search**: Search through Quran text
- 📊 **Metadata**: Get comprehensive edition and language information
- 🛡️ **Error Handling**: Robust error handling with retry mechanisms
- ⚡ **Performance**: Optimized HTTP client with caching support

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  quran_cloud: ^1.0.0
```

## Quick Start

### Basic Usage

```dart
import 'package:quran_cloud/quran_cloud.dart';

void main() async {
  // Create services
  final quranService = QuranService();
  final translationService = TranslationService();
  final recitationService = RecitationService();
  
  try {
    // Get all surahs
    final surahs = await quranService.getAllSurahs();
    print('Found ${surahs.length} surahs');
    
    // Get specific surah with ayahs
    final surah = await quranService.getSurah(1); // Al-Fatiha
    print('Surah ${surah.name}: ${surah.numberOfAyahs} ayahs');
    
    // Get translation
    final translations = await translationService.getTranslationEditions();
    final englishTranslation = translations.firstWhere((e) => e.language == 'en');
    final translatedAyahs = await translationService.getTranslationForSurah(
      englishTranslation.identifier, 
      1
    );
    
    // Get audio recitation
    final recitations = await recitationService.getArabicRecitations();
    final alafasy = recitations.firstWhere((r) => r.identifier == 'ar.alafasy');
    final audioUrl = recitationService.getAudioUrl(alafasy.identifier, 1, 1);
    
  } catch (e) {
    print('Error: $e');
  } finally {
    // Clean up
    quranService.close();
    translationService.close();
    recitationService.close();
  }
}
```

## Services

### QuranService

Handles fetching Arabic text and surah data.

```dart
final quranService = QuranService();

// Get all surahs
final surahs = await quranService.getAllSurahs();

// Get specific surah
final surah = await quranService.getSurah(1);

// Get specific ayah
final ayah = await quranService.getAyah(Location(surahNumber: 1, ayahNumber: 1));

// Search in Quran
final results = await quranService.search('بسم الله');
```

### TranslationService

Handles fetching translations and language metadata.

```dart
final translationService = TranslationService();

// Get available languages
final languages = await translationService.getAvailableLanguages();

// Get translation editions
final editions = await translationService.getTranslationEditions();

// Get translation for surah
final translatedAyahs = await translationService.getTranslationForSurah(
  'en.sahih', 
  1
);

// Get best translation for language
final bestTranslation = await translationService.getBestTranslationForLanguage('en');
```

### RecitationService

Handles fetching audio recitations and metadata.

```dart
final recitationService = RecitationService();

// Get Arabic recitations
final recitations = await recitationService.getArabicRecitations();

// Get best recitation
final bestRecitation = await recitationService.getBestArabicRecitation();

// Get audio URL
final audioUrl = recitationService.getAudioUrl('ar.alafasy', 1, 1);

// Get audio URLs for range
final audioUrls = recitationService.getAudioUrlsForRange('ar.alafasy', 1, 1, 7);
```

### MetadataService

Handles fetching general metadata and information.

```dart
final metadataService = MetadataService();

// Get all editions
final allEditions = await metadataService.getAllEditions();

// Get editions by format
final textEditions = await metadataService.getTextEditions();
final audioEditions = await metadataService.getAudioEditions();

// Get statistics
final stats = await metadataService.getEditionStatistics();

// Search editions
final searchResults = await metadataService.searchEditionsByName('Sahih');
```

## Models

### Location

Represents a location in the Quran (surah and ayah).

```dart
final location = Location(surahNumber: 1, ayahNumber: 1);
print(location.toString()); // "1:1"

// Create from string
final location2 = Location.fromString("1:1");
```

### Surah

Represents a surah (chapter) of the Quran.

```dart
final surah = Surah(
  number: 1,
  name: "الفاتحة",
  englishName: "Al-Fatiha",
  englishNameTranslation: "The Opening",
  numberOfAyahs: 7,
  revelationType: "Meccan",
);

print(surah.isMeccan); // true
print(surah.hasAyahs); // false (if ayahs not loaded)
```

### Ayah

Represents an individual ayah (verse) of the Quran.

```dart
final ayah = Ayah(
  number: 1,
  numberInSurah: 1,
  juz: 1,
  manzil: 1,
  page: 1,
  ruku: 1,
  hizbQuarter: 1,
  text: "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
);

print(ayah.surahNumber); // 1
print(ayah.ayahNumber); // 1
```

### Edition

Represents an edition of the Quran (text, audio, or translation).

```dart
final edition = Edition(
  identifier: "en.sahih",
  language: "en",
  name: "Sahih International",
  englishName: "Sahih International",
  format: "text",
  type: "translation",
  direction: "ltr",
);

print(edition.isText); // true
print(edition.isTranslation); // true
print(edition.isLTR); // true
```

## Error Handling

The package provides comprehensive error handling:

```dart
try {
  final surah = await quranService.getSurah(1);
} on QuranApiException catch (e) {
  print('API Error: ${e.message} (Status: ${e.statusCode})');
} on NetworkException catch (e) {
  print('Network Error: ${e.message} (Offline: ${e.isOffline})');
} on RateLimitException catch (e) {
  print('Rate Limited: ${e.message} (Retry after: ${e.retryAfter})');
} on DataException catch (e) {
  print('Data Error: ${e.message} (Field: ${e.field})');
}
```

## Configuration

You can customize the API client behavior:

```dart
final client = QuranApiClient(
  timeout: Duration(seconds: 60),
  retryAttempts: 5,
  retryDelay: Duration(seconds: 2),
  userAgent: 'MyApp/1.0.0',
);

final quranService = QuranService(client: client);
```

## API Endpoints

The package supports all major Al-Quran Cloud API endpoints:

- `GET /surah` - List all surahs
- `GET /surah/{number}` - Get specific surah with ayahs
- `GET /ayah/{surah}:{ayah}` - Get specific ayah
- `GET /edition` - List all editions
- `GET /edition?format=audio&type=versebyverse` - List audio recitations
- `GET /edition?format=text&type=translation` - List translations
- `GET /surah/{number}/{edition}` - Get surah with specific edition
- `GET /search/{query}` - Search in Quran text

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## License

This package is licensed under the MIT License.

## Support

For support and questions, please open an issue on the GitHub repository.
