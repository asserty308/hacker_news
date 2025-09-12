import 'package:hacker_news/features/top_stories/data/datasources/story_history_cache.dart';

class StoryHistoryRepo {
  final _cache = StoryHistoryCache();

  Future<void> add(int storyId) => _cache.add(storyId);

  Future<void> cleanup() => _cache.cleanup();

  /// Returns a Set as a story cannot be read multiple times.
  ///
  /// Another advantage is that List.contains is an O(n) opereation where Set.contains is an O(1),
  /// which increases the performance for huge lists.
  Set<int> get allIds => _cache.all.map((e) => e.storyId).toSet();

  Future<void> clear() => _cache.clear();
}
