import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hacker_news/core/ui/navigation/routes.dart';

/// Navigation service for type-safe navigation throughout the app
class NavigationService {
  /// Navigate to home page
  static void goToHome(BuildContext context) {
    context.goNamed(kRouteHome);
  }

  /// Navigate to favorites page
  static void goToFavorites(BuildContext context) {
    context.goNamed(kRouteFavorites);
  }

  /// Navigate to settings page
  static void goToSettings(BuildContext context) {
    context.goNamed(kRouteSettings);
  }

  /// Navigate back
  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      // If can't pop, go to home
      goToHome(context);
    }
  }

  /// Pop with result (for dialogs)
  static void popWithResult<T>(BuildContext context, [T? result]) {
    context.pop<T>(result);
  }

  /// Push a route (for modals, dialogs, etc.)
  static Future<T?> pushToFavorites<T>(BuildContext context) =>
      context.pushNamed<T>(kRouteFavorites);

  /// Push a route (for modals, dialogs, etc.)
  static Future<T?> pushToSettings<T>(BuildContext context) =>
      context.pushNamed<T>(kRouteSettings);

  /// Navigate to licenses page
  static Future<T?> pushToLicenses<T>(
    BuildContext context,
    String appVersion,
  ) => context.pushNamed<T>(
    kRouteLicenses,
    queryParameters: {'version': appVersion},
  );

  /// Get current route name
  static String? getCurrentRouteName(BuildContext context) {
    final routeData = GoRouterState.of(context);
    return routeData.name;
  }

  /// Get current route path
  static String getCurrentRoutePath(BuildContext context) {
    final routeData = GoRouterState.of(context);
    return routeData.path ?? '/';
  }

  /// Check if current route is the given route
  static bool isCurrentRoute(BuildContext context, String routeName) {
    return getCurrentRouteName(context) == routeName;
  }

  /// Check if we can navigate back
  static bool canGoBack(BuildContext context) {
    return context.canPop();
  }
}
