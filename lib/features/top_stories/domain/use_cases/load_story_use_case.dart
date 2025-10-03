import 'package:flutter_core/flutter_core.dart';
import 'package:hacker_news/features/top_stories/data/models/item_model.dart';
import 'package:hacker_news/features/top_stories/data/repositories/hackernews_repo.dart';

class LoadStoryUseCase {
  LoadStoryUseCase({required this.newsRepo});

  final HackernewsRepo newsRepo;

  /// Loads top stories from hacker news and filters out all that the user has already seen
  Future<ItemModel> execute(int itemId) async {
    logger.i('Loading top story with id $itemId');

    return newsRepo.getItem(itemId);
  }
}
