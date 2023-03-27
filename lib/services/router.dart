import 'package:go_router/go_router.dart';
import 'package:hacker_news/ui/pages/favorites_page.dart';
import 'package:hacker_news/ui/pages/top_stories_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => NoTransitionPage(child: TopStoriesPage()),
    ),
    GoRoute(
      path: '/favorites',
      pageBuilder: (context, state) => NoTransitionPage(child: FavoritesPage()),
    ),
  ],
);