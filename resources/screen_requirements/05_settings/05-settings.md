## Feature: Settings Screen (MVP - Light)

### Purpose
Provide users with the ability to set **default preferences** for audio playback, manage downloads, and view basic system information. These defaults are used when starting new playback sessions.

---

## UI Components

### 1. Default Preferences
* **Arabic Reciter (Dropdown)**
  * Displays available reciters
  * Stores user's **default reciter** for all new playback sessions
* **Translation (Dropdown: Language + Version)**
  * Displays supported languages and their versions
  * Stores user's **default translation** for all new playback sessions
* **Playback Speed (Dropdown)**
  * Options: 0.5x, 1x (default), 1.25x, 1.5x, 2x
  * Stores user's **default playback speed** for all new playback sessions

### 2. Downloads Management
* **Clear Downloads Button**
  * Action: Clears downloaded audio/translations
  * Confirmation dialog required
    * Title: *“Clear Downloads*
    * Message: *“Are you sure you want to clear all offline data?”*
    * Buttons: **Yes (Primary)** / **Cancel (Secondary)**
* **Downloaded Surahs (List)**
  * Displays list of downloaded surahs with surah number + name
  * Each item has a **Remove (trash icon)** button
  * Remove action triggers confirmation dialog:
    * Title: *“Remove Download”*
    * Message: *“Are you sure you want to remove this surah from downloads?”*
    * Buttons: **Yes (Primary)** / **Cancel (Secondary)**

### 3. System Info <span style="color: red;background-color: yellow">*(only app version or subscription info or ??)*</span> 
* **App Version**
  * Non-editable field
  * Pulled from `pubspec.yaml` / version
  * Display format: *App Version: 1.0.0 (Build 12)*

---

## Behavior

1. **Preferences**
   * Persist user's selected **defaults** locally
   * Auto-apply defaults when starting **new playback sessions**
   * Dropdown changes update stored **default preferences** immediately
   * These defaults are used when:
     * Tapping a Surah from the Surah List
     * Playing a Favorite
     * Starting any new audio session

2. **Cache Management**
   * Clear Cache → deletes audio files, temporary data
   * Confirmation required before performing action

3. **Downloads**
   * Displays all downloaded surahs
   * Remove option deletes only the specific surah’s files
   * Requires confirmation before removal

4. **System Info**
   * App version dynamically pulled from build metadata
   * Read-only field, no user interaction

---

## Visual Style
* Screen follows **global theme**: `lib>utils>theme.dart`
* Sections grouped under headers:
  * “Default Preferences”
  * “Downloads Management”
  * “System Info”
* Buttons styled as per project standards

---

## Wireframe Reference
*Note: Wireframes are illustrational only. Look and feel of the production app should follow the project’s theme. Clarifications can be made when required. Justifiable assumptions are fine as well.*  

![alt text](image.png)

## Developer Notes
* Implement Settings Screen in: `lib>screens>settings.dart`
* Integrations:
  * **Default Preferences** – store using SharedPreferences / local DB
  * **Downloads** – integrate with existing download manager module (if available)
  * **App Version** – read from build info (`package_info_plus` in Flutter)
* Confirmation dialogs should follow same design as Favorites delete dialog
* **Important**: These are **default settings** that apply to new playback sessions only
* Session-specific changes (via FAB Player settings) don't override these defaults

