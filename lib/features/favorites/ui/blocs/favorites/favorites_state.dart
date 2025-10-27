part of 'favorites_cubit.dart';

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

class FavoritesExportSuccess extends FavoritesState {
  FavoritesExportSuccess(this.jsonContent);
  final String jsonContent;
}

class FavoritesImportSuccess extends FavoritesState {
  FavoritesImportSuccess(this.count);
  final int count;
}

class FavoritesOperationError extends FavoritesState {
  FavoritesOperationError(this.message);
  final String message;
}
