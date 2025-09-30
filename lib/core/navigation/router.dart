import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';
import 'package:hacker_news/core/navigation/routes.dart';
import 'package:hacker_news/features/favorites/ui/pages/favorites_page.dart';
import 'package:hacker_news/features/settings/ui/pages/settings_page.dart';
import 'package:hacker_news/features/top_stories/ui/pages/top_stories_page.dart';

/// App router configuration class
class AppRouter {
  AppRouter._();

  /// Creates the main router configuration
  static GoRouter createRouter() => GoRouter(
    restorationScopeId: 'app-router',
    initialLocation: AppRoutes.homePath,
    routes: _routes,
    errorPageBuilder: _errorPageBuilder,
  );

  /// Error page builder for 404 and other navigation errors
  static Page<void> _errorPageBuilder(
    BuildContext context,
    GoRouterState state,
  ) => const NoTransitionPage(
    child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.grey),
            vGap16,
            Text(
              'Page Not Found',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            vGap8,
            Text('The requested page could not be found.'),
          ],
        ),
      ),
    ),
  );

  /// App route definitions
  static final List<GoRoute> _routes = [
    GoRoute(
      name: AppRoutes.home,
      path: AppRoutes.homePath,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: TopStoriesPage()),
    ),
    GoRoute(
      name: AppRoutes.favorites,
      path: AppRoutes.favoritesPath,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: FavoritesPage()),
    ),
    GoRoute(
      name: AppRoutes.settings,
      path: AppRoutes.settingsPath,
      routes: [
        GoRoute(
          name: AppRoutes.licenses,
          path: AppRoutes.licenses,
          pageBuilder: (context, state) {
            final appVersion = state.uri.queryParameters['version'] ?? 'n.A.';
            return NoTransitionPage(
              child: LicensePage(applicationVersion: appVersion),
            );
          },
        ),
      ],
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: SettingsPage()),
    ),
  ];
}
