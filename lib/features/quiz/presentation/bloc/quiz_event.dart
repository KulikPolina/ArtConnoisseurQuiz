// lib/features/quiz/presentation/bloc/quiz_event.dart

import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

/// Event to start a new quiz session.
class StartQuiz extends QuizEvent {}

/// Event triggered when a user selects an answer.
class AnswerSelected extends QuizEvent {
  const AnswerSelected({required this.selectedArtist});

  final String selectedArtist;

  @override
  List<Object> get props => [selectedArtist];
}
