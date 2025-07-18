// lib/core/di/service_locator.dart

import 'package:art_connoisseur_quiz/core/theme/theme_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/artwork/data/datasources/artwork_local_data_source.dart';
import '../../features/artwork/data/datasources/artwork_remote_data_source.dart';
import '../../features/artwork/data/repositories/artwork_repository_impl.dart';
import '../../features/artwork/domain/repositories/artwork_repository.dart';
import '../../features/artwork/domain/usecases/get_artworks_for_quiz.dart';
import '../../features/artwork/domain/usecases/get_favorite_artworks.dart';
import '../../features/artwork/domain/usecases/search_artworks.dart';
import '../../features/artwork/domain/usecases/toggle_favorite_status.dart';

final GetIt getIt = GetIt.instance;

/// Initializes and configures all application dependencies.
Future<void> configureDependencies() async {
  // --- External ---
  // Register Dio for network requests as a singleton
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Register SharedPreferences, which requires an async factory
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // --- Data Layer ---
  // Register Data Sources as singletons, as they are stateless gateways
  getIt.registerLazySingleton<ArtworkRemoteDataSource>(
    () => ArtworkRemoteDataSourceImpl(dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<ArtworkLocalDataSource>(
    () => ArtworkLocalDataSourceImpl(sharedPreferences: getIt<SharedPreferences>()),
  );

  // Register the Repository implementation, also as a singleton
  // We register it by its abstract type for loose coupling
  getIt.registerLazySingleton<ArtworkRepository>(
    () => ArtworkRepositoryImpl(
      remoteDataSource: getIt<ArtworkRemoteDataSource>(),
      localDataSource: getIt<ArtworkLocalDataSource>(),
    ),
  );

  // --- Domain Layer (Use Cases) ---
  // Register Use Cases as factories, so a new instance is created each time
  getIt.registerFactory<GetArtworksForQuizUseCase>(
    () => GetArtworksForQuizUseCase(artworkRepository: getIt<ArtworkRepository>()),
  );
  getIt.registerFactory<SearchArtworksUseCase>(
    () => SearchArtworksUseCase(artworkRepository: getIt<ArtworkRepository>()),
  );
  getIt.registerFactory<GetFavoriteArtworksUseCase>(
    () => GetFavoriteArtworksUseCase(artworkRepository: getIt<ArtworkRepository>()),
  );
  getIt.registerFactory<ToggleFavoriteStatusUseCase>(
    () => ToggleFavoriteStatusUseCase(artworkRepository: getIt<ArtworkRepository>()),
  );
    getIt.registerLazySingleton<ThemeBloc>(
    () => ThemeBloc(getIt<SharedPreferences>()),
  );
}
