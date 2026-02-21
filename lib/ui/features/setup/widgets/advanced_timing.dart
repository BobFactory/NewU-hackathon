import 'package:breathing_app/core/constants/assets.dart';
import 'package:breathing_app/core/extensions/context_ext.dart';
import 'package:breathing_app/ui/global_widgets/spacings.dart';
import 'package:breathing_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvancedTiming extends StatefulWidget {
  const AdvancedTiming({super.key});

  @override
  State<AdvancedTiming> createState() => _AdvancedTimingState();
}

class _AdvancedTimingState extends State<AdvancedTiming> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Header
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          behavior: HitTestBehavior.opaque,

          child: Row(
            crossAxisAlignment: .center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      "Advanced timing",
                      style: GoogleFonts.quicksand(
                        fontWeight: .w600,
                        fontSize: 15,
                        height: 1.5,
                        color: context.textPrimary,
                      ),
                    ),
                    Text(
                      "Set different durations for each phase",
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

              AnimatedRotation(
                turns: _isExpanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: SvgPicture.asset(
                  Assets.iconsArrowDown,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    context.themed(
                      light: AppColors.textPrimary,
                      dark: AppColors.white,
                    ),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
        VSpacer(12),

        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Column(
            children: [
              VSpacer(12),
              _OptionTile(
                label: 'Breathe in',
                value: 4,
                onChanged: (int value) {},
              ),
              VSpacer(8),
              _OptionTile(
                label: 'Hold in',
                value: 4,
                onChanged: (int value) {},
              ),
              VSpacer(8),
              _OptionTile(
                label: 'Breathe out',
                value: 4,
                onChanged: (int value) {},
              ),
              VSpacer(8),
              _OptionTile(
                label: 'Hold out',
                value: 4,
                onChanged: (int value) {},
              ),
            ],
          ),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String label;
  final int value;
  final String unit;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  const _OptionTile({
    required this.label,
    required this.value,
    this.unit = 's',
    this.min = 2,
    this.max = 10,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    var isDarkMode = context.isDark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.bgPageDark : AppColors.bgPage,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: .max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: .center,
        children: [
          Text(
            label,
            style: GoogleFonts.quicksand(
              fontSize: 14,
              fontWeight: .w600,
              color: context.textPrimary,
            ),
          ),

          Row(
            children: [
              _StepperButton(icon: Icons.remove, onTap: () {}),
              const SizedBox(width: 12),
              Text(
                '$value$unit',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: context.themed(
                    light: AppColors.textPrimary,
                    dark: AppColors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              _StepperButton(icon: Icons.add, onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _StepperButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: context.themed(
            light: AppColors.white,
            dark: AppColors.bgChipNeutral,
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 20,
          color: context.themed(
            light: AppColors.bgPageDark,
            dark: AppColors.white,
          ),
        ),
      ),
    );
  }
}
