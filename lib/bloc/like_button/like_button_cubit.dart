import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/data/repositories/favorites_repository.dart';
import 'package:meta/meta.dart';

part 'like_button_state.dart';

class LikeButtonCubit extends Cubit<LikeButtonState> {
  LikeButtonCubit(this.repository, this.story) : super(LikeButtonInitial()) {
    init();
  }

  final FavoritesRepository repository;
  final ItemModel story;

  void init() {
    emit(LikeButtonLoading());

    try {
      final isFav = repository.contains(story.id);
      
      if (isFav) {
        emit(LikeButtonAdded());
      } else {
        emit(LikeButtonRemoved());
      }
    } catch (e) {
      log('FavoritesButtonCubit::init ERROR $e');
      emit(LikeButtonError());
    }
  }

  void add() {
    try {
      repository.addStory(story);
      emit(LikeButtonAdded());
    } catch (e) {
      emit(LikeButtonError());
    }
  }

  void remove() {
    try {
      repository.removeStory(story.id);
      emit(LikeButtonRemoved());
    } catch (e) {
      emit(LikeButtonError());
    }
  }
}
