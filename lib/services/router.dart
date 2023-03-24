import 'package:go_router/go_router.dart';
import 'package:hacker_news/ui/screens/favorites_screen.dart';
import 'package:hacker_news/ui/screens/top_stories_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => NoTransitionPage(child: TopStoriesScreen()),
    ),
    GoRoute(
      path: '/favorites',
      pageBuilder: (context, state) => NoTransitionPage(child: FavoritesScreen()),
    ),
  ],
);