import 'package:cubit/cubit.dart';
import 'package:hacker_news/features/newspaper/data/models/item_model.dart';
import 'package:hacker_news/features/newspaper/data/repositories/hackernews_repository.dart';
import 'package:meta/meta.dart';

part 'top_stories_state.dart';

class TopStoriesCubit extends Cubit<TopStoriesState> {
  TopStoriesCubit(this.repository) : super(TopStoriesInitial()) {
    loadStories();
  }

  final HackernewsRepository repository;

  void loadStories() async {
    emit(TopStoriesLoading());

    try {
      final stories = await repository.getTopstories();
      emit(TopStoriesLoaded(stories));
    } catch (e) {
      emit(TopStoriesError());
    }
  }
}
