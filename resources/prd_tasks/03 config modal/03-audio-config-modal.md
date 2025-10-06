## Feature: Audio Configuration Modal

### Purpose
Let users configure playback preferences before starting the player.

---

## UI Components

### Range Picker
* Fields:  
  * **Start Ayah**  
  * **End Ayah**

### Multi-Select Dropdown
* **Surah Selection** – allows selection of one or multiple Surahs.

### Dropdowns
* **Arabic Reciter**  
  * *[Static list or API-driven – confirmation needed]*  
* **Translation Language**  
  * Options: English, Tamil, Urdu  
* **Translation Version**  
  * Dependent on selected translation language  
  * *[Confirm available versions per language]*  
* **Playback Speed**  
  * Options: 0.5x, 0.75x, 1x, 1.25x, 1.5x, 1.75x, 2x (hardcoded)
  * These options are presented in the playback speed selector (dropdown) in the Audio Configuration Modal and FAB player.

#### Persistence and Application of Selected Speed
* The default playback speed can be set and saved in the Settings menu and is applied as the default for new playback sessions.
* If a user selects a different playback speed in the Audio Configuration Modal, that selected speed is applied only for that current session. The default in Settings is not changed unless the user explicitly updates it there.

### Buttons
* **Play (Primary CTA)** – navigates to Media Player  
* **Cancel (Secondary CTA)** – returns to previous screen  

---

## Behavior
1. Modal pre-populates with **last-used preferences**.  
2. On save, selections are stored as defaults for future sessions.  
3. **Play** opens Media Player screen with selected settings.  
4. **Cancel** dismisses the modal.

Note: When launched from the Favorites menu, Play button should be replaced with Save button and the actions should be replaced accordingly. Refer wireframe in `04 favorites>04-favorites.md`

---

## User Flow
1. User opens Surah and is presented with the Audio Configuration Modal.  
2. User selects Surah(s), Ayah range, reciter, translation, and playback speed.  
3. User taps **Play** → Media Player opens with chosen settings.  
4. User taps **Cancel** → Modal closes and returns to previous screen.  

---

**Visual Style:**  
In sync with existing theme of the project (`lib>utils>theme.dart`).

**Wireframe:**  

*Note: Wireframes are illustrational only. Look and feel of the production app should follow the project’s theme. Clarifications can be made when required. Justifiable assumptions are fine as well.*  

![alt text](image-2.png)    ![alt text](image.png)