import 'package:breathing_app/models/activity_config.dart';
import 'package:equatable/equatable.dart';

class SetupState extends Equatable {
  final int breathDuration; // 2, 4, 5, 10 seconds
  final int rounds; // 2, 4, 6, 8 minutes
  final bool soundEnabled;
  final bool isAdvancedExpanded;
  final int breatheIn;
  final int holdIn;
  final int breatheOut;
  final int holdOut;

  const SetupState({
    this.breathDuration = 4,
    this.rounds = 4,
    this.soundEnabled = true,
    this.isAdvancedExpanded = false,
    this.breatheIn = 4,
    this.holdIn = 4,
    this.breatheOut = 4,
    this.holdOut = 4,
  });

  // Returns effective timings (advanced if expanded, else simple duration)
  int get effectiveBreatheIn => isAdvancedExpanded ? breatheIn : breathDuration;
  int get effectiveHoldIn => isAdvancedExpanded ? holdIn : breathDuration;
  int get effectiveBreatheOut =>
      isAdvancedExpanded ? breatheOut : breathDuration;
  int get effectiveHoldOut => isAdvancedExpanded ? holdOut : breathDuration;

  ActivityConfig toActivityConfig() {
    return ActivityConfig(
      breatheIn: effectiveBreatheIn,
      holdIn: effectiveHoldIn,
      breatheOut: effectiveBreatheOut,
      holdOut: effectiveHoldOut,
      rounds: rounds,
      soundEnabled: soundEnabled,
    );
  }

  SetupState copyWith({
    int? breathDuration,
    int? rounds,
    bool? soundEnabled,
    bool? isAdvancedExpanded,
    int? breatheIn,
    int? holdIn,
    int? breatheOut,
    int? holdOut,
  }) {
    return SetupState(
      breathDuration: breathDuration ?? this.breathDuration,
      rounds: rounds ?? this.rounds,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      isAdvancedExpanded: isAdvancedExpanded ?? this.isAdvancedExpanded,
      breatheIn: breatheIn ?? this.breatheIn,
      holdIn: holdIn ?? this.holdIn,
      breatheOut: breatheOut ?? this.breatheOut,
      holdOut: holdOut ?? this.holdOut,
    );
  }

  @override
  List<Object?> get props => [
    breathDuration,
    rounds,
    soundEnabled,
    isAdvancedExpanded,
    breatheIn,
    holdIn,
    breatheOut,
    holdOut,
  ];
}
