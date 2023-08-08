import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/data/repositories/hackernews_repo.dart';
import 'package:meta/meta.dart';

part 'top_stories_state.dart';

class TopStoriesCubit extends Cubit<TopStoriesState> {
  TopStoriesCubit(this.repo) : super(TopStoriesInitial());

  final HackernewsRepo repo;

  final _loadAmount = 30;

  Future<void> loadStories() async {
    emit(TopStoriesLoading());

    try {
      final stories = <ItemModel>[];
      final ids = await repo.getTopstoriesIds(500);
      
      for (var i = 0; i < ids.length; i += _loadAmount) {
        final currentIds = ids
          .skip(i)
          .take(_loadAmount)
          .toList();

        final futures = currentIds
          .map(repo.getItem)
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
}
