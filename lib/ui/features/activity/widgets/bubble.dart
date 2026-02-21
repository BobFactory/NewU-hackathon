import 'package:breathing_app/core/extensions/context_ext.dart';
import 'package:breathing_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bubble extends StatelessWidget {
  final String text;
  final double size;
  final double? fontSize;

  const Bubble({super.key, required this.text, this.size = 150, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            context.themed(
              light: AppColors.bgBubble.withOpacity(.20),
              dark: AppColors.bgBubbleDark.withOpacity(.40),
            ),
            context.themed(
              light: AppColors.bgBubble.withOpacity(.05),
              dark: AppColors.bgBubbleDark.withOpacity(.10),
            ),
          ],
        ),
        border: Border.all(
          color: context.themed(
            light: AppColors.bgBubble.withOpacity(.12),
            dark: AppColors.bgBubbleDark.withOpacity(.25),
          ),
        ),
      ),
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          child: text.isNotEmpty
              ? Text(
                  text,
                  key: ValueKey(text),
                  style: GoogleFonts.quicksand(
                    fontSize: fontSize ?? _defaultFontSize,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimary,
                  ),
                )
              : const SizedBox.shrink(key: ValueKey('empty')),
        ),
      ),
    );
  }

  double get _defaultFontSize => text.length > 2 ? 40 : 56;
}
