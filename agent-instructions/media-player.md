screen opens after tapping a surah from SurahListScreen.

Audio can be directly streamed.

Ayah audio files can be accessed on the CDN directly via the following URL:

https://cdn.islamic.network/quran/audio/{bitrate}/{edition}/{number}.mp3
{edition} - An audio edition as returned by the API. (Example - ar.alafasy). A list of these editions is available here: http://api.alquran.cloud/edition/format/audio
{number} - An ayah number. The Quran contains 6236 ayahs, so this must be a number between 1 and 6236.
{bitrate} - Quality of audio served. Acceptable values are 192, 128, 64, 48, 40 and 32. You can see which edition is available in what sizes at https://raw.githubusercontent.com/islamic-network/cdn/master/info/cdn.txt.
Examples:

https://cdn.islamic.network/quran/audio/128/ar.alafasy/262.mp3
https://cdn.islamic.network/quran/audio/64/ar.alafasy/262.mp3