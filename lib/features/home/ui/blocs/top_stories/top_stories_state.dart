part of 'top_stories_cubit.dart';

@immutable
abstract class TopStoriesState {}

class TopStoriesInitial extends TopStoriesState {}

class TopStoriesLoading extends TopStoriesState {}

class TopStoriesLoaded extends TopStoriesState {
  TopStoriesLoaded(this.stories);
  final List<ItemModel> stories;
}

class TopStoriesError extends TopStoriesState {}
