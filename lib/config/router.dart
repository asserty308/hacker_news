import 'package:go_router/go_router.dart';
import 'package:hacker_news/ui/pages/favorites_page.dart';
import 'package:hacker_news/ui/pages/settings_page.dart';
import 'package:hacker_news/ui/pages/top_stories_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder:
          (context, state) => const NoTransitionPage(child: TopStoriesPage()),
    ),
    GoRoute(
      path: '/favorites',
      pageBuilder:
          (context, state) => const NoTransitionPage(child: FavoritesPage()),
    ),
    GoRoute(
      path: '/settings',
      pageBuilder:
          (context, state) => const NoTransitionPage(child: SettingsPage()),
    ),
  ],
);
