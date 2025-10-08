# Quran Audio App – MVP Product Requirements Document

**Author:** Abdul Basith

**Created:** 2025-06-26

---

## 📌 1. Objective

To create a spiritual utility app that helps **non-Arabic speaking Muslims memorize the Quran** by **listening to the Arabic recitation along with translation audio**, one surah at a time, with an intuitive and minimal interface.

---

## 👥 2. Target Users

Muslims who do **not speak Arabic fluently** who are

- **memorizing the Quran** and want to listen to specific ranges
- primarily mobile users, but MVP targets all platforms via cross-platform framework
- comfortable with streaming audio online
- listening to Quran while doing something else (like commuting, cooking) and connect with it
- trying to understand more of the Quran they listen/read frequently

---

## 🧭 3. Key User Flows

### 📱 User Flow 1: Direct Surah Selection
1. User opens the app
2. User sees a **list of all Surahs** (number + Arabic name + name in selected translation language)
3. User taps a Surah name
4. FAB player launches immediately with default settings
5. Audio plays: verse-by-verse → Arabic then translated audio with specified pauses
6. User can configure options via FAB player settings if needed

### 📱 User Flow 2: FAB Player Configuration
1. User opens the app
2. User clicks FAB Player button (with Play icon)
3. Audio Configuration Modal opens with empty range fields
4. User configures:
   - Surah selection (one or multiple)
   - Start/End Ayah range
   - Arabic reciter
   - Translation language and version
   - Playback speed
5. User clicks Play → FAB player launches with selected settings
6. Audio plays according to configured preferences

### 📱 User Flow 3: Favorites Management
1. User navigates to Favorites screen
2. User can play saved ranges directly (uses default settings)
3. User can add new favorites via "+" button
4. Range Picker Bottom Sheet opens for surah/ayah selection
5. User saves favorite → success message displayed
    

---

## 📋 4. Screens Overview

### 🔹 1. Surah List Screen

**Purpose:** Entry point to select a surah

**Content/Elements:**

- **Navigation Bar** with Home, Favorites, Settings, and FAB Player button
- List of all 114 surahs
    - Displayed with number, Arabic name, and name in translation language
    - Tap on a Surah to launch **FAB Player** with default settings
    - Favorite toggle (♥️) for each surah
- Search bar to filter surahs by name or number
- Visual indicator (icon) if surah is downloaded for offline use

### 🔹 2. Audio Configuration Modal

**Purpose:** Allow users to configure playback preferences before starting the player

**Fields:**

- **Range Picker**: Start Ayah / End Ayah selection
- **Multi-Select Dropdown**: Surah Selection (one or multiple surahs)
- **Arabic Reciter** (dropdown list)
- **Translation Language** (dropdown: English, Tamil, Urdu)
- **Translation Version** (dropdown — based on selected language)
- **Playback Speed** (dropdown: 0.5x, 0.75x, 1x, 1.25x, 1.5x, 1.75x, 2x)
- **Play** button (navigates to FAB Player)
- **Cancel** button (returns to previous screen)

**Behavior:**

- Pre-populates with user's last-used preferences
- When launched from Favorites, Play button becomes Save button
- All selections are saved as new defaults for future sessions

### 🔹 3. FAB Player (Floating Action Button Player)

**Purpose:** Seamless audio playback experience optimized for memorization

**Controls & Features:**

- **Top Bar**: Back navigation and current Surah + Ayah range display
- **Play / Pause** toggle
- **Next / Previous Verse** navigation
- **Playback Speed Adjuster** (0.5x, 0.75x, 1x, 1.25x, 1.5x, 1.75x, 2x)
- **Stop** button (terminates session and returns to Surah List)
- **Progress indicator** showing current verse position within selected range
- Streaming audio with automatic caching
- Simple, distraction-free interface

**Audio Playback Pattern:**

- Plays selected range once (no automatic looping)
- Within each verse: Arabic audio → 300ms pause → Translation audio
- Between verses: Translation of previous verse → 500ms pause → Arabic of next verse

**FAB Player Behavior:**

- **Launch from Surah Selection**: Starts immediately with default settings
- **Launch from FAB Button**: Opens Audio Configuration Modal first
- **Background Playback**: Continues when user navigates away (icon changes to Pause)
- **Session Management**: Only one session at a time, new selection terminates current
    

### 🔹 4. Favorites Screen

**Purpose:** Enable memorization by quick access to personalized ranges

**User Actions:**

- **Top Bar**: "Favorites" title with back navigation
- **Favorites List**: Each item displays Surah number + Ayah range with Play and Delete buttons
- **Play Button**: Opens FAB Player with default settings
- **Delete Button**: Removes favorite after confirmation dialog
- **FAB (+)**: Opens Range Picker Bottom Sheet for adding new favorites
- **Range Picker Bottom Sheet**: Surah selection and Ayah range picker
- **Success Message**: 3-second display after saving favorite

**Example Display:**

- Surah 2: Ayah 1-7
- Surah 36: Ayah 1-12

**Delete Confirmation Dialog:**
- Title: "Delete Favorite"
- Message: "Are you sure you want to delete this favorite?"
- Buttons: Yes (Primary) / Cancel (Secondary)

### 🔹 5. Settings Screen *(MVP-light version)*

**Purpose:** Store user defaults for streamlined experience

**Sections:**

**1. Default Preferences**
- **Arabic Reciter** (Dropdown): Stores default reciter for new playback sessions
- **Translation** (Dropdown): Language + Version selection for new sessions
- **Playback Speed** (Dropdown): 0.5x, 1x (default), 1.25x, 1.5x, 2x

**2. Downloads Management**
- **Clear Downloads Button**: Clears all offline data with confirmation dialog
- **Downloaded Surahs List**: Shows downloaded surahs with Remove button
- **Remove Confirmation**: Individual surah removal with confirmation

**3. System Info**
- **App Version**: Non-editable field from build metadata
- Display format: "App Version: 1.0.0 (Build 12)"

**Confirmation Dialogs:**
- Clear Downloads: "Are you sure you want to clear all offline data?"
- Remove Download: "Are you sure you want to remove this surah from downloads?"

---

## 🎯 5. Core Functional Requirements (UX-focused)

### Audio & Streaming

- **Always-online streaming** with audio fetched dynamically
- **Automatic caching** of recently played audio for improved performance
- **Download option** to save specific surahs for offline use
- **Verse-by-verse playback** with precise pause timings for memorization flow

### User Experience

- **Preference persistence** - remembers user's last configuration across app sessions
- **Minimal, distraction-free design** prioritizing usability and focus
- **Intuitive navigation** with clear visual hierarchy
- **Responsive design** optimized for various screen sizes

### Language Support

- **Multi-language translation support**: English, Tamil, Urdu
- **Multiple translation versions** per language where available
- **Unicode Arabic text** support for surah names

---

## 🔕 6. Out of Scope (for MVP)

- Text display of Arabic or translation during playback
    - Audio synchronization with displayed text
- Tafsir, daily reminders, or advanced learning features
- User accounts or login system
- Push notifications or background app badges
- Dark mode or advanced theming options
- Social sharing or community features
- Bookmarking individual verses (only range-based favorites)

---

## ❓ 7. User Experience Q&A

**Q: How should the app handle range playback for memorization purposes?**
A: The app plays the selected range once without automatic looping. Users can manually replay if needed. This prevents overwhelming beginners while allowing focused memorization sessions.

**Q: What's the optimal pause timing between Arabic and translation audio?**
A: Within each verse, there's a 300ms pause between Arabic recitation and its translation. Between verses, there's a 500ms pause between the previous verse's translation and the next verse's Arabic, giving users time to process and transition.

**Q: Should users preview different reciters before selection?**
A: For MVP simplicity, a dropdown list of reciters is sufficient. Previewing functionality can be considered for future versions based on user feedback.

**Q: Which translation languages should be prioritized for MVP?**
A: Starting with English, Tamil, and Urdu covers a significant portion of non-Arabic speaking Muslims globally and provides good market validation.

**Q: How should the app handle user preferences across sessions?**
A: The app remembers the user's last-used configuration (reciter, language, speed) and pre-populates these settings when selecting new surahs, streamlining the experience for regular users.

**Q: How should favorite ranges be displayed and managed?**
A: Favorites display as "Surah X: Ayah Y-Z" format with reciter and translation language info. No custom naming needed for MVP - keeping it simple and functional.

**Q: Should there be progress tracking for memorization?**
A: Not for MVP. The focus is on providing a clean, functional audio experience. Progress tracking features can be evaluated for future versions based on user needs.

---

## 🗺️ 8. Roadmap Placeholder (Post-MVP Ideas)

*(For internal planning – will not be included in the MVP launch)*

- Display Arabic + translation text with synchronized audio highlighting
- Automatic loop options for memorization ranges
- Daily reminders and listening streak tracking
- Verse tagging and advanced bookmarking
- User accounts with cloud-synced favorites
- UI themes (dark mode, custom fonts)
- Reciter preview functionality
- Advanced progress tracking and memorization analytics
- Offline-first architecture with selective downloading
- Additional translation languages based on user demand