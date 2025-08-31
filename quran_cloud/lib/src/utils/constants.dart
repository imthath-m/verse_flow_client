/// Constants used throughout the quran_cloud package
class QuranCloudConstants {
  /// Base URL for Al-Quran Cloud API
  static const String baseUrl = 'http://localhost:8080/';

  /// Default timeout for API requests (30 seconds)
  static const Duration defaultTimeout = Duration(seconds: 30);

  /// Default retry attempts for failed requests
  static const int defaultRetryAttempts = 3;

  /// Default delay between retry attempts (1 second)
  static const Duration defaultRetryDelay = Duration(seconds: 1);

  /// User agent string for API requests
  static const String userAgent = 'QuranCloud/1.0.0';

  /// Default language code for Arabic
  static const String defaultArabicLanguage = 'ar';

  /// Default language code for English
  static const String defaultEnglishLanguage = 'en';
}
