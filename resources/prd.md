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

### 📱 App Launch → Surah Selection → Audio Playbook

1. User opens the app
2. User sees a **list of all Surahs** (number + Arabic name + name in selected translation language)
3. User taps a Surah
4. Audio plays: verse-by-verse → Arabic then translated audio with specified pauses
5. Media player allows Play/Pause, Next/Previous verse, and speed control
6.  options to update while playing audio:
    - Range (start ayah to end ayah) or Surah (one or more)
    - Arabic reciter
    - Translation language
    - Translation version
    - Playback speed
    
    All of the options are stored locally on device.
    

---

## 📋 4. Screens Overview

### 🔹 1. Surah List Screen

**Purpose:** Entry point to select a surah

**Content/Elements:**

- List of all 114 surahs
    - Displayed with number, Arabic name, and name in translation language
    - Tap on a Surah to open **Media Player**
- Search bar to filter surahs by name or number
- Visual indicator (icon) if surah is downloaded for offline use
- “Custom” button to **Audio Configuration Modal**

### 🔹 2. Audio Configuration Modal (Shown before entering Player)

**Purpose:** Allow users to configure what and how they want to listen

**Fields:**

- **Start ayah / End ayah** selection (range picker)
- Select 1 or more surahs
- **Arabic Reciter** (dropdown list)
- **Translation Language** (dropdown: English, Tamil, Urdu)
- **Translation Version** (dropdown — based on selected language)
- **Playback Speed** (dropdown: 0.5x, Normal, 1.5x, 2x)
- **Play** button (navigates to Player screen)
- **Cancel** button (returns to previous screen)

**Behavior:**

- Pre-populates with user's last-used preferences
- All selections are saved as new defaults for future sessions

### 🔹 3. Media Player Screen

**Purpose:** Seamless audio playback experience optimized for memorization

**Controls & Features:**

- **Play / Pause** toggle
- **Next / Previous Verse** navigation
- **Playback Speed Adjuster**
- **Progress indicator** showing current verse position within selected range
- Streaming audio with automatic caching
- No text display (scrolling text planned for future versions)
- Simple, distraction-free interface

**Audio Playback Pattern:**

- Plays selected range once (no automatic looping)
- Within each verse: Arabic audio → 300 millisecond pause → Translation audio
- Between verses: Translation of previous verse → 500 millisecond pause → Arabic of next verse
    
    Pause durations to be tuned further based on usage
    

### 🔹 4. Favorites Screen

**Purpose:** Enable memorization by quick access to personalized ranges

**User Actions:**

- Add a new **Custom Range** via "+" button
- Play saved ranges directly from the list
- Remove ranges (swipe to delete)
- Each favorite displays: "Surah [Number]: Ayah [Start]-[End]" with selected reciter & translation language
- Press ♥️ near a Surah to mark it as Favorite

**Example Display:**

- Surah 2: Ayah 1-7 (Mishary, English)
- Surah 36: Ayah 1-12 (Abdul Rahman, Tamil)

### 🔹 5. Settings Screen *(MVP-light version)*

**Purpose:** Store user defaults for streamlined experience

**Options:**

- Set default Arabic Reciter
- Set default Translation Language (English/Tamil/Urdu)
- Set default Playback Speed
- Manage Downloads (clear cache / view downloaded surahs)
- App version information

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
A: Within each verse, there's a 1-second pause between Arabic recitation and its translation. Between verses, there's a 1.5-second pause between the previous verse's translation and the next verse's Arabic, giving users time to process and transition.

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