import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/cham_culture/presentation/cham_article_detail_screen.dart';
import '../features/cham_culture/presentation/cham_articles_screen.dart';
import '../features/contributions/presentation/moderator_queue_screen.dart';
import '../features/contributions/presentation/submit_place_screen.dart';
import '../features/explore/presentation/explore_screen.dart';
import '../features/favorites/presentation/favorites_screen.dart';
import '../features/map/presentation/map_screen.dart';
import '../features/places/presentation/place_detail_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../l10n/app_localizations.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/explore',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/explore',
              builder: (context, state) => const ExploreScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/map',
              builder: (context, state) => const MapScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/saved',
              builder: (context, state) => const FavoritesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/place/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? 'p1';
        return PlaceDetailScreen(placeId: id);
      },
    ),
    GoRoute(
      path: '/submit',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return const SubmitPlaceScreen();
      },
    ),
    GoRoute(
      path: '/moderator',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return const ModeratorQueueScreen();
      },
    ),
    GoRoute(
      path: '/cham-articles',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return const ChamArticlesScreen();
      },
    ),
    GoRoute(
      path: '/article/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? 'art_1';
        return ChamArticleDetailScreen(articleId: id);
      },
    ),
  ],
);

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.explore_outlined),
            activeIcon: const Icon(Icons.explore),
            label: l10n?.navExplore ?? 'Explore',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.map_outlined),
            activeIcon: const Icon(Icons.map),
            label: l10n?.navMap ?? 'Map',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bookmark_outline),
            activeIcon: const Icon(Icons.bookmark),
            label: l10n?.navSaved ?? 'Saved',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            activeIcon: const Icon(Icons.settings),
            label: l10n?.navSettings ?? 'Settings',
          ),
        ],
      ),
    );
  }
}
