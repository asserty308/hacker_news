import 'package:bloc/bloc.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/data/repositories/favorites_repository.dart';
import 'package:meta/meta.dart';

part 'favorites_button_state.dart';

class FavoritesButtonCubit extends Cubit<FavoritesButtonState> {
  FavoritesButtonCubit(this.repository, this.story) : super(FavoritesButtonInitial()) {
    init();
  }

  final FavoritesRepository repository;
  final ItemModel story;

  void init() {
    emit(FavoritesButtonLoading());

    try {
      final isFav = repository.contains(story.id);
      
      if (isFav) {
        emit(FavoritesButtonAdded());
      } else {
        emit(FavoritesButtonRemoved());
      }
    } catch (e) {
      print('FavoritesButtonCubit::init ERROR $e');
      emit(FavoritesButtonError());
    }
  }

  void add() {
    try {
      repository.addStory(story);
      emit(FavoritesButtonAdded());
    } catch (e) {
      emit(FavoritesButtonError());
    }
  }

  void remove() {
    try {
      repository.removeStory(story.id);
      emit(FavoritesButtonRemoved());
    } catch (e) {
      emit(FavoritesButtonError());
    }
  }
}
