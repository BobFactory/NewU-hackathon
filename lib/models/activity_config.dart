import 'package:equatable/equatable.dart';

class ActivityConfig extends Equatable {
  final int breatheIn;
  final int holdIn;
  final int breatheOut;
  final int holdOut;
  final int rounds;
  final bool soundEnabled;

  const ActivityConfig({
    required this.breatheIn,
    required this.holdIn,
    required this.breatheOut,
    required this.holdOut,
    required this.rounds,
    required this.soundEnabled,
  });

  @override
  List<Object?> get props => [
    breatheIn,
    holdIn,
    breatheOut,
    holdOut,
    rounds,
    soundEnabled,
  ];
}
