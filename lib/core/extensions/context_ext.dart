import 'package:breathing_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

extension ThemeHelper on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get textPrimary =>
      isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;

  Color get primary => isDark ? AppColors.primaryDark : AppColors.primary;

  Color themed({required Color light, required Color dark}) =>
      isDark ? dark : light;
}
