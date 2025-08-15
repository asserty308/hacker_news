import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/data/repositories/hackernews_repo.dart';
import 'package:hacker_news/data/repositories/story_history_repo.dart';

part 'top_stories_state.dart';

class TopStoriesCubit extends Cubit<TopStoriesState> {
  TopStoriesCubit({required this.newsRepo, required this.historyRepo})
    : super(TopStoriesInitial());

  final HackernewsRepo newsRepo;
  final StoryHistoryRepo historyRepo;

  final _stories = <ItemModel>[];
  final _loadAmount = 5;

  var _currentIndex = 0;

  /// Loads top stories from hacker news and filter out all that the user has already seen
  Future<void> loadStories() async {
    if (_stories.isEmpty) {
      emit(TopStoriesLoading());
    }

    try {
      await historyRepo.cleanup();

      final ids = await newsRepo.getTopstoriesIds(
        _loadAmount,
        start: _currentIndex,
      );

      final unreadIds =
          ids.where((e) => !historyRepo.allIds.contains(e)).toList();

      if (unreadIds.isEmpty) {
        _currentIndex +=
            _loadAmount; // move index forward since these IDs have been processed
        log('Jump to $_currentIndex as all stories before have been read');
        return loadStories();
      }

      // Only move the index if we have stories to load.
      _currentIndex += _loadAmount;

      final futures = unreadIds.map(newsRepo.getItem);
      final stories = await Future.wait(futures);
      _stories.addAll(stories);

      emit(TopStoriesLoaded(_stories));
    } catch (e, stackTrace) {
      log('Error fetching topstories', error: e, stackTrace: stackTrace);
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

  void addToHistory(int storyId) => historyRepo.add(storyId);

  int get storyCount => _stories.length;
}
