# Quran Package Setup Plan - Al-Quran Cloud API Integration

## 📋 Overview

This document outlines the plan to create a local Flutter package that integrates with the Al-Quran Cloud API to provide all the data requirements for the Quran Audio App MVP. The package will handle fetching Arabic text, recitations, translations, and metadata for the app's core functionality.

---

## 🎯 High-Level Tasks

### 1. **Package Structure & Setup**
- Create Flutter package structure with proper organization
- Set up dependencies and configuration
- Create base models and interfaces

### 2. **API Client Implementation**
- Implement HTTP client for Al-Quran Cloud API
- Handle authentication, rate limiting, and error management
- Create request/response models

### 3. **Data Models & Serialization**
- Create comprehensive data models for all Quran data types
- Implement JSON serialization/deserialization
- Handle Arabic text encoding and Unicode support

### 4. **Core Data Services**
- Implement services for fetching Arabic text
- Implement services for fetching audio recitations
- Implement services for fetching translations and metadata



### 5. **Error Handling & Resilience**
- Implement comprehensive error handling
- Add retry mechanisms and fallback strategies
- Handle network connectivity issues

### 6. **Testing & Documentation**
- Create unit tests for all components
- Add integration tests for API calls
- Document API usage and examples

---

## 📝 Detailed Subtasks

### **Phase 1: Package Structure & Setup**

#### 1.1 Create Package Directory Structure
```
quran_package/
├── lib/
│   ├── src/
│   │   ├── api/
│   │   │   ├── client.dart
│   │   │   ├── endpoints.dart
│   │   │   └── exceptions.dart
│   │   ├── models/
│   │   │   ├── surah.dart
│   │   │   ├── ayah.dart
│   │   │   ├── recitation.dart
│   │   │   ├── translation.dart
│   │   │   ├── language.dart
│   │   │   └── edition.dart
│   │   ├── services/
│   │   │   ├── quran_service.dart
│   │   │   ├── recitation_service.dart
│   │   │   ├── translation_service.dart
│   │   │   └── metadata_service.dart
│   │   └── utils/
│   │       ├── constants.dart
│   │       └── helpers.dart
│   ├── quran_package.dart
│   └── exceptions.dart
├── test/
├── example/
├── pubspec.yaml
└── README.md
```

#### 1.2 Configure pubspec.yaml
- Add HTTP client dependency (dio/http)
- Add JSON serialization dependencies
- Add testing dependencies
- Configure package metadata

#### 1.3 Create Base Models
- Define base interfaces and abstract classes
- Create common response models
- Set up model factories and builders

### **Phase 2: API Client Implementation**

#### 2.1 Research Al-Quran Cloud API
- Study API documentation and endpoints
- Identify required endpoints for MVP functionality
- Understand rate limits and authentication requirements
- Test API responses and data formats

#### 2.2 Implement HTTP Client
```dart
class QuranApiClient {
  // Base URL and configuration
  // Request/response interceptors
  // Error handling middleware
  // Rate limiting implementation
}
```

#### 2.3 Create API Endpoints Configuration
```dart
class ApiEndpoints {
  // Surah list endpoint
  // Ayah text endpoint
  // Audio recitation endpoint
  // Translation endpoint
  // Language/edition metadata endpoints
}
```

#### 2.4 Implement Request/Response Models
- Create request models for different API calls
- Create response models matching API structure
- Handle pagination and large data sets
- Implement data transformation utilities

### **Phase 3: Data Models & Serialization**

#### 3.1 Surah Model Enhancement
```dart
class Surah {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final int numberOfAyahs;
  final String revelationType;
  final List<Ayah>? ayahs;
  final Map<String, dynamic>? additionalData;
}
```

#### 3.2 Ayah Model
```dart
class Ayah {
  final int number;
  final String text;
  final int numberInSurah;
}
```

#### 3.3 Location Model
```dart
class Location {
    final int surahNumber;
    final int ayahNumber;
}
```

#### 3.5 Edition Model
```dart
class Edition {
  final String identifier;
  final String language;
  final String name;
  final String englishName;
  final String format;
  final String type;
  final String direction;
}
```

### **Phase 4: Core Data Services**

#### 4.1 Quran Service (Arabic Text)
```dart
class QuranService {
  Future<List<Surah>> getAllSurahs();
  Future<Surah> getSurah(int number);
  Future<List<Ayah>> getAyahs(int surahNumber);
  Future<List<Ayah>> getAyahs(Location start, Location end);
  Future<Ayah> getAyah(Location location);
}
```

#### 4.2 Recitation Service (Audio)
```dart
class AudioService {
  Future<List<Edition>> getAvailableRecitations();
  Future<List<Edition>> getTranslations(String languageCode);
}
```

#### 4.3 Translation Service
```dart
class TranslationService {
  Future<List<String>> getAvailableLanguages();
  Future<List<Edition>> getEditionsForLanguage(String language);
  Future<List<Ayah>> getTranslationForSurah(String editionId, int surahNumber);
  Future<List<Ayah>> getTranslationForRange(String editionId, Location start, Location end);
  Future<Ayah> getTranslationForAyah(String editionId, Location location)

}
```



### **Phase 6: Error Handling & Resilience**

#### 6.1 Exception Handling
```dart
class QuranApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? endpoint;
  final dynamic originalError;
}

class NetworkException implements Exception {
  final String message;
  final bool isOffline;
  final dynamic originalError;
}
```

#### 6.2 Retry Mechanisms
- Implement exponential backoff for failed requests
- Add circuit breaker pattern for API failures
- Handle partial failures gracefully
- Implement fallback strategies



### **Phase 7: Testing & Documentation**

#### 7.1 Unit Tests
- Test all service methods
- Test data models and serialization
- Test error handling scenarios

#### 7.2 Integration Tests
- Test API client with mock responses
- Test end-to-end data flow
- Test error handling

#### 7.3 Documentation
- API usage examples
- Integration guide
- Configuration options
- Troubleshooting guide

---

## 🔧 Implementation Priority

### **MVP Priority (Phase 1-3)**
1. Basic API client setup
2. Core data models
3. Quran service (Arabic text)
4. Error handling

### **Enhanced Features (Phase 4)**
1. Recitation service
2. Translation service

### **Production Ready (Phase 5-6)**
1. Comprehensive error handling
2. Testing suite
3. Documentation

---

## 📊 API Endpoints Required

Based on Al-Quran Cloud API documentation:

### **Core Endpoints**
- `GET /surah` - List all surahs
- `GET /surah/{number}` - Get specific surah with ayahs
- `GET /ayah/{surah}:{ayah}` - Get specific ayah

### **Audio Endpoints**
- `GET /edition?format=audio&type=versebyverse&language=ar` - List all arabic recitation editions
- `GET /edition?format=audio&type=versebyverse&language={language_code}` - Lists available translation audios. This is available only in a few languages (Only 5 at the time of writing - en, fr, ur, ru, zh)
- Audio can be streamed directly from CDN using edition identifier

### **Translation Endpoints**
- `GET /edition?format=text&type=translation` - List translation editions
- `GET /surah/{number}/{edition}` - Get surah translation
- `GET /ayah/{surah}:{ayah}/{edition}` - Get ayah translation

### **Metadata Endpoints**
- `GET /edition` - List all editions with metadata
- `GET /edition/language` - Lists all languages in which editions are available

---

## 🎯 Success Criteria

1. **Functionality**: All required data types can be fetched from API
2. **Performance**: Fast data access with efficient API calls
3. **Reliability**: Robust error handling and network resilience
4. **Usability**: Simple, intuitive API for the main app
5. **Maintainability**: Well-tested, documented, and extensible code

---

## 📈 Future Enhancements

- Advanced search functionality
- Batch operations for multiple ayahs
- Custom recitation preferences
- Analytics and usage tracking
