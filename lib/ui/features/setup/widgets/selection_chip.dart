import 'package:breathing_app/core/extensions/context_ext.dart';
import 'package:breathing_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SelectionChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectionChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var isDarkMode = context.isDark;

    var bgColor = isSelected
        ? isDarkMode
              ? AppColors.bgAccentSubtleDark
              : AppColors.bgAccentSubtle
        : isDarkMode
        ? AppColors.bgPageDark
        : AppColors.bgPage;

    var borderColor = isSelected
        ? AppColors.secondary
        : isDarkMode
        ? AppColors.borderSubtleDark
        : AppColors.borderSubtle;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 22),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: isSelected ? AppColors.secondary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
