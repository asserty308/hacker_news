part of 'favorites_cubit.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}
class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  FavoritesLoaded(this.stories);
  final List<ItemModel> stories;
}

class FavoritesError extends FavoritesState {}