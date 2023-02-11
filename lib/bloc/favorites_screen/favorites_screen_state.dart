part of 'favorites_screen_cubit.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}
class FavoritesLoading extends FavoritesState {}

class FavoritesAdd extends FavoritesState {

  FavoritesAdd(this.story);
  final ItemModel story;
}

class FavoritesLoaded extends FavoritesState {

  FavoritesLoaded(this.stories);
  final List<ItemModel> stories;
}

class FavoritesError extends FavoritesState {}