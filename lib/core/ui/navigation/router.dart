import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hacker_news/core/ui/navigation/routes.dart';
import 'package:hacker_news/core/ui/pages/not_found_page.dart';
import 'package:hacker_news/features/home/ui/pages/stories_page.dart';
import 'package:hacker_news/features/settings/ui/pages/settings_page.dart';

/// App router configuration class
abstract final class AppRouter {
  /// Creates the main router configuration
  static final instance = GoRouter(
    restorationScopeId: 'router',
    routes: _routes,
    errorPageBuilder: _errorPageBuilder,
  );

  /// Error page builder for 404 and other navigation errors
  static Page<void> _errorPageBuilder(
    BuildContext context,
    GoRouterState state,
  ) => NoTransitionPage(restorationId: 'not_found', child: NotFoundPage());

  /// App route definitions
  static final List<GoRoute> _routes = [
    GoRoute(
      path: '/',
      name: kRouteHome,
      pageBuilder: (context, state) => const NoTransitionPage(
        restorationId: kRouteHome,
        child: StoriesPage(),
      ),
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
              restorationId: kRouteLicenses,
              child: LicensePage(applicationVersion: appVersion),
            );
          },
        ),
      ],
      pageBuilder: (context, state) => const CupertinoPage(
        restorationId: kRouteSettings,
        child: SettingsPage(),
      ),
    ),
  ];
}
