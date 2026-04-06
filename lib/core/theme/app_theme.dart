import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const background = Color(0xFF0B0F1A);
  static const surface = Color(0xFF121726);
  static const primary = Color(0xFF6C5CE7);
  static const accent = Color(0xFF00D1FF);
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFAAB0C0);
  static const divider = Color(0x14FFFFFF); // rgba(255,255,255,0.08)
  static const glass = Color(0x0AFFFFFF); // 0.04 opacity
  static const glassBorder = Color(0x14FFFFFF); // 0.08 opacity
  static const cardOverlay = Color(0x80000000);
}

class AppTheme {
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.surface,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: GoogleFonts.dmSansTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
              color: AppColors.textPrimary, fontWeight: FontWeight.w700),
          displayMedium: TextStyle(
              color: AppColors.textPrimary, fontWeight: FontWeight.w700),
          headlineLarge: TextStyle(
              color: AppColors.textPrimary, fontWeight: FontWeight.w700),
          headlineMedium: TextStyle(
              color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(
              color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          titleLarge: TextStyle(
              color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(
              color: AppColors.textPrimary, fontWeight: FontWeight.w500),
          titleSmall: TextStyle(
              color: AppColors.textSecondary, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: AppColors.textPrimary),
          bodyMedium: TextStyle(color: AppColors.textSecondary),
          bodySmall: TextStyle(
              color: AppColors.textSecondary, fontWeight: FontWeight.w300),
          labelLarge: TextStyle(
              color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          labelMedium: TextStyle(color: AppColors.textSecondary),
          labelSmall: TextStyle(
              color: AppColors.textSecondary, fontWeight: FontWeight.w300),
        ),
      ),
      dividerColor: AppColors.divider,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.dmSans(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.primary,
        labelStyle:
            GoogleFonts.dmSans(color: AppColors.textSecondary, fontSize: 12),
        side: const BorderSide(color: AppColors.divider),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
