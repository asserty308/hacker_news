part of 'favorites_button_cubit.dart';

@immutable
abstract class FavoritesButtonState {}

class FavoritesButtonInitial extends FavoritesButtonState {}

class FavoritesButtonLoading extends FavoritesButtonState {}
class FavoritesButtonAdded extends FavoritesButtonState {}
class FavoritesButtonRemoved extends FavoritesButtonState {}
class FavoritesButtonError extends FavoritesButtonState {}
