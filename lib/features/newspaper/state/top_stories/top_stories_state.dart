part of 'top_stories_cubit.dart';

@immutable
abstract class TopStoriesState {}

class TopStoriesInitial extends TopStoriesState {}
class TopStoriesLoading extends TopStoriesState {}

class TopStoriesLoaded extends TopStoriesState {
  final List<ItemModel> stories;

  TopStoriesLoaded(this.stories);
}

class TopStoriesError extends TopStoriesState {}
