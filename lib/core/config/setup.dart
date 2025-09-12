import 'package:hacker_news/features/favorites/data/datasources/favorites_cache.dart';
import 'package:hacker_news/features/top_stories/data/datasources/story_history_cache.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

PackageInfo? appPackageInfo;

Future<void> setupApp() async {
  appPackageInfo = await PackageInfo.fromPlatform();

  await _initStorages();
}

Future<void> _initStorages() async {
  await Hive.initFlutter();
  await Future.wait([
    Hive.openBox(FavoritesCache.boxName),
    Hive.openBox(StoryHistoryCache.boxName),
  ]);
}
