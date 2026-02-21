import 'package:breathing_app/ui/features/setup/bloc/setup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetupCubit extends Cubit<SetupState> {
  SetupCubit() : super(const SetupState());

  void setBreathDuration(int duration) {
    emit(state.copyWith(breathDuration: duration));
  }

  void setRounds(int rounds) {
    emit(state.copyWith(rounds: rounds));
  }

  void toggleSound() {
    emit(state.copyWith(soundEnabled: !state.soundEnabled));
  }

  void toggleAdvanced() {
    final isExpanding = !state.isAdvancedExpanded;

    if (isExpanding) {
      // Expanding: initialize advanced values from simple duration
      emit(
        state.copyWith(
          isAdvancedExpanded: true,
          breatheIn: state.breathDuration,
          holdIn: state.breathDuration,
          breatheOut: state.breathDuration,
          holdOut: state.breathDuration,
        ),
      );
    } else {
      // Collapsing: reset advanced values
      emit(
        state.copyWith(
          isAdvancedExpanded: false,
          breatheIn: 4,
          holdIn: 4,
          breatheOut: 4,
          holdOut: 4,
        ),
      );
    }
  }

  void setBreatheIn(int value) {
    emit(state.copyWith(breatheIn: value.clamp(2, 10)));
  }

  void setHoldIn(int value) {
    emit(state.copyWith(holdIn: value.clamp(2, 10)));
  }

  void setBreatheOut(int value) {
    emit(state.copyWith(breatheOut: value.clamp(2, 10)));
  }

  void setHoldOut(int value) {
    emit(state.copyWith(holdOut: value.clamp(2, 10)));
  }
}
