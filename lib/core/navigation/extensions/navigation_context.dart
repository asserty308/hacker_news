import 'package:flutter/widgets.dart';
import 'package:hacker_news/core/navigation/navigation_service.dart';

/// Extension on BuildContext for convenient navigation
extension NavigationExtension on BuildContext {
  /// Navigate to home page
  void goToHome() => NavigationService.goToHome(this);

  /// Navigate to favorites page
  void goToFavorites() => NavigationService.goToFavorites(this);

  /// Navigate to settings page
  void goToSettings() => NavigationService.goToSettings(this);

  /// Navigate back
  void goBack() => NavigationService.goBack(this);

  /// Pop with result (for dialogs)
  void popWithResult<T>([T? result]) =>
      NavigationService.popWithResult(this, result);

  /// Push to favorites page
  Future<T?> pushToFavorites<T>() => NavigationService.pushToFavorites<T>(this);

  /// Push to settings page
  Future<T?> pushToSettings<T>() => NavigationService.pushToSettings<T>(this);

  /// Push to licenses page
  Future<T?> pushToLicenses<T>(String appVersion) =>
      NavigationService.pushToLicenses<T>(this, appVersion);

  /// Get current route name
  String? get currentRouteName => NavigationService.getCurrentRouteName(this);

  /// Get current route path
  String get currentRoutePath => NavigationService.getCurrentRoutePath(this);

  /// Check if current route is the given route
  bool isCurrentRoute(String routeName) =>
      NavigationService.isCurrentRoute(this, routeName);

  /// Check if we can navigate back
  bool get canGoBack => NavigationService.canGoBack(this);
}
