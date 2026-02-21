import 'package:breathing_app/core/extensions/context_ext.dart';
import 'package:breathing_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SoundSelector extends StatelessWidget {
  const SoundSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: .center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  "Sound",
                  style: GoogleFonts.quicksand(
                    fontWeight: .w600,
                    fontSize: 15,
                    height: 1.5,
                    color: context.textPrimary,
                  ),
                ),
                Text(
                  "Gentle chime between phases",
                  style: GoogleFonts.quicksand(
                    fontWeight: .w400,
                    fontSize: 12,
                    height: 1.5,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          Transform.scale(
            scale: 0.9,
            child: Switch.adaptive(
              value: true,
              onChanged: (value) {},
              activeTrackColor: context.themed(
                light: AppColors.primary,
                dark: AppColors.primaryDark,
              ),
              inactiveTrackColor: context.themed(
                light: Colors.grey.shade300,
                dark: Colors.grey.shade800,
              ),
              activeThumbColor: AppColors.white,
              inactiveThumbColor: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
