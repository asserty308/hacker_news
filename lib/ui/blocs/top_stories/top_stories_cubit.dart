import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/domain/use_cases/add_story_to_history_use_case.dart';
import 'package:hacker_news/domain/use_cases/load_top_stories_use_case.dart';

part 'top_stories_state.dart';

class TopStoriesCubit extends Cubit<TopStoriesState> {
  TopStoriesCubit({
    required this.loadTopStoriesUseCase,
    required this.addStoryToHistoryUseCase,
  }) : super(TopStoriesInitial());

  final LoadTopStoriesUseCase loadTopStoriesUseCase;
  final AddStoryToHistoryUseCase addStoryToHistoryUseCase;

  final _stories = <ItemModel>[];
  final _loadAmount = 5;

  var _currentIndex = 0;

  /// Loads top stories from hacker news and filter out all that the user has already seen
  Future<void> loadStories() async {
    if (_stories.isEmpty) {
      emit(TopStoriesLoading());
    }

    try {
      final stories = await loadTopStoriesUseCase.execute(
        loadAmount: _loadAmount,
        currentIndex: _currentIndex,
      );

      if (stories.isEmpty) {
        _currentIndex +=
            _loadAmount; // move index forward since these IDs have been processed
        logger.i('Jump to $_currentIndex as all stories before have been read');
        return loadStories();
      }

      // Only move the index if we have stories to load.
      _currentIndex += _loadAmount;
      _stories.addAll(stories);

      emit(TopStoriesLoaded(_stories));
    } catch (e, stackTrace) {
      logger.e('Error fetching topstories', error: e, stackTrace: stackTrace);
      emit(TopStoriesError());
    }
  }

  /// Loads new stories and appends them to the [_stories] list.
  /// When [clearStories] is true, the list is cleared before reload.
  Future<void> refresh([bool clearStories = false]) async {
    if (clearStories) {
      _stories.clear();
    }

    _currentIndex = 0;
    loadStories();
  }

  void addToHistory(int storyId) => addStoryToHistoryUseCase.execute(storyId);

  int get storyCount => _stories.length;
}
