// lib/core/theme/theme_event.dart

import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

/// Event dispatched to load the saved theme from storage.
class ThemeLoaded extends ThemeEvent {}

/// Event dispatched when the user taps the theme toggle button.
class ThemeToggled extends ThemeEvent {}
