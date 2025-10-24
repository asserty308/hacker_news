import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:hacker_news/features/favorites/domain/use_case/get_favorites_use_case.dart';
import 'package:hacker_news/features/stories/data/models/item_model.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({required this.getFavoritesUseCase})
    : super(FavoritesInitial()) {
    loadStories();
  }

  final GetFavoritesUseCase getFavoritesUseCase;

  void loadStories() {
    emit(FavoritesLoading());

    try {
      final stories = getFavoritesUseCase.execute();
      emit(FavoritesLoaded(stories));
    } catch (e) {
      logger.e('FavoritesCubit::loadStories ERROR $e');
      emit(FavoritesError());
    }
  }
}
