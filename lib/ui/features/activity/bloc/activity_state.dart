import 'package:equatable/equatable.dart';

enum BreathingPhase { breatheIn, holdIn, breatheOut, holdOut }

enum PhaseOperationType { ascending, descending }

class ActivityState extends Equatable {
  final BreathingPhase currentPhase;
  final BreathingPhase? nextPhase;
  final int currentRound;
  final int totalRounds;
  final int secondsElapsed;
  final int currentPhaseDuration;
  final bool isPaused;
  final bool isCountdownComplete;
  final PhaseOperationType phaseOperationType;
  final bool isCompleted;

  String get phaseLabel {
    // if (isComplete) return 'Complete';
    switch (currentPhase) {
      case BreathingPhase.breatheIn:
        return 'Breathe in';
      case BreathingPhase.holdIn:
        return 'Hold';
      case BreathingPhase.breatheOut:
        return 'Breathe out';
      case BreathingPhase.holdOut:
        return 'Hold';
    }
  }

  String get bubbleText {
    if (isCompleted) return '✓';
    return switch (currentPhase) {
      BreathingPhase.breatheIn => '$secondsElapsed',
      BreathingPhase.breatheOut =>
        '${currentPhaseDuration - secondsElapsed + 1}',
      BreathingPhase.holdIn || BreathingPhase.holdOut => '',
    };
  }

  const ActivityState({
    this.isCountdownComplete = false,
    this.isPaused = false,
    this.currentPhase = BreathingPhase.breatheIn,
    this.nextPhase,
    this.currentRound = 1,
    this.totalRounds = 4,
    this.secondsElapsed = 0,
    this.currentPhaseDuration = 4,
    this.phaseOperationType = .ascending,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [
    isCountdownComplete,
    isPaused,
    currentPhase,
    nextPhase,
    currentRound,
    totalRounds,
    secondsElapsed,
    currentPhaseDuration,
    phaseOperationType,
    isCompleted,
  ];

  ActivityState copyWith({
    BreathingPhase? currentPhase,
    BreathingPhase? Function()? nextPhase,
    int? currentRound,
    int? totalRounds,
    int? secondsElapsed,
    int? currentPhaseDuration,
    bool? isPaused,
    bool? isCountdownComplete,
    PhaseOperationType? phaseOperationType,
    bool? isCompleted,
  }) {
    return ActivityState(
      currentPhase: currentPhase ?? this.currentPhase,
      nextPhase: nextPhase != null ? nextPhase() : this.nextPhase,
      currentRound: currentRound ?? this.currentRound,
      totalRounds: totalRounds ?? this.totalRounds,
      secondsElapsed: secondsElapsed ?? this.secondsElapsed,
      currentPhaseDuration: currentPhaseDuration ?? this.currentPhaseDuration,
      isPaused: isPaused ?? this.isPaused,
      isCountdownComplete: isCountdownComplete ?? this.isCountdownComplete,
      phaseOperationType: phaseOperationType ?? this.phaseOperationType,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
