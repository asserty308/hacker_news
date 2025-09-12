import 'package:hacker_news/features/top_stories/data/repositories/story_history_repo.dart';

class AddStoryToHistoryUseCase {
  AddStoryToHistoryUseCase({required this.historyRepo});

  final StoryHistoryRepo historyRepo;

  Future<void> execute(int storyId) async {
    await historyRepo.add(storyId);
  }
}
