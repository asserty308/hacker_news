import 'package:cubit/cubit.dart';
import 'package:hacker_news/features/stories/data/models/item_model.dart';
import 'package:hacker_news/features/stories/data/repositories/hackernews_repository.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

part 'top_stories_state.dart';

class TopStoriesCubit extends Cubit<TopStoriesState> {
  TopStoriesCubit(this.repository) : super(TopStoriesInitial()) {
    loadStories();
  }

  final HackernewsRepository repository;

  void loadStories() async {
    emit(TopStoriesLoading());

    try {
      final stories = await repository.getTopstories(30);
      emit(TopStoriesLoaded(stories));
    } catch (e) {
      emit(TopStoriesError());
    }
  }

  /// Shows a browser with the story url.
  /// Does not emit a new state as the browser is just a overlay.
  void openStory(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    }
  }
}
