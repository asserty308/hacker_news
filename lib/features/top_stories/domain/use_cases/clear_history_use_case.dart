import 'package:hacker_news/features/top_stories/data/repositories/story_history_repo.dart';
import 'package:hacker_news/features/top_stories/ui/blocs/top_stories/top_stories_cubit.dart';

class ClearHistoryUseCase {
  ClearHistoryUseCase({
    required this.storyHistoryRepo,
    required this.topStoriesCubit,
  });

  final StoryHistoryRepo storyHistoryRepo;
  final TopStoriesCubit topStoriesCubit;

  Future<void> execute() async {
    await storyHistoryRepo.clear();
    await topStoriesCubit.refresh(true);
  }
}
