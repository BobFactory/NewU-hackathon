import 'package:breathing_app/core/extensions/context_ext.dart';
import 'package:breathing_app/models/activity_config.dart';
import 'package:breathing_app/ui/features/activity/bloc/activity_cubit.dart';
import 'package:breathing_app/ui/features/activity/bloc/activity_state.dart';
import 'package:breathing_app/ui/features/activity/widgets/breathing_activity_view.dart';
import 'package:breathing_app/ui/features/activity/widgets/countdown_view.dart';
import 'package:breathing_app/ui/features/completed/completed_screen.dart';
import 'package:breathing_app/ui/global_widgets/spacings.dart';
import 'package:breathing_app/ui/global_widgets/theme_change_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActivityScreen extends StatelessWidget {
  static String routeName = '/activity_screen';

  final ActivityConfig config;

  const ActivityScreen({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ActivityCubit(config: config),
      child: const _ActivityView(),
    );
  }
}

class _ActivityView extends StatelessWidget {
  const _ActivityView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActivityCubit, ActivityState>(
      listenWhen: (prev, curr) => !prev.isCompleted && curr.isCompleted,
      listener: (context, state) {
        final config = context.read<ActivityCubit>().config;
        context.pushReplacement(CompletionScreen.routeName, extra: config);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            style: IconButton.styleFrom(
              backgroundColor: context.themed(
                light: Colors.black.withOpacity(0.04),
                dark: Colors.white.withOpacity(0.08),
              ),
              fixedSize: Size(42, 42),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(42),
              ),
            ),
            icon: Icon(Icons.close),
          ),
          actions: [ThemeChangeButton(), HSpacer(16)],
        ),
        body: BlocBuilder<ActivityCubit, ActivityState>(
          buildWhen: (prev, curr) =>
              prev.isCountdownComplete != curr.isCountdownComplete,
          builder: (context, state) {
            return AnimatedCrossFade(
              firstChild: CountdownView(
                onComplete: () =>
                    context.read<ActivityCubit>().onCountdownComplete(),
              ),
              secondChild: const BreathingActivityView(),
              crossFadeState: state.isCountdownComplete
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 500),
              layoutBuilder:
                  (topChild, topChildKey, bottomChild, bottomChildKey) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          key: bottomChildKey,
                          child: bottomChild,
                        ),
                        Positioned.fill(key: topChildKey, child: topChild),
                      ],
                    );
                  },
            );
          },
        ),
      ),
    );
  }
}
