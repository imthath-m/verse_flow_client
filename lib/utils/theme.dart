import 'package:flutter/material.dart';
import 'constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppConstants.primaryColor,
        brightness: Brightness.light,
      ),
      
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppConstants.surfaceColor,
        foregroundColor: AppConstants.textPrimaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppConstants.headingMedium,
        iconTheme: IconThemeData(
          color: AppConstants.textPrimaryColor,
          size: AppConstants.iconSizeMedium,
        ),
      ),
      
      // Scaffold Theme
      scaffoldBackgroundColor: AppConstants.backgroundColor,
      
      // Card Theme
      cardTheme: CardThemeData(
        color: AppConstants.surfaceColor,
        elevation: 2,
        shadowColor: AppConstants.borderColor.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMedium,
          vertical: AppConstants.paddingSmall,
        ),
      ),
      
      // List Tile Theme
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMedium,
          vertical: AppConstants.paddingSmall,
        ),
        titleTextStyle: AppConstants.bodyLarge,
        subtitleTextStyle: AppConstants.bodyMedium,
        iconColor: AppConstants.textSecondaryColor,
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: AppConstants.surfaceColor,
          elevation: 2,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLarge,
            vertical: AppConstants.paddingMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
          textStyle: AppConstants.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppConstants.accentColor,
        foregroundColor: AppConstants.surfaceColor,
        elevation: 4,
        iconSize: AppConstants.iconSizeMedium,
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppConstants.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: const BorderSide(color: AppConstants.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: const BorderSide(color: AppConstants.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: const BorderSide(color: AppConstants.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: const BorderSide(color: AppConstants.errorColor),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMedium,
          vertical: AppConstants.paddingMedium,
        ),
        hintStyle: AppConstants.bodyMedium.copyWith(
          color: AppConstants.textSecondaryColor,
        ),
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppConstants.textSecondaryColor,
        size: AppConstants.iconSizeMedium,
      ),
      
      // Text Theme
      textTheme: const TextTheme(
        displayLarge: AppConstants.headingLarge,
        displayMedium: AppConstants.headingMedium,
        displaySmall: AppConstants.headingSmall,
        bodyLarge: AppConstants.bodyLarge,
        bodyMedium: AppConstants.bodyMedium,
        bodySmall: AppConstants.bodySmall,
        labelSmall: AppConstants.caption,
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppConstants.borderColor,
        thickness: 1,
        space: 1,
      ),
      
      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppConstants.primaryColor,
        linearTrackColor: AppConstants.borderColor,
        circularTrackColor: AppConstants.borderColor,
      ),
    );
  }
  
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppConstants.primaryColor,
        brightness: Brightness.dark,
      ),
      
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppConstants.darkSurfaceColor,
        foregroundColor: AppConstants.darkTextPrimaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppConstants.darkHeadingMedium,
        iconTheme: IconThemeData(
          color: AppConstants.darkTextPrimaryColor,
          size: AppConstants.iconSizeMedium,
        ),
      ),
      
      // Scaffold Theme
      scaffoldBackgroundColor: AppConstants.darkBackgroundColor,
      
      // Card Theme
      cardTheme: CardThemeData(
        color: AppConstants.darkSurfaceColor,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMedium,
          vertical: AppConstants.paddingSmall,
        ),
      ),
      
      // List Tile Theme
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMedium,
          vertical: AppConstants.paddingSmall,
        ),
        titleTextStyle: AppConstants.darkBodyLarge,
        subtitleTextStyle: AppConstants.darkBodyMedium,
        iconColor: AppConstants.darkTextSecondaryColor,
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: AppConstants.darkTextPrimaryColor,
          elevation: 2,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLarge,
            vertical: AppConstants.paddingMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
          textStyle: AppConstants.darkBodyLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppConstants.accentColor,
        foregroundColor: AppConstants.darkTextPrimaryColor,
        elevation: 4,
        iconSize: AppConstants.iconSizeMedium,
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppConstants.darkSurfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: const BorderSide(color: AppConstants.darkBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: const BorderSide(color: AppConstants.darkBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: const BorderSide(color: AppConstants.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: const BorderSide(color: AppConstants.errorColor),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMedium,
          vertical: AppConstants.paddingMedium,
        ),
        hintStyle: AppConstants.darkBodyMedium.copyWith(
          color: AppConstants.darkTextSecondaryColor,
        ),
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppConstants.darkTextSecondaryColor,
        size: AppConstants.iconSizeMedium,
      ),
      
      // Text Theme
      textTheme: const TextTheme(
        displayLarge: AppConstants.darkHeadingLarge,
        displayMedium: AppConstants.darkHeadingMedium,
        displaySmall: AppConstants.darkHeadingSmall,
        bodyLarge: AppConstants.darkBodyLarge,
        bodyMedium: AppConstants.darkBodyMedium,
        bodySmall: AppConstants.darkBodySmall,
        labelSmall: AppConstants.darkCaption,
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppConstants.darkBorderColor,
        thickness: 1,
        space: 1,
      ),
      
      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppConstants.primaryColor,
        linearTrackColor: AppConstants.darkBorderColor,
        circularTrackColor: AppConstants.darkBorderColor,
      ),
    );
  }
}
