// lib/core/navigation/app_router.dart
import 'package:auto_route/auto_route.dart';

import '../../features/favorites/presentation/screens/favorites_screen.dart';
import '../../features/quiz/presentation/screens/quiz_host_screen.dart';
import '../../features/search/presentation/screens/search_screen.dart';
import '../../features/shell/presentation/screens/main_navigation_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        // This is the main route that hosts the bottom navigation bar.
        // It has child routes that correspond to the tabs.
        AutoRoute(
          page: MainNavigationRoute.page,
          initial: true, // This makes it the default screen
          children: [
            AutoRoute(page: QuizHostRoute.page, path: 'quiz'),
            AutoRoute(page: SearchRoute.page, path: 'search'),
            AutoRoute(page: FavoritesRoute.page, path: 'favorites'),
          ],
        ),
        // We can add other routes that are pushed on top of the tabs here,
        // for example, the ArtworkDetailScreen.
      ];
}
