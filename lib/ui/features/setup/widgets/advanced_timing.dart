import 'package:breathing_app/core/constants/assets.dart';
import 'package:breathing_app/core/extensions/context_ext.dart';
import 'package:breathing_app/ui/features/setup/bloc/setup_bloc.dart';
import 'package:breathing_app/ui/features/setup/bloc/setup_state.dart';
import 'package:breathing_app/ui/global_widgets/spacings.dart';
import 'package:breathing_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvancedTiming extends StatelessWidget {
  const AdvancedTiming({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetupCubit, SetupState>(
      buildWhen: (prev, curr) =>
          prev.isAdvancedExpanded != curr.isAdvancedExpanded,
      builder: (context, state) {
        final isExpanded = state.isAdvancedExpanded;
        return Column(
          children: [
            //Header
            GestureDetector(
              onTap: () => context.read<SetupCubit>().toggleAdvanced(),
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
                    turns: isExpanded ? 0.5 : 0,
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
              secondChild: const _AdvancedOptions(),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 200),
            ),
          ],
        );
      },
    );
  }
}

class _AdvancedOptions extends StatelessWidget {
  const _AdvancedOptions();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetupCubit, SetupState>(
      builder: (context, state) {
        final cubit = context.read<SetupCubit>();

        return Column(
          children: [
            const VSpacer(12),
            _OptionTile(
              label: 'Breathe in',
              value: state.breatheIn,
              onChanged: cubit.setBreatheIn,
            ),
            const VSpacer(8),
            _OptionTile(
              label: 'Hold in',
              value: state.holdIn,
              onChanged: cubit.setHoldIn,
            ),
            const VSpacer(8),
            _OptionTile(
              label: 'Breathe out',
              value: state.breatheOut,
              onChanged: cubit.setBreatheOut,
            ),
            const VSpacer(8),
            _OptionTile(
              label: 'Hold out',
              value: state.holdOut,
              onChanged: cubit.setHoldOut,
            ),
          ],
        );
      },
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  const _OptionTile({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.bgPageDark : AppColors.bgPage,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.quicksand(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: context.textPrimary,
            ),
          ),
          Row(
            children: [
              _StepperButton(
                icon: Icons.remove,
                onTap: () {
                  if (value > 2) {
                    onChanged(value - 1);
                  }
                },
              ),
              const SizedBox(width: 12),
              Text(
                '${value}s',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: context.textPrimary,
                ),
              ),
              const SizedBox(width: 12),
              _StepperButton(
                icon: Icons.add,
                onTap: () {
                  if (value < 10) {
                    onChanged(value + 1);
                  }
                },
              ),
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

  const _StepperButton({required this.icon, required this.onTap});

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
