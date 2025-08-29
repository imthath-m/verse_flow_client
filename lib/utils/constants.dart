import 'package:flutter/material.dart';

class AppConstants {
  // Colors
  static const Color primaryColor = Color(0xFF1E3A8A);
  static const Color secondaryColor = Color(0xFF3B82F6);
  static const Color accentColor = Color(0xFF10B981);
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color textPrimaryColor = Color(0xFF1F2937);
  static const Color textSecondaryColor = Color(0xFF6B7280);
  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color successColor = Color(0xFF10B981);
  static const Color warningColor = Color(0xFFF59E0B);
  
  // Dimensions
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusXLarge = 16.0;
  
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  
  // Text Styles
  static const TextStyle headingLarge = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: textPrimaryColor,
  );
  
  static const TextStyle headingMedium = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: textPrimaryColor,
  );
  
  static const TextStyle headingSmall = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: textPrimaryColor,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: textPrimaryColor,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: textSecondaryColor,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.normal,
    color: textSecondaryColor,
  );
  
  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  
  // App-specific constants
  static const String appName = 'Verse Flow';
  static const int totalSurahs = 114;
  
  // Storage Keys
  static const String favoritesKey = 'favorites';
  static const String downloadedSurahsKey = 'downloaded_surahs';
  static const String defaultLanguageKey = 'default_language';
  static const String defaultReciterKey = 'default_reciter';
}
