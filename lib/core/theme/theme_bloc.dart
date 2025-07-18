// lib/core/theme/theme_bloc.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_event.dart';

const String _kThemePersistenceKey = 'app_theme_mode';

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc(this._sharedPreferences) : super(ThemeMode.system) {
    // When the BLoC is created, immediately add the event to load the theme.
    on<ThemeLoaded>(_onThemeLoaded);
    on<ThemeToggled>(_onThemeToggled);
    add(ThemeLoaded());
  }

  final SharedPreferences _sharedPreferences;

  /// Handles loading the saved theme from local storage.
  void _onThemeLoaded(ThemeLoaded event, Emitter<ThemeMode> emit) {
    final String? savedTheme = _sharedPreferences.getString(_kThemePersistenceKey);
    if (savedTheme == 'light') {
      emit(ThemeMode.light);
    } else if (savedTheme == 'dark') {
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.system);
    }
  }

  /// Handles toggling between light and dark mode and saving the choice.
  void _onThemeToggled(ThemeToggled event, Emitter<ThemeMode> emit) {
    final newTheme = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    _sharedPreferences.setString(_kThemePersistenceKey, newTheme.name);
    emit(newTheme);
  }
}
