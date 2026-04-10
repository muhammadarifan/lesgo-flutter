import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class ThemeEvent {}

class LoadTheme extends ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

class ThemeState {
  final bool isDark;
  final FThemeData? themeData;
  ThemeState(this.isDark, this.themeData);
}

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(false, null)) {
    on<LoadTheme>(_onToggleLoaded);
    on<ToggleTheme>(_onToggleTheme);
  }

  Future<void> _onToggleLoaded(
    LoadTheme event,
    Emitter<ThemeState> emit,
  ) async {
    try {
      final sp = await SharedPreferences.getInstance();
      final isDark = sp.getBool('THEME_IS_DARK') ?? false;

      final themeData = isDark
          ? FThemes.neutral.dark.touch
          : FThemes.neutral.light.touch;

      emit(ThemeState(isDark, themeData));
    } catch (e, s) {
      debugPrint('$e\n$s');
    }
  }

  Future<void> _onToggleTheme(
    ToggleTheme event,
    Emitter<ThemeState> emit,
  ) async {
    try {
      final sp = await SharedPreferences.getInstance();
      final isDark = sp.getBool('THEME_IS_DARK') ?? false;

      final themeData = isDark
          ? FThemes.neutral.light.touch
          : FThemes.neutral.dark.touch;

      sp.setBool('THEME_IS_DARK', !isDark);
      emit(ThemeState(isDark, themeData));
    } catch (e, s) {
      debugPrint('$e\n$s');
    }
  }
}
