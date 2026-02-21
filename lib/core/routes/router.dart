import 'package:breathing_app/models/activity_config.dart';
import 'package:breathing_app/ui/features/activity/activity_screen.dart';
import 'package:breathing_app/ui/features/completed/completed_screen.dart';
import 'package:breathing_app/ui/features/setup/setup_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: SetupScreen.routeName,
  routes: [
    GoRoute(
      path: SetupScreen.routeName,
      builder: (context, state) => SetupScreen(),
    ),

    GoRoute(
      path: ActivityScreen.routeName,
      builder: (context, state) {
        final config = state.extra as ActivityConfig;
        return ActivityScreen(config: config);
      },
    ),

    GoRoute(
      path: CompletionScreen.routeName,
      builder: (context, state) {
        final config = state.extra as ActivityConfig;
        return CompletionScreen(config: config);
      },
    ),
  ],
);
