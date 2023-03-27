import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/data/repositories/favorites_repository.dart';
import 'package:meta/meta.dart';

part 'favorites_page_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this.repository) : super(FavoritesInitial()) {
    loadStories();
  }

  final FavoritesRepository repository;

  void loadStories() {
    emit(FavoritesLoading());

    try {
      final stories = repository.getAll();
      emit(FavoritesLoaded(stories));
    } catch (e) {
      log('FavoritesCubit::loadStories ERROR $e');
      emit(FavoritesError());
    }
  }
}
