import 'package:cubit/cubit.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/data/repositories/favorites_repository.dart';
import 'package:meta/meta.dart';

part 'favorites_screen_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this.repository) : super(FavoritesInitial()) {
    loadStories();
  }

  final FavoritesRepository repository;

  void loadStories() async {
    emit(FavoritesLoading());

    try {
      final stories = await repository.getAll();
      emit(FavoritesLoaded(stories));
    } catch (e) {
      emit(FavoritesError());
    }
  }
}
