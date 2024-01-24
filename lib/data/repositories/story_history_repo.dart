import 'package:hacker_news/data/datasources/story_history_cache.dart';

final historyRepo = StoryHistoryRepo();

class StoryHistoryRepo {
  final _cache = StoryHistoryCache();

  Future<void> add(int storyId) => _cache.add(storyId);

  void cleanup() => _cache.cleanup();

  List<int> get allIds => _cache.all.map((e) => e.storyId).toList();
}