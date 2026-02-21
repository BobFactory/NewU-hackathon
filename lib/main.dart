import 'package:breathing_app/core/routes/router.dart';
import 'package:breathing_app/core/theme_switcher/theme_switcher_cubit.dart';
import 'package:breathing_app/ui/global_widgets/sky_background.dart';
import 'package:breathing_app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeChangerCubit(),
      child: BlocBuilder<ThemeChangerCubit, ThemeMode>(
        builder: (context, themeMode) {
          return SkyBackground(
            themeMode: themeMode,
            child: MaterialApp.router(
              title: 'Flutter Demo',
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeMode,
              routerConfig: router,
            ),
          );
        },
      ),
    );
  }
}
