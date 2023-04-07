part of 'like_button_cubit.dart';

@immutable
abstract class LikeButtonState {}

class LikeButtonInitial extends LikeButtonState {}

class LikeButtonLoading extends LikeButtonState {}
class LikeButtonAdded extends LikeButtonState {}
class LikeButtonRemoved extends LikeButtonState {}
class LikeButtonError extends LikeButtonState {}
