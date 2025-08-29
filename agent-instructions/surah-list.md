# Surah List Screen - Implementation Plan

## 📋 Task Breakdown: Surah List Screen

Based on the PRD analysis, here are the detailed tasks required to build the Surah List Screen:

### 🏗️ **Phase 1: Project Setup & Dependencies**

1. **Update pubspec.yaml with required dependencies**
   - Add state management (Provider/Riverpod)
   - Add local storage (SharedPreferences/Hive)
   - Add search functionality dependencies

2. **Create project structure**
   - Set up folder organization (models, services, screens, widgets, utils)
   - Create base theme and styling constants

3. **Bundle static surah data**
   - Refer `assets/data/surah_list.json` with all 114 surahs
   - Update pubspec.yaml to include assets
   - Create data loading service for static JSON

### 📊 **Phase 2: Data Models & Services**

4. **Create Surah data model**
   ```dart
   class Surah {
     final int number;
     final String name; // Arabic name
     final String englishName;
     final String englishNameTranslation;
     final int numberOfAyahs;
     final String revelationType;
     // Additional properties for app functionality
     bool isFavorite;
   }
   ```
   - JSON serialization/deserialization
   - Factory constructor from JSON

5. **Create static data service**
   - Service to load surah list from bundled JSON
   - Handle loading states and error handling
   - Cache loaded data in memory

6. **Create local storage service**
   - Store user preferences (default language, reciter, etc.)
   - Store downloaded surahs status
   - Store favorites

### 🎨 **Phase 3: UI Components**

7. **Create Surah List Item Widget**
   - Display surah number, Arabic name, and translated name
   - Visual indicator for downloaded status
   - Favorite heart icon
   - Tap handling for navigation

8. **Create Search Bar Widget**
   - Text input with search functionality
   - Filter by surah name (Arabic/translated) or number
   - Clear search functionality

9. **Create Custom Button Widget**
   - Floating action button or prominent button
   - Navigate to Audio Configuration Modal

### 📱 **Phase 4: Main Screen Implementation**

10. **Create Surah List Screen**
    - Scaffold with app bar
    - Search bar at the top
    - Scrollable list of all 114 surahs
    - Custom button for audio configuration
    - Loading states and error handling

11. **Implement search functionality**
    - Real-time filtering as user types
    - Search by surah number or name
    - Case-insensitive search

12. **Implement navigation**
    - Tap surah → Navigate to Audio Configuration Modal
    - Custom button → Navigate to Audio Configuration Modal
    - Handle back navigation

### ⚙️ **Phase 5: State Management & Logic**

13. **Implement state management**
    - Load surah list from bundled JSON on app start
    - Handle loading, success, and error states
    - Manage search state and filtered results

14. **Implement favorites functionality**
    - Heart icon toggle
    - Store favorite status locally
    - Visual indication of favorite surahs

15. **Implement download status**
    - Track which surahs are downloaded
    - Show download indicator icon
    - Handle offline/online states

### 🎯 **Phase 6: Polish & UX**

16. **Add loading and error states**
    - Loading spinner while fetching data
    - Error message with retry option
    - Empty state when search returns no results

17. **Implement responsive design**
    - Optimize for different screen sizes
    - Handle orientation changes
    - Ensure accessibility

18. **Add animations and transitions**
    - Smooth list scrolling
    - Tap feedback animations
    - Search bar animations

### 🔧 **Phase 7: Integration & Testing**

19. **Integrate with Audio Configuration Modal**
    - Pass selected surah data
    - Handle navigation flow
    - Maintain state consistency

20. **Add unit tests**
    - Test data models
    - Test search functionality
    - Test state management

21. **Add widget tests**
    - Test Surah List Screen
    - Test individual components
    - Test navigation flows

---

## 📁 **File Structure Plan**

```
lib/
├── main.dart
├── models/
│   └── surah.dart
├── services/
│   ├── surah_service.dart
│   └── storage_service.dart
├── screens/
│   └── surah_list_screen.dart
├── widgets/
│   ├── surah_list_item.dart
│   ├── search_bar.dart
│   └── custom_button.dart
├── utils/
│   ├── constants.dart
│   └── theme.dart
└── providers/
    └── surah_provider.dart

assets/
└── data/
    └── surah_list.json
```

## 🎯 **Key Implementation Details**

### Static Data Location
- **File**: `assets/data/surah_list.json`
- **Access**: Load via `rootBundle.loadString('assets/data/surah_list.json')`
- **Benefits**: 
  - No network dependency for surah list
  - Faster app startup
  - Works offline
  - Consistent data across app versions

### Search Functionality
- Search by surah number (1-114)
- Search by Arabic name (سُورَةُ ٱلْفَاتِحَةِ)
- Search by English name (Al-Faatiha)
- Search by English translation (The Opening)
- Real-time filtering with debouncing

### State Management
- Use Provider/Riverpod for state management
- Separate providers for:
  - Surah list data
  - Search state
  - Favorites
  - User preferences

### Navigation Flow
1. App Launch → Surah List Screen
2. Tap Surah → Audio Configuration Modal
3. Configure settings → Media Player Screen
4. Back navigation maintains state

---
