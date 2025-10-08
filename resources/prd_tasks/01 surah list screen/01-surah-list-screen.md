**1. Surah List Screen**

Purpose: Entry point for users to select a surah for playback.

# 📄 Version 1 – Functional Requirements Document (FRD)

## Feature: Surah List & Audio Playback

### Purpose
Provide users with a searchable, scrollable list of 114 Surahs, with support for favorites and audio playback settings.

---

## UI Components

### Navigation Bar
* Global navigation back to home or other menus.
* Menus included:
  * **Home**
  * **Favorites**
  * **Settings**
* **FAB-with Play icon for media player (refer wireframe for illustration)**

### Search Bar
* User can filter Surahs by:
  * Surah number
  * Surah name in Arabic
  * Surah name in translation (user-selected language)

### Surah List
* Display a scrollable list of **114 Surahs**.
* Each row must include:
  * Surah number
  * Surah name (Arabic)
  * Surah name (Translation - user's selected language)
  * Favorite toggle ♥️

#### Favorite Toggle Behavior:
* Default icon (not favorite): Empty heart outline (
<img src="image.png" alt="not favorite" width="20" height="20">)
* When marked as favorite: Filled heart icon (<img src="image-1.png" alt="favorite" width="30" height="30">)

### Surah Selection
* Clicking a Surah name launches the FAB player and the selected Surah plays.
* If required, user can configure playback options using the *Settings* options in the FAB and click Play.

## User Flow 1 (Play a surah by clicking a surah name from Surah List)
1. User navigates via Navigation Bar.
2. User searches or scrolls through Surah List.
3. User toggles favorite if desired.
4. User clicks Surah name → FAB player launches and the selected Surah plays
5. If required, User configures playback options using the *Settings* options in the FAB and click Play.
6. If any surah/range is being played already; terminate it and start the newly selected range with the selected config.

## User flow 2 (Play a range by clicking FAB player button and clicking Play button in the audio config modal)
* User clicks FAB Player button and  Audio config modal launches 
  * Range fields in *From* and *To* should be empty. Do not default anything in those 4 fields - From-Surah, From-Ayah, To-Surah, To-Ayah
  * All other options should be selected based on the defaults set
* User configures the required options (optional step)
* User clicks *Play* button

**Visual Style:**
In sync with existing theme.

**Wireframe:**

*Note: Wireframes are illustrational only. Look and feel of the production app should be in sync with the existing theme of the project(lib>utils>theme.dart). Clarifications can be made when required. Justifiable assumptions are fine as well.*

![alt text](image-2.png)    ![alt text](image-3.png)