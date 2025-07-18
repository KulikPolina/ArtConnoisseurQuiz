// lib/features/shell/presentation/screens/main_navigation_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../core/navigation/app_router.dart';

@RoutePage()
class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // AutoTabsRouter provides the logic for switching between tabs.
    return AutoTabsRouter(
      // The list of routes that will be rendered in the tabs.
      // The order must match the BottomNavigationBar items.
      routes: const [
        QuizHostRoute(),
        SearchRoute(),
        FavoritesRoute(),
      ],
      // The builder function provides the context, the child widget (the active tab's screen),
      // and the tabsRouter for controlling the active tab.
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          // The body is the currently active screen from the routes list.
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              // When a tab is tapped, we update the router's active index.
              tabsRouter.setActiveIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.quiz),
                label: 'Quiz',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
            ],
          ),
        );
      },
    );
  }
}
