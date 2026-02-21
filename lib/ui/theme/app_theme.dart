import 'package:breathing_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    scaffoldBackgroundColor: Colors.transparent,
    cardTheme: CardThemeData(
      color: Colors.white.withOpacity(0.7),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: .symmetric(vertical: 16),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: .circular(16)),
        textStyle: GoogleFonts.lato(fontWeight: .w700, fontSize: 16),
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.2),
      ),
    ),
  );

  static ThemeData get dark => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: Colors.transparent,
    cardTheme: CardThemeData(
      color: Colors.white.withOpacity(0.05),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: .symmetric(vertical: 16),
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.primaryDark,
        shape: RoundedRectangleBorder(borderRadius: .circular(16)),
        textStyle: GoogleFonts.lato(fontWeight: .w700, fontSize: 16),
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.2),
      ),
    ),
  );
}
