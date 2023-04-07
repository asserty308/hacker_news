import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/data/repositories/hackernews_repository.dart';
import 'package:meta/meta.dart';

part 'top_page_state.dart';

class TopstoriesCubit extends Cubit<TopStoriesState> {
  TopstoriesCubit(this.repository) : super(TopStoriesInitial());

  final HackernewsRepository repository;

  Future<void> loadStories() async {
    emit(TopStoriesLoading());

    try {
      final stories = await repository.getTopstories(30);
      emit(TopStoriesLoaded(stories));
    } catch (e, stackTrace) {
      log('Error fetching topstories', error: e, stackTrace: stackTrace);
      emit(TopStoriesError());
    }
  }
  
}
