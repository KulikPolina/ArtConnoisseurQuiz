// lib/features/quiz/presentation/bloc/quiz_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../artwork/domain/entities/artwork.dart';
import '../../../artwork/domain/usecases/get_artworks_for_quiz.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

const int _quizSize = 10;

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc({
    required this.getArtworksForQuizUseCase,
  }) : super(QuizInitial()) {
    on<StartQuiz>(_onStartQuiz);
    on<AnswerSelected>(_onAnswerSelected);
  }

  final GetArtworksForQuizUseCase getArtworksForQuizUseCase;

  /// Handles the logic to start a new quiz.
  Future<void> _onStartQuiz(StartQuiz event, Emitter<QuizState> emit) async {
    emit(QuizLoading());
    try {
      // Fetch a list of artworks for the quiz.
      final artworks = await getArtworksForQuizUseCase.execute((limit: _quizSize, page: 1));
      
      // We need at least 4 artworks to generate 1 correct and 3 incorrect options.
      if (artworks.length < 4) {
        emit(const QuizError(message: 'Not enough artworks to start a quiz.'));
        return;
      }

      final questions = _createQuestions(artworks);
      emit(QuizInProgress(questions: questions));
    } catch (e) {
      emit(QuizError(message: 'Failed to load quiz: ${e.toString()}'));
    }
  }

  /// Handles the event when a user selects an answer.
  void _onAnswerSelected(AnswerSelected event, Emitter<QuizState> emit) {
    final currentState = state as QuizInProgress;
    final bool isCorrect = event.selectedArtist == currentState.currentQuestion.correctArtist;
    final int newScore = isCorrect ? currentState.score + 1 : currentState.score;

    final bool isLastQuestion = currentState.currentQuestionIndex == currentState.questions.length - 1;

    if (isLastQuestion) {
      // If it's the last question, move to the Finished state.
      emit(QuizFinished(score: newScore, totalQuestions: currentState.questions.length));
    } else {
      // Otherwise, move to the next question, updating the index and score.
      emit(currentState.copyWith(
        currentQuestionIndex: currentState.currentQuestionIndex + 1,
        score: newScore,
      ));
    }
  }

  /// Helper method to transform a list of artworks into a list of questions.
  List<QuizQuestion> _createQuestions(List<Artwork> artworks) {
    // Get a unique list of all available artist names.
    final List<String> allArtists = artworks
        .map((art) => art.artistDisplay ?? 'Unknown Artist')
        .where((artist) => artist != 'Unknown Artist')
        .toSet()
        .toList();

    // Create a question for each artwork.
    return artworks.map((artwork) {
      final String correctArtist = artwork.artistDisplay ?? 'Unknown Artist';
      
      // Create a list of other artists to use as wrong options.
      final List<String> otherArtists = List<String>.from(allArtists)..remove(correctArtist);
      otherArtists.shuffle();
      
      // Combine the correct artist with 3 wrong options.
      final List<String> options = [correctArtist];
      options.addAll(otherArtists.take(3));
      options.shuffle();

      return QuizQuestion(
        artwork: artwork,
        correctArtist: correctArtist,
        options: options,
      );
    }).toList();
  }
}
