import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hacker_news/core/navigation/routes.dart';

/// Extension on BuildContext for convenient navigation
extension NavigationExtension on BuildContext {
  /// Navigate to home page
  void goToHome() => _NavigationService.goToHome(this);

  /// Navigate to favorites page
  void goToFavorites() => _NavigationService.goToFavorites(this);

  /// Navigate to settings page
  void goToSettings() => _NavigationService.goToSettings(this);

  /// Navigate back
  void goBack() => _NavigationService.goBack(this);

  /// Pop with result (for dialogs)
  void popWithResult<T>([T? result]) =>
      _NavigationService.popWithResult(this, result);

  /// Push to favorites page
  void pushToFavorites() => _NavigationService.pushToFavorites(this);

  /// Push to settings page
  void pushToSettings() => _NavigationService.pushToSettings(this);

  /// Get current route name
  String? get currentRouteName => _NavigationService.getCurrentRouteName(this);

  /// Get current route path
  String get currentRoutePath => _NavigationService.getCurrentRoutePath(this);

  /// Check if current route is the given route
  bool isCurrentRoute(String routeName) =>
      _NavigationService.isCurrentRoute(this, routeName);

  /// Check if we can navigate back
  bool get canGoBack => _NavigationService.canGoBack(this);
}

/// Navigation service for type-safe navigation throughout the app
class _NavigationService {
  _NavigationService._();

  /// Navigate to home page
  static void goToHome(BuildContext context) {
    context.goNamed(AppRoutes.home);
  }

  /// Navigate to favorites page
  static void goToFavorites(BuildContext context) {
    context.goNamed(AppRoutes.favorites);
  }

  /// Navigate to settings page
  static void goToSettings(BuildContext context) {
    context.goNamed(AppRoutes.settings);
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
    context.pop(result);
  }

  /// Push a route (for modals, dialogs, etc.)
  static void pushToFavorites(BuildContext context) {
    context.pushNamed(AppRoutes.favorites);
  }

  /// Push a route (for modals, dialogs, etc.)
  static void pushToSettings(BuildContext context) {
    context.pushNamed(AppRoutes.settings);
  }

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
