# Settings Screen Implementation Plan

## 1. Data Layer

### Storage Keys
```dart
class StorageKeys {
  static const String defaultReciter;
  static const String defaultLanguage;
  static const String defaultTranslation;
}
```

### Settings Service
Interface for managing settings persistence:
```dart
abstract class SettingsService {
  Future<String> getDefaultReciter();
  Future<void> setDefaultReciter(String identifier);
  
  Future<String> getDefaultLanguage();
  Future<void> setDefaultLanguage(String language);
  
  Future<String> getDefaultTranslation();
  Future<void> setDefaultTranslation(String identifier);
}
```

## 2. State Management

### Settings Provider
Manages the app-wide settings state:
```dart
class SettingsProvider extends ChangeNotifier {
  String get currentReciter;
  String get currentLanguage;
  String get currentTranslation;
  
  Future<void> loadSettings();
  Future<void> updateReciter(String identifier);
  Future<void> updateLanguage(String language);
  Future<void> updateTranslation(String identifier);
}
```

## 3. UI Components

### Screens
1. **SettingsScreen**
   - Main settings screen with sections for reciter and translation settings
   - Uses Provider for state management

### Widgets
1. **ReciterSection**
   - Dropdown to select default reciter
   - Shows reciter name and identifier
   - Uses RecitationService to fetch available reciters

2. **TranslationSection**
   - Two dropdowns:
     - Language selection
     - Translation edition selection
   - Edition list updates based on selected language
   - Uses TranslationService to fetch available translations

## 4. Default Values
- Reciter: `ar.alafasy`
- Language: `en`
- Translation: `en.sahih`

## 5. Dependencies
- quran_cloud package
  - RecitationService for reciters
  - TranslationService for translations
  - Edition model for data structure
- Provider package for state management
- SharedPreferences for local storage

## 6. Implementation Steps

1. Set up provider and dependencies
2. Implement SettingsService with local storage
3. Create SettingsProvider
4. Build UI components
5. Add navigation to settings
6. Test persistence and state management

## 7. Testing Strategy

1. **Unit Tests**
   - SettingsService methods
   - Provider state updates

2. **Widget Tests**
   - Settings screen navigation
   - Dropdown selections
   - State updates

3. **Integration Tests**
   - Settings persistence
   - Provider integration
