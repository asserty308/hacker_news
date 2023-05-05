import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/data/repositories/hackernews_repo.dart';
import 'package:meta/meta.dart';

part 'top_stories_state.dart';

class TopStoriesCubit extends Cubit<TopStoriesState> {
  TopStoriesCubit(this.repo) : super(TopStoriesInitial());

  final HackernewsRepo repo;

  Future<void> loadStories() async {
    emit(TopStoriesLoading());

    try {
      final stories = await repo.getTopstories(30);
      emit(TopStoriesLoaded(stories));
    } catch (e, stackTrace) {
      log('Error fetching topstories', error: e, stackTrace: stackTrace);
      emit(TopStoriesError());
    }
  }
}
