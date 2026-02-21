import 'package:breathing_app/core/constants/assets.dart';
import 'package:breathing_app/core/extensions/context_ext.dart';
import 'package:breathing_app/ui/features/setup/widgets/advanced_timing.dart';
import 'package:breathing_app/ui/features/setup/widgets/selection_chip.dart';
import 'package:breathing_app/ui/features/setup/widgets/sound_selector.dart';
import 'package:breathing_app/ui/global_widgets/spacings.dart';
import 'package:breathing_app/ui/global_widgets/theme_change_button.dart';
import 'package:breathing_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SetupScreen extends StatelessWidget {
  static String routeName = '/setup_screen';

  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [ThemeChangeButton(), SizedBox(width: 16)],
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
                      Row(
                        mainAxisSize: .max,
                        spacing: 8,
                        children: [
                          SelectionChip(
                            label: "2s",
                            isSelected: false,
                            onTap: () {},
                          ),
                          SelectionChip(
                            label: "4s",
                            isSelected: true,
                            onTap: () {},
                          ),
                          SelectionChip(
                            label: "5s",
                            isSelected: false,
                            onTap: () {},
                          ),
                          SelectionChip(
                            label: "10s",
                            isSelected: false,
                            onTap: () {},
                          ),
                        ],
                      ),

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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: .max,
                          spacing: 8,
                          children: [
                            SelectionChip(
                              label: "2 min",
                              isSelected: false,
                              onTap: () {},
                            ),
                            SelectionChip(
                              label: "4 min",
                              isSelected: true,
                              onTap: () {},
                            ),
                            SelectionChip(
                              label: "6 min",
                              isSelected: false,
                              onTap: () {},
                            ),
                            SelectionChip(
                              label: "8 min",
                              isSelected: false,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),

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
                onPressed: () {},
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
