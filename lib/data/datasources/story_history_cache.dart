import 'package:hacker_news/data/models/story_history_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Stores seen storys for 30 days.
/// 
/// This is used to hide already seen storys from the feed.
class StoryHistoryCache {
  static const boxName = 'story_history';

  final _box = Hive.box(boxName);
  final _maxAge = const Duration(days: 30);

  /// Adds a story to the favorites box.
  Future<void> add(int storyId) => _box.put(storyId, StoryHistoryItem(storyId: storyId, dateAdded: DateTime.now()).toJSON());

  /// Delete all entries older than [_maxAge]
  void cleanup() {
    for (final item in all) {
      final diff = DateTime.now().difference(item.dateAdded);

      if (diff > _maxAge) {
        _delete(item.storyId);
      }
    }
  }

  /// Returns all entries inside the favorites box.
  List<StoryHistoryItem> get all => _box.values
    .map((e) => StoryHistoryItem.fromJSON(Map<String, dynamic>.from(e)))
    .toList();

  Future<void> _delete(int storyId) => _box.delete(storyId);
}
