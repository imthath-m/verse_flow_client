# Verse Flow Client

A Flutter application for browsing and managing Quranic surahs with a beautiful, modern interface.

## Features

### ✅ Implemented Features

- **Surah List Screen**: Complete implementation with all 114 surahs
- **Search Functionality**: Search by surah number, Arabic name, English name, or translation
- **Favorites System**: Mark and manage favorite surahs with persistent storage
- **Download Status**: Track downloaded surahs with visual indicators
- **Modern UI**: Beautiful, responsive design with Material 3 theming
- **State Management**: Robust state management using Provider pattern
- **Local Storage**: Persistent storage for user preferences and favorites
- **Error Handling**: Comprehensive error handling and loading states
- **Unit Tests**: Complete test coverage for models and services

### 🚧 Planned Features

- Audio Configuration Modal
- Media Player Screen
- Settings Screen
- Offline Audio Playback
- Multiple Reciter Support
- Dark/Light Theme Toggle

## Project Structure

```
lib/
├── main.dart                 # App entry point with Provider setup
├── models/
│   └── surah.dart           # Surah data model with JSON serialization
├── services/
│   ├── surah_service.dart   # Static data loading and search functionality
│   └── storage_service.dart # Local storage for preferences and favorites
├── providers/
│   └── surah_provider.dart  # State management for surah list
├── screens/
│   └── surah_list_screen.dart # Main surah list screen
├── widgets/
│   ├── surah_list_item.dart # Individual surah list item widget
│   ├── search_bar.dart      # Search functionality widget
│   ├── custom_button.dart   # Reusable button component
│   └── loading_widget.dart  # Custom loading animation
└── utils/
    ├── constants.dart       # App-wide constants and styling
    └── theme.dart          # Light and dark theme definitions

assets/
└── data/
    └── surah_list.json     # Static surah data (114 surahs)

test/
├── surah_list_test.dart    # Unit tests for models and services
└── widget_test.dart        # Widget tests for UI components
```

## Getting Started

### Prerequisites

- Flutter SDK (3.9.0 or higher)
- Dart SDK (3.9.0 or higher)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd verse_flow_client
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Running Tests

```bash
# Run all tests
flutter test

# Run only unit tests
flutter test test/surah_list_test.dart

# Run only widget tests
flutter test test/widget_test.dart
```

## Implementation Details

### Data Management

- **Static Data**: All 114 surahs are bundled in `assets/data/surah_list.json`
- **No Network Dependency**: App works completely offline for surah list
- **Caching**: Data is cached in memory for fast access
- **Local Storage**: User preferences and favorites are stored locally

### Search Functionality

- **Multi-field Search**: Search by surah number, Arabic name, English name, or translation
- **Real-time Filtering**: Results update as you type
- **Case-insensitive**: Search works regardless of case
- **Clear Search**: Easy way to clear search and show all surahs

### State Management

- **Provider Pattern**: Clean separation of concerns
- **Loading States**: Proper loading, success, and error states
- **Reactive UI**: UI updates automatically when state changes
- **Error Handling**: Graceful error handling with retry options

### UI/UX Features

- **Material 3 Design**: Modern, accessible design system
- **Responsive Layout**: Works on different screen sizes
- **Smooth Animations**: Custom loading animations and transitions
- **Visual Indicators**: Clear status indicators for favorites and downloads
- **Pull-to-Refresh**: Refresh data by pulling down the list

## Technical Stack

- **Framework**: Flutter 3.9.0+
- **State Management**: Provider 6.1.2
- **Local Storage**: SharedPreferences 2.2.3
- **JSON Serialization**: json_annotation 4.9.0
- **Testing**: flutter_test

## Development Phases

The implementation was completed in 7 phases:

1. **Phase 1**: Project Setup & Dependencies
2. **Phase 2**: Data Models & Services
3. **Phase 3**: UI Components
4. **Phase 4**: State Management & Main Screen
5. **Phase 5**: Polish & UX
6. **Phase 6**: Integration & Testing
7. **Phase 7**: Final Integration & Demo

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Run the test suite
6. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Quran data sourced from reliable Islamic sources
- Flutter team for the excellent framework
- Provider package maintainers for state management solution
