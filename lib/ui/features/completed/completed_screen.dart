import 'package:breathing_app/core/constants/assets.dart';
import 'package:breathing_app/core/extensions/context_ext.dart';
import 'package:breathing_app/models/activity_config.dart';
import 'package:breathing_app/ui/features/activity/activity_screen.dart';
import 'package:breathing_app/ui/features/setup/setup_screen.dart';
import 'package:breathing_app/ui/global_widgets/spacings.dart';
import 'package:breathing_app/ui/global_widgets/theme_change_button.dart';
import 'package:breathing_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CompletionScreen extends StatelessWidget {
  static String routeName = '/completion_screen';

  final ActivityConfig config;

  const CompletionScreen({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: const [ThemeChangeButton(), HSpacer(16)],
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF4CAF50),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 48,
                  color: Colors.white,
                ),
              ),
              VSpacer(32),
              Text(
                'You did it! 🎉',
                style: GoogleFonts.quicksand(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimary,
                ),
              ),
              VSpacer(12),
              Text(
                'Great rounds of calm, just like that. Your mind thanks you.',
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(flex: 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushReplacement(
                      ActivityScreen.routeName,
                      extra: config,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Start again'),
                      const SizedBox(width: 8),
                      SvgPicture.asset(
                        Assets.iconsFastWind,
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    context.go(SetupScreen.routeName);
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: context.themed(
                      light: Colors.white,
                      dark: Colors.white.withOpacity(0.08),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Back to set up',
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: context.textPrimary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
