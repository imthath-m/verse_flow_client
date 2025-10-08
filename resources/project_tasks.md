# Quran Memorization App - Task Tracker

## Project Overview
Flutter-based Quran memorization app with audio playback, translations, and offline support.

---

## Sprint 0: App Foundations & Setup

### High Priority
- [ ] **#1** Initialize Flutter project with lint rules *(First setup task)*
- [ ] **#2** Setup folder structure (screens, models, services) *(Pre-requisite for all)*
- [ ] **#3** Configure dependencies (http, just_audio, shared_preferences, dio) *(Required for networking + playback)*
- [ ] **#4** Implement base navigation skeleton *(Surah List → modal → player)*
- [ ] **#5** Setup environment configs (API URLs, TTS endpoint) *(Needed before API integration)*
- [ ] **#71** Setup environment configs for testing *(Prep test endpoints)*

### Medium Priority
- [ ] **#6** Create task template & workflow in Jira *(Definition of Done included)*
- [ ] **#7** Create low-fidelity wireframes for MVP screens *(Wireframes only)*
- [ ] **#89** Implement error logging (Flutter)

---

## Sprint 1: Surah List

### High Priority
- [ ] **#9** Implement static list of 114 surahs *(Placeholder for API data)*
- [ ] **#10** Fetch surah list from Quran API *(Replace static data)*
- [ ] **#14** Tap surah → launch FAB Player with default settings *(Navigation link)*
- [ ] **#96** Implement navigation bar with Home, Favorites, Settings, FAB Player *(Global navigation)*
- [ ] **#97** Add favorite toggle (♥️) for each surah *(Heart outline/filled states)*

### Medium Priority
- [ ] **#8** Design Surah List screen wireframe *(Prepare UI layout)*
- [ ] **#11** Implement search bar (by name/number) *(Client-side filtering)*
- [ ] **#12** Add download indicator icon for surahs *(Reflects offline availability)*
- [ ] **#92** Implement lazy loading for surah list *(Improves performance)*

---

## Sprint 2: Audio Config Modal

### High Priority
- [ ] **#16** Build modal UI with dropdowns and range selector *(Core user feature)*
- [ ] **#17** Implement surah range picker (start/end ayah) *(Verse selection)*
- [ ] **#18** Populate reciters dropdown from API *(Placeholder API)*
- [ ] **#19** Populate translation language dropdown *(Dropdown static for MVP)*
- [ ] **#20** Load translation versions based on selected language *(Dynamic version selection)*
- [ ] **#21** Save user selections to local storage *(Preference persistence)*
- [ ] **#23** Implement Play → open FAB Player *(Navigation)*
- [ ] **#98** Implement multi-select dropdown for surah selection *(Multiple surahs support)*
- [ ] **#99** Standardize playback speed options (0.5x, 0.75x, 1x, 1.25x, 1.5x, 1.75x, 2x) *(Consistent speed options)*
- [ ] **#100** Handle empty range fields when launched from FAB *(Default behavior)*

### Medium Priority
- [ ] **#15** Design Audio Config modal wireframe *(UI layout planning)*
- [ ] **#22** Pre-populate modal with last-used defaults *(Enhances usability)*
- [ ] **#72** Validate default values loaded correctly *(QA check)*
- [ ] **#93** Validate language/version dependency logic
- [ ] **#101** Implement Save button for Favorites mode *(Different behavior for Favorites)*

### Low Priority
- [ ] **#86** Add tooltip/help icons for new users *(Non-MVP)*

---

## Sprint 3: FAB Player

### High Priority
- [ ] **#25** Build FAB Player UI layout (Top bar, Play/Pause, Next/Previous, Progress, Speed, Stop) *(Core controls)*
- [ ] **#26** Integrate Arabic audio streaming *(Core playback)*
- [ ] **#27** Integrate translation audio (from backend cache) *(Requires TTS backend)*
- [ ] **#28** Implement playback sequence Arabic → 300ms pause → Translation *(Memorization pattern)*
- [ ] **#32** Handle playback errors (network failure) *(Fallback UI/Snackbar)*
- [ ] **#34** Manual testing checklist for player *(Create and run)*
- [ ] **#73** Test playback sequence correctness *(Arabic→Translation)*
- [ ] **#102** Implement FAB Player launch from Surah selection *(Direct launch with defaults)*
- [ ] **#103** Implement FAB Player launch from FAB button *(Opens Audio Config first)*
- [ ] **#104** Implement background playback behavior *(Icon changes, continues playing)*
- [ ] **#105** Implement session management *(One session at a time, terminate current)*
- [ ] **#106** Implement Stop button behavior *(Terminate session, return to Surah List)*

### Medium Priority
- [ ] **#24** Design FAB Player screen wireframe *(UI baseline)*
- [ ] **#29** Implement Next/Previous verse navigation *(Verse control)*
- [ ] **#30** Implement playback speed adjustment *(0.5x, 0.75x, 1x, 1.25x, 1.5x, 1.75x, 2x)*
- [ ] **#31** Implement progress indicator sync *(Shows current verse)*
- [ ] **#90** Implement buffer progress indicator
- [ ] **#91** Test playback speed functionality
- [ ] **#107** Implement FAB Player visibility states *(Play, Pause, Paused icons)*
- [ ] **#108** Implement clicking outside FAB Player behavior *(Background vs paused states)*

### Low Priority
- [ ] **#33** Keep screen awake while playing *(Use wakelock)*
- [ ] **#85** Implement verse highlighting placeholder (future) *(Non-MVP)*

---

## Sprint 4: Downloads & Backend

### High Priority - App
- [ ] **#35** Implement pre-playback prompt: download or stream *(Dialog confirmation)*
- [ ] **#36** Implement background download logic *(Save to local storage)*
- [ ] **#37** Store downloaded audio in device *(Persistence)*
- [ ] **#38** Check/play local file if downloaded, else stream *(Fallback logic)*
- [ ] **#40** Manual testing checklist for downloads *(Create and run)*
- [ ] **#74** Test download logic across devices *(Offline use)*

### High Priority - Backend
- [ ] **#65** Setup backend service for TTS caching *(Infra)*
- [ ] **#66** Integrate Google TTS API *(Generate translation audio)*
- [ ] **#67** Store files tagged by Surah:Ayah:Lang:Version *(Metadata management)*
- [ ] **#68** Expose API endpoint for cached/generated audio *(App dependency)*
- [ ] **#82** Test API responses for TTS files *(QA)*

### Medium Priority
- [ ] **#39** Clear cache/manage downloads in Settings *(User can delete files)*
- [ ] **#69** Add retry/fallback if TTS fails *(Reliability)*
- [ ] **#70** Document API endpoints for app team *(Handoff)*
- [ ] **#75** Test Clear Cache functionality *(Settings integration)*
- [ ] **#80** Setup DB schema for cached audio *(Link audio files)*
- [ ] **#87** Implement retry logic for failed downloads

### Low Priority
- [ ] **#94** Implement API rate limiting check *(Non-MVP)*

---

## Sprint 5: Favorites & Settings

### High Priority
- [ ] **#42** Build Favorites screen UI with top bar and list *(Display ranges)*
- [ ] **#43** Implement Play button for favorites *(Opens FAB Player with defaults)*
- [ ] **#45** Implement Delete button with confirmation dialog *(Remove favorites)*
- [ ] **#46** Manual testing checklist for favorites *(Create and run)*
- [ ] **#48** Implement default Arabic Reciter preference *(Stored locally)*
- [ ] **#49** Implement default Translation preference *(Language + version)*
- [ ] **#76** Test add/remove favorite flows *(QA)*
- [ ] **#109** Implement FAB (+) button for adding favorites *(Opens Range Picker)*
- [ ] **#110** Implement Range Picker Bottom Sheet *(Surah selection and Ayah range)*
- [ ] **#111** Implement success message after saving favorite *(3-second display)*
- [ ] **#112** Implement Delete confirmation dialog *(Title, message, Yes/Cancel buttons)*

### Medium Priority
- [ ] **#41** Design Favorites screen wireframe *(Before UI dev)*
- [ ] **#44** Implement individual favorite removal *(Update storage/UI)*
- [ ] **#47** Design Settings screen wireframe *(UI baseline)*
- [ ] **#50** Implement default Playback Speed preference *(Stored locally)*
- [ ] **#51** Implement Manage Downloads (clear/selective delete) *(Storage mgmt)*
- [ ] **#53** Manual testing checklist for settings *(Create and run)*
- [ ] **#77** Test default playback settings apply *(QA)*
- [ ] **#78** Test Manage Downloads *(QA)*
- [ ] **#113** Implement Settings screen sections *(Default Preferences, Downloads, System Info)*
- [ ] **#114** Implement Clear Downloads with confirmation *(Confirmation dialog)*
- [ ] **#115** Implement Downloaded Surahs list with Remove buttons *(Individual removal)*
- [ ] **#116** Implement App Version display *(From build metadata)*

### Low Priority
- [ ] **#52** Show app version info *(Simple display)*
- [ ] **#88** Sort favorites by last played *(Non-MVP)*

---

## Sprint 6: Design & UX Polish

### High Priority
- [ ] **#84** Ensure responsive design across screen sizes

### Medium Priority
- [ ] **#54** Create high-fidelity mockups *(Align team)*
- [ ] **#55** Apply minimal distraction-free theme *(Consistency)*
- [ ] **#83** Finalize UI polish & colors

### Low Priority
- [ ] **#56** Add empty states for downloads/favorites *(UX detail)*
- [ ] **#57** Add micro-animations for player *(Stretch goal, Non-MVP)*

---

## Sprint 7: Testing & QA

### High Priority
- [ ] **#58** Write manual test cases for Surah List
- [ ] **#59** Write manual test cases for Audio Config
- [ ] **#60** Write manual test cases for Media Player
- [ ] **#61** Write manual test cases for Downloads
- [ ] **#62** Write manual test cases for Favorites
- [ ] **#64** Cross-device tests on Android & iOS

### Medium Priority
- [ ] **#63** Write manual test cases for Settings
- [ ] **#79** Document QA results per epic *(Manual tracking)*
- [ ] **#95** Prepare internal demo build

### Low Priority
- [ ] **#81** Setup monitoring/logging *(Future hardening, Non-MVP)*

---

## Progress Summary

**Total Tasks:** 116  
**Completed:** 0  
**In Progress:** 0  
**To Do:** 116

### By Sprint
- **Sprint 0:** 9 tasks
- **Sprint 1:** 8 tasks
- **Sprint 2:** 12 tasks
- **Sprint 3:** 16 tasks
- **Sprint 4:** 16 tasks
- **Sprint 5:** 24 tasks
- **Sprint 6:** 6 tasks
- **Sprint 7:** 9 tasks

### By Priority
- **High Priority:** 68 tasks
- **Medium Priority:** 39 tasks
- **Low Priority:** 9 tasks

---

## Notes
- Tasks marked *(Non-MVP)* can be deprioritized if time is constrained
- Backend tasks in Sprint 4 are critical blockers for FAB Player functionality
- Cross-device testing should happen throughout, not just in Sprint 7
- Consider adding integration tests alongside manual testing
- New tasks reflect updated FRDs with FAB Player, enhanced Favorites, and detailed Settings
- Playback speed options standardized across all components
- Audio timing updated to 300ms/500ms pause pattern

---

**Last Updated:** January 2, 2025