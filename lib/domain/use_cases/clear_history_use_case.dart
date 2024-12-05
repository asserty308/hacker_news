import 'package:hacker_news/data/repositories/story_history_repo.dart';
import 'package:hacker_news/ui/blocs/top_stories/top_stories_cubit.dart';

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
