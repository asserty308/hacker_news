import 'package:flutter_core/flutter_core.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/data/repositories/hackernews_repo.dart';
import 'package:hacker_news/data/repositories/story_history_repo.dart';

class LoadTopStoriesUseCase {
  LoadTopStoriesUseCase({required this.newsRepo, required this.historyRepo});

  final HackernewsRepo newsRepo;
  final StoryHistoryRepo historyRepo;

  /// Loads top stories from hacker news and filters out all that the user has already seen
  Future<List<ItemModel>> execute({
    required int loadAmount,
    required int currentIndex,
  }) async {
    logger.i('Loading $loadAmount top stories from index $currentIndex');

    final ids = await newsRepo.getTopstoriesIds(
      loadAmount,
      start: currentIndex,
    );

    final unreadIds = ids
        .where((e) => !historyRepo.allIds.contains(e))
        .toList();

    if (unreadIds.isEmpty) {
      logger.i(
        'All stories at index $currentIndex have been read, moving to next batch',
      );
      // Return empty list to indicate we should load more
      return [];
    }

    logger.i('Loading ${unreadIds.length} unread stories: $unreadIds');

    final futures = unreadIds.map(newsRepo.getItem);
    final stories = await Future.wait(futures);

    return stories;
  }
}
