part of 'favorites_screen_cubit.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}
class FavoritesLoading extends FavoritesState {}

class FavoritesAdd extends FavoritesState {
  final ItemModel story;

  FavoritesAdd(this.story);
}

class FavoritesLoaded extends FavoritesState {
  final List<ItemModel> stories;

  FavoritesLoaded(this.stories);
}

class FavoritesError extends FavoritesState {}