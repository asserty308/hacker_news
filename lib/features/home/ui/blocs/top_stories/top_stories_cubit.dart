import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:hacker_news/features/home/data/models/item_model.dart';
import 'package:hacker_news/features/home/domain/use_cases/get_top_storiy_ids_use_case.dart';
import 'package:hacker_news/features/home/domain/use_cases/load_story_use_case.dart';

part 'top_stories_state.dart';

class TopStoriesCubit extends Cubit<TopStoriesState> {
  TopStoriesCubit({
    required this.getTopStoriyIdsUseCase,
    required this.loadStoryUseCase,
  }) : super(TopStoriesInitial());

  final GetTopStoriyIdsUseCase getTopStoriyIdsUseCase;
  final LoadStoryUseCase loadStoryUseCase;

  List<int> _topIds = <int>[];

  final _stories = <ItemModel>[];
  final _loadAmount = 5;

  var _currentIndex = 0;

  /// Load the next batch of stories and add them to _stories.
  Future<void> loadNextStories() async {
    if (_stories.isEmpty) {
      emit(TopStoriesLoading());
    }

    if (_topIds.isEmpty) {
      try {
        _topIds = await getTopStoriyIdsUseCase.execute();
      } catch (e, stackTrace) {
        logger.e('Error fetching topstories', error: e, stackTrace: stackTrace);
        emit(TopStoriesError());
        return;
      }
    }

    try {
      final futures = _topIds
          .skip(_currentIndex)
          .take(_loadAmount)
          .map(loadStoryUseCase.execute)
          .toList();

      final stories = await Future.wait(futures);

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
    loadNextStories();
  }

  int get storyCount => _stories.length;
}
