import 'package:breathing_app/core/constants/assets.dart';
import 'package:breathing_app/core/extensions/context_ext.dart';
import 'package:breathing_app/ui/features/activity/activity_screen.dart';
import 'package:breathing_app/ui/features/setup/bloc/setup_bloc.dart';
import 'package:breathing_app/ui/features/setup/bloc/setup_state.dart';
import 'package:breathing_app/ui/features/setup/widgets/advanced_timing.dart';
import 'package:breathing_app/ui/features/setup/widgets/selection_chip.dart';
import 'package:breathing_app/ui/features/setup/widgets/sound_selector.dart';
import 'package:breathing_app/ui/global_widgets/spacings.dart';
import 'package:breathing_app/ui/global_widgets/theme_change_button.dart';
import 'package:breathing_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SetupScreen extends StatelessWidget {
  static String routeName = '/setup_screen';

  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => SetupCubit(), child: _SetupView());
  }
}

class _SetupView extends StatelessWidget {
  const _SetupView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [ThemeChangeButton(), HSpacer(16)],
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          padding: .symmetric(horizontal: 27),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              Text(
                "Set your breathing pace",
                textAlign: .center,
                style: GoogleFonts.quicksand(
                  fontWeight: .w700,
                  fontSize: 24,
                  height: 1.5,
                  color: context.themed(
                    light: AppColors.primary,
                    dark: AppColors.white,
                  ),
                ),
              ),
              VSpacer(12),
              Text(
                "Customise your breathing session. You can always change this later.",
                textAlign: .center,
                style: GoogleFonts.quicksand(
                  fontWeight: .w400,
                  fontSize: 14,
                  height: 1.5,
                  color: context.themed(
                    light: AppColors.textSecondary,
                    dark: AppColors.textTertiary,
                  ),
                ),
              ),
              VSpacer(20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        "Breath duration",
                        style: GoogleFonts.quicksand(
                          fontWeight: .w600,
                          fontSize: 15,
                          height: 1.5,
                          color: context.textPrimary,
                        ),
                      ),
                      Text(
                        "Seconds per phase",
                        style: GoogleFonts.quicksand(
                          fontWeight: .w400,
                          fontSize: 12,
                          height: 1.5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      VSpacer(10),
                      _BreathDurationSelector(),
                      VSpacer(12),
                      Text(
                        "Rounds",
                        style: GoogleFonts.quicksand(
                          fontWeight: .w600,
                          fontSize: 15,
                          height: 1.5,
                          color: context.textPrimary,
                        ),
                      ),
                      Text(
                        "Full breathing cycles",
                        style: GoogleFonts.quicksand(
                          fontWeight: .w400,
                          fontSize: 12,
                          height: 1.5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      VSpacer(10),
                      _RoundsSelector(),
                      VSpacer(12),
                      AdvancedTiming(),
                      VSpacer(12),
                      SoundSelector(),
                    ],
                  ),
                ),
              ),

              VSpacer(18),
              ElevatedButton(
                onPressed: () {
                  final config = context
                      .read<SetupCubit>()
                      .state
                      .toActivityConfig();
                  context.push(ActivityScreen.routeName, extra: config);
                },
                child: Row(
                  mainAxisSize: .max,
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .center,
                  children: [
                    Text("Start breathing"),
                    HSpacer(8),
                    SvgPicture.asset(Assets.iconsFastWind),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BreathDurationSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetupCubit, SetupState>(
      buildWhen: (prev, curr) => prev.breathDuration != curr.breathDuration,
      builder: (context, state) {
        return Row(
          spacing: 8,
          children: [2, 4, 5, 10].map((duration) {
            return SelectionChip(
              label: '${duration}s',
              isSelected: state.breathDuration == duration,
              onTap: () =>
                  context.read<SetupCubit>().setBreathDuration(duration),
            );
          }).toList(),
        );
      },
    );
  }
}

class _RoundsSelector extends StatelessWidget {
  static const _labels = {2: '2 quick', 4: '4 calm', 6: '6 deep', 8: '8 zen'};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetupCubit, SetupState>(
      buildWhen: (prev, curr) => prev.rounds != curr.rounds,
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 8,
            children: _labels.entries.map((entry) {
              return SelectionChip(
                padding: .symmetric(horizontal: 12, vertical: 11),
                label: entry.value,
                isSelected: state.rounds == entry.key,
                onTap: () => context.read<SetupCubit>().setRounds(entry.key),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
