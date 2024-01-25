import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/data/repositories/hackernews_repo.dart';
import 'package:hacker_news/data/repositories/story_history_repo.dart';
import 'package:meta/meta.dart';

part 'top_stories_state.dart';

class TopStoriesCubit extends Cubit<TopStoriesState> {
  TopStoriesCubit({
    required this.newsRepo,
    required this.historyRepo,
  }) : super(TopStoriesInitial());

  final HackernewsRepo newsRepo;
  final StoryHistoryRepo historyRepo;

  final _loadAmount = 5;

  Future<void> loadStories() async {
    emit(TopStoriesLoading());

    try {
      final stories = <ItemModel>[];

      /// Get top stories from hacker news and filter out all that the user has already seen
      final ids = (await newsRepo.getTopstoriesIds(500))
        .where((e) => !historyRepo.allIds.contains(e))
        .toList();
      
      for (var i = 0; i < ids.length; i += _loadAmount) {
        final currentIds = ids
          .skip(i)
          .take(_loadAmount)
          .toList();

        final futures = currentIds
          .map(newsRepo.getItem)
          .toList();

        final currentStories = await Future.wait(futures);
        stories.addAll(currentStories);

        emit(TopStoriesLoaded(stories));
      }
    } catch (e, stackTrace) {
      log('Error fetching topstories', error: e, stackTrace: stackTrace);
      emit(TopStoriesError());
    }
  }

  Future<void> loadMore() async {

  }

  void addToHistory(int storyId) => historyRepo.add(storyId);
}
