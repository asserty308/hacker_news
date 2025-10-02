import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';
import 'package:hacker_news/core/navigation/extensions/navigation_context.dart';
import 'package:hacker_news/core/navigation/routes.dart';
import 'package:hacker_news/features/favorites/ui/pages/favorites_page.dart';
import 'package:hacker_news/features/settings/ui/pages/settings_page.dart';
import 'package:hacker_news/features/top_stories/ui/pages/top_stories_page.dart';

/// App router configuration class
class AppRouter {
  AppRouter._();

  /// Creates the main router configuration
  static final instance = GoRouter(
    restorationScopeId: 'app-router',
    initialLocation: kRouteHome,
    routes: _routes,
    errorPageBuilder: _errorPageBuilder,
  );

  /// Error page builder for 404 and other navigation errors
  static Page<void> _errorPageBuilder(
    BuildContext context,
    GoRouterState state,
  ) => NoTransitionPage(
    child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            vGap16,
            const Text(
              'Page Not Found',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            vGap8,
            const Text('The requested page could not be found.'),
            vGap16,
            TextButton(
              onPressed: () => context.goToHome(),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    ),
  );

  /// App route definitions
  static final List<GoRoute> _routes = [
    GoRoute(
      path: '/',
      name: kRouteHome,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: TopStoriesPage()),
    ),
    GoRoute(
      path: '/favorites',
      name: kRouteFavorites,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: FavoritesPage()),
    ),
    GoRoute(
      path: '/settings',
      name: kRouteSettings,
      routes: [
        GoRoute(
          path: kRouteLicenses,
          name: kRouteLicenses,
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
