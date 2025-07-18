// lib/features/quiz/presentation/bloc/quiz_state.dart

import 'package:equatable/equatable.dart';
import '../../../artwork/domain/entities/artwork.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

/// The initial state before a quiz has started.
class QuizInitial extends QuizState {}

/// State while artworks are being fetched for the quiz.
class QuizLoading extends QuizState {}

/// The main state during an active quiz session.
class QuizInProgress extends QuizState {
  const QuizInProgress({
    required this.questions,
    this.currentQuestionIndex = 0,
    this.score = 0,
  });

  final List<QuizQuestion> questions;
  final int currentQuestionIndex;
  final int score;

  // Helper getter for the current question
  QuizQuestion get currentQuestion => questions[currentQuestionIndex];

  @override
  List<Object> get props => [questions, currentQuestionIndex, score];

  QuizInProgress copyWith({
    int? currentQuestionIndex,
    int? score,
  }) {
    return QuizInProgress(
      questions: questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      score: score ?? this.score,
    );
  }
}

/// State when the quiz has been completed.
class QuizFinished extends QuizState {
  const QuizFinished({required this.score, required this.totalQuestions});

  final int score;
  final int totalQuestions;

  @override
  List<Object> get props => [score, totalQuestions];
}

/// State when an error occurs during quiz setup.
class QuizError extends QuizState {
  const QuizError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

/// A helper class to structure a single quiz question.
class QuizQuestion extends Equatable {
  const QuizQuestion({
    required this.artwork,
    required this.correctArtist,
    required this.options,
  });

  final Artwork artwork;
  final String correctArtist;
  final List<String> options;

  @override
  List<Object> get props => [artwork, correctArtist, options];
}
