// lib/features/quiz/presentation/widgets/quiz_body.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quiz_bloc.dart';
import '../bloc/quiz_event.dart';
import '../bloc/quiz_state.dart';

class QuizBody extends StatelessWidget {
  const QuizBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Art Connoisseur Quiz'),
      ),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          if (state is QuizLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is QuizError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          if (state is QuizInProgress) {
            final question = state.currentQuestion;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Score: ${state.score} | Question ${state.currentQuestionIndex + 1}/${state.questions.length}',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  if (question.artwork.imageUrl != null)
                    Image.network(
                      question.artwork.imageUrl!,
                      height: 300,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, progress) {
                        return progress == null
                            ? child
                            : const Center(child: CircularProgressIndicator());
                      },
                    ),
                  const SizedBox(height: 24),
                  Text(
                    'Who is the artist of "${question.artwork.title}"?',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ...question.options.map((option) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<QuizBloc>()
                              .add(AnswerSelected(selectedArtist: option));
                        },
                        child: Text(option),
                      ),
                    );
                  }),
                ],
              ),
            );
          }
          if (state is QuizFinished) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Quiz Finished!',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 16),
                  Text(
                      'Your final score is: ${state.score} / ${state.totalQuestions}',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.read<QuizBloc>().add(StartQuiz()),
                    child: const Text('Play Again'),
                  ),
                ],
              ),
            );
          }
          // Fallback for the initial state
          return Center(
            child: ElevatedButton(
              onPressed: () => context.read<QuizBloc>().add(StartQuiz()),
              child: const Text('Start Quiz'),
            ),
          );
        },
      ),
    );
  }
}
