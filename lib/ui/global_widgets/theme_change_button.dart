import 'package:breathing_app/core/constants/assets.dart';
import 'package:breathing_app/core/theme_switcher/theme_switcher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ThemeChangeButton extends StatelessWidget {
  const ThemeChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeChangerCubit, ThemeMode>(
      builder: (context, themeMode) {
        var backgroundColor = themeMode == ThemeMode.dark
            ? Colors.white.withOpacity(0.08)
            : Colors.black.withOpacity(0.04);

        var icon = themeMode == ThemeMode.dark
            ? Assets.iconsSun
            : Assets.iconsMoon;

        return IconButton(
          onPressed: () {
            context.read<ThemeChangerCubit>().toggle();
          },
          style: IconButton.styleFrom(
            backgroundColor: backgroundColor,
            fixedSize: const Size(42, 42),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(42),
            ),
          ),
          icon: Center(child: SvgPicture.asset(icon, width: 20, height: 20)),
        );
      },
    );
  }
}
