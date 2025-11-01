import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:hacker_news/features/favorites/data/repositories/favorites_repo.dart';
import 'package:hacker_news/features/home/data/models/item_model.dart';

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
        emit(LikeButtonIsFavorite());
      } else {
        emit(LikeButtonIsNotFavorite());
      }
    } catch (e) {
      logger.e('Error initializing LikeButtonCubit', error: e);
      emit(LikeButtonError());
    }
  }

  Future<void> add() async {
    try {
      await repository.addStory(story);
      emit(LikeButtonAdded());
    } catch (e) {
      emit(LikeButtonError());
    }
  }

  Future<void> remove() async {
    try {
      await repository.removeStory(story.id);
      emit(LikeButtonRemoved());
    } catch (e) {
      emit(LikeButtonError());
    }
  }
}
