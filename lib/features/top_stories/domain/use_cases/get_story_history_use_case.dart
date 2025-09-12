import 'package:hacker_news/features/top_stories/data/repositories/story_history_repo.dart';

class GetStoryHistoryUseCase {
  GetStoryHistoryUseCase({required this.historyRepo});

  final StoryHistoryRepo historyRepo;

  /// Returns a Set of all story IDs that have been read
  Set<int> execute() {
    return historyRepo.allIds;
  }
}
