// lib/features/quiz/presentation/screens/quiz_host_screen.dart

import 'package:art_connoisseur_quiz/features/quiz/presentation/bloc/quiz_event.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../artwork/domain/usecases/get_artworks_for_quiz.dart';
import '../bloc/quiz_bloc.dart';
import '../widgets/quiz_body.dart';

@RoutePage()
class QuizHostScreen extends StatelessWidget {
  const QuizHostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizBloc>(
      create: (context) => QuizBloc(
        getArtworksForQuizUseCase: getIt<GetArtworksForQuizUseCase>(),
      )..add(StartQuiz()), // Start the quiz immediately
      child: const QuizBody(),
    );
  }
}
