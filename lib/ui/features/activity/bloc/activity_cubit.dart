import 'dart:async';

import 'package:breathing_app/models/activity_config.dart';
import 'package:breathing_app/ui/features/activity/bloc/activity_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final ActivityConfig config;
  Timer? _timer;

  ActivityCubit({required this.config})
    : super(ActivityState(totalRounds: config.rounds));

  void onCountdownComplete() {
    emit(state.copyWith(isCountdownComplete: true));
    startPhase(BreathingPhase.breatheIn);
  }

  void startPhase(BreathingPhase phase) {
    final duration = switch (phase) {
      BreathingPhase.breatheIn => config.breatheIn,
      BreathingPhase.holdIn => config.holdIn,
      BreathingPhase.breatheOut => config.breatheOut,
      BreathingPhase.holdOut => config.holdOut,
    };

    final nextPhase = (BreathingPhase phase) {
      var index = BreathingPhase.values.indexOf(phase);
      var nextIndex = index + 1;

      if (nextIndex >= BreathingPhase.values.length) {
        return null;
      }

      return BreathingPhase.values[nextIndex];
    }(phase);

    emit(
      state.copyWith(
        currentPhase: phase,
        currentPhaseDuration: duration,
        secondsElapsed: 1,
        nextPhase: () => nextPhase,
        phaseOperationType: phase == .breatheOut ? .descending : .ascending,
      ),
    );

    _startTimer(duration);
  }

  void _onPhaseEnded() {
    final nextPhase = state.nextPhase;

    if (nextPhase != null) {
      startPhase(nextPhase);
    } else {
      // Round complete
      final newRound = state.currentRound + 1;
      if (newRound > state.totalRounds) {
        emit(state.copyWith(isCompleted: true));
      } else {
        emit(state.copyWith(currentRound: newRound));
        startPhase(BreathingPhase.breatheIn);
      }
    }
  }

  void _startTimer(int duration) {
    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      //Guard for blocking when paused.
      if (isClosed || state.isPaused) {
        _timer?.cancel();
        return;
      }

      final newElapsed = state.secondsElapsed + 1;

      if (newElapsed <= duration) {
        emit(state.copyWith(secondsElapsed: newElapsed));
      } else {
        _timer?.cancel();
        _onPhaseEnded();
      }
    });
  }

  void togglePause() {
    if (state.isCompleted) return;

    if (state.isPaused) {
      emit(state.copyWith(isPaused: false));
      _startTimer(state.currentPhaseDuration - state.secondsElapsed);
    } else {
      _timer?.cancel();
      emit(state.copyWith(isPaused: true));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _timer = null;
    return super.close();
  }
}
