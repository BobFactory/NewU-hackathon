import 'package:breathing_app/core/extensions/context_ext.dart';
import 'package:breathing_app/ui/features/activity/bloc/activity_cubit.dart';
import 'package:breathing_app/ui/features/activity/bloc/activity_state.dart';
import 'package:breathing_app/ui/features/activity/widgets/bubble.dart';
import 'package:breathing_app/ui/global_widgets/spacings.dart';
import 'package:breathing_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BreathingActivityView extends StatelessWidget {
  const BreathingActivityView({super.key});

  String _getPhaseTitle(ActivityState state) {
    if (state.isCompleted) return 'Complete';
    return switch (state.currentPhase) {
      BreathingPhase.breatheIn => 'Breathe in',
      BreathingPhase.holdIn => 'Hold softly',
      BreathingPhase.breatheOut => 'Breathe out',
      BreathingPhase.holdOut => 'Hold softly',
    };
  }

  String _getPhaseSubtitle(ActivityState state) {
    if (state.isCompleted) return 'Great session!';
    return switch (state.currentPhase) {
      BreathingPhase.breatheIn => 'nice and slow',
      BreathingPhase.holdIn => 'just be here',
      BreathingPhase.breatheOut => 'let it go',
      BreathingPhase.holdOut => 'just be here',
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityCubit, ActivityState>(
      builder: (context, state) {
        return SizedBox.expand(
          child: Column(
            children: [
              const SizedBox(height: 43),
              Text(
                "You're a natural!",
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(flex: 1),
              Bubble(text: state.bubbleText),
              const Spacer(flex: 1),
              Text(
                _getPhaseTitle(state),
                style: GoogleFonts.quicksand(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimary,
                ),
              ),
              VSpacer(6),
              Text(
                _getPhaseSubtitle(state),
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ),

              VSpacer(36),

              _ProgressIndicator(
                currentRound: state.currentRound,
                totalRounds: state.totalRounds,
              ),

              VSpacer(8),
              Text(
                'Cycle ${state.currentRound} of ${state.totalRounds}',
                style: GoogleFonts.quicksand(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary,
                ),
              ),

              VSpacer(24),

              _PauseResumeButton(
                isPaused: state.isPaused,
                onTap: () => context.read<ActivityCubit>().togglePause(),
              ),

              const Spacer(flex: 2),
            ],
          ),
        );
      },
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  final int currentRound;
  final int totalRounds;

  const _ProgressIndicator({
    required this.currentRound,
    required this.totalRounds,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        children: List.generate(totalRounds, (index) {
          final isCompleted = index < currentRound - 1;
          final isCurrent = index == currentRound - 1;

          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: index < totalRounds - 1 ? 4 : 0),
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: isCompleted || isCurrent
                    ? AppColors.secondary
                    : context.themed(
                        light: Colors.black.withOpacity(0.1),
                        dark: Colors.white.withOpacity(0.1),
                      ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _PauseResumeButton extends StatelessWidget {
  final bool isPaused;
  final VoidCallback onTap;

  const _PauseResumeButton({required this.isPaused, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: context.themed(
            light: Colors.white,
            dark: Colors.white.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
              size: 20,
              color: context.textPrimary,
            ),
            const SizedBox(width: 8),
            Text(
              isPaused ? 'Resume' : 'Pause',
              style: GoogleFonts.quicksand(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
