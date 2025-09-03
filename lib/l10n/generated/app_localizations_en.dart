// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Hacker News';

  @override
  String nSecondsAgo(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString seconds ago',
      one: '1 second ago',
    );
    return '$_temp0';
  }

  @override
  String nMinutesAgo(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString minutes ago',
      one: '1 minute ago',
    );
    return '$_temp0';
  }

  @override
  String nHoursAgo(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString hours ago',
      one: '1 hour ago',
    );
    return '$_temp0';
  }

  @override
  String nDaysAgo(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString days ago',
      one: '1 day ago',
    );
    return '$_temp0';
  }

  @override
  String get topStories => 'Top Stories';

  @override
  String get favorites => 'Favorites';

  @override
  String get settings => 'Settings';

  @override
  String get osl => 'Open Source Licenses';

  @override
  String appVersion(String version) {
    return 'Version $version';
  }

  @override
  String get emptyFavoritesHint => 'No favorites saved';

  @override
  String get setToRemoveFromFavorites => 'Story will be removed in 4 seconds';

  @override
  String get undo => 'Undo';

  @override
  String get sourceCode => 'Source Code';

  @override
  String get clearHistoryCacheTileTitle => 'Clear History Cache';

  @override
  String get clearHistoryCacheTileSubtitle =>
      'This will make already seen stories appear again';

  @override
  String get clearHistoryCacheDialogTitle => 'Clear history cache';

  @override
  String get clearHistoryCacheDialogBody =>
      'Do you really want to clear the history cache? Doing this you will get all stories you\'ve already seen again.';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get myFavoritesTileTitle => 'My favorites';

  @override
  String get loginButton => 'Login';

  @override
  String get logoutButton => 'Logout';

  @override
  String get loading => 'Loading...';

  @override
  String get errorLoadingStories => 'Error loading stories';

  @override
  String get errorLoadingFavorites => 'Error loading favorites';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get retry => 'Retry';

  @override
  String get networkError => 'Network error. Please check your connection.';

  @override
  String get unexpectedError => 'An unexpected error occurred';

  @override
  String get storiesLoading => 'Loading stories...';

  @override
  String get favoritesLoading => 'Loading favorites...';

  @override
  String get refreshing => 'Refreshing...';

  @override
  String get noInternetConnection => 'No internet connection';

  @override
  String get accessibilityOpenStory => 'Open story';

  @override
  String get accessibilityAddToFavorites => 'Add to favorites';

  @override
  String get accessibilityRemoveFromFavorites => 'Remove from favorites';

  @override
  String get accessibilityShareStory => 'Share story';

  @override
  String get accessibilitySettings => 'Settings';

  @override
  String get accessibilityBackButton => 'Back';
}
