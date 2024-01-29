import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/data/repositories/favorites_repo.dart';
import 'package:meta/meta.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({required this.repo}) : super(FavoritesInitial()) {
    loadStories();
  }

  final FavoritesRepository repo;

  void loadStories() {
    emit(FavoritesLoading());

    try {
      final stories = repo.getAll();
      emit(FavoritesLoaded(stories));
    } catch (e) {
      log('FavoritesCubit::loadStories ERROR $e');
      emit(FavoritesError());
    }
  }
}
