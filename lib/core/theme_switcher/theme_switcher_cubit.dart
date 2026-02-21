import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

class ThemeChangerCubit extends Cubit<ThemeMode> {
  ThemeChangerCubit() : super(ThemeMode.dark);

  void toggle() =>
      emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
}
