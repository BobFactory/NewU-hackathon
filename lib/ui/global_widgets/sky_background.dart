import 'package:flutter/material.dart';

class SkyBackground extends StatelessWidget {
  final Widget child;
  final ThemeMode themeMode;

  const SkyBackground({
    super.key,
    required this.child,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = themeMode == ThemeMode.dark;

    return ColoredBox(
      color: Colors.white,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: isDark ? _nightGradient : _dayGradient,
        ),
        child: child,
      ),
    );
  }

  LinearGradient get _dayGradient => LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      const Color(0x00ff8a00).withAlpha(50),
      const Color(0xFF630068).withAlpha(50),
    ],
  );

  LinearGradient get _nightGradient => const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.5, 1.0],
    colors: [Color(0xFF1A1128), Color(0xFF2D1B4E), Color(0xFF3A2260)],
  );
}
