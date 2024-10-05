import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/data/repositories/favorites_repo.dart';
import 'package:hacker_news/data/repositories/hackernews_repo.dart';
import 'package:hacker_news/data/repositories/story_history_repo.dart';
import 'package:hacker_news/ui/blocs/favorites/favorites_cubit.dart';
import 'package:hacker_news/ui/blocs/top_stories/top_stories_cubit.dart';

final hackerNewsRepoProvider = Provider((ref) => HackernewsRepo());
final storyHistoryRepoProvider = Provider((ref) => StoryHistoryRepo());
final favoritesRepoProvider = Provider((ref) => FavoritesRepository());

final topStoriesCubitProvider = Provider((ref) => TopStoriesCubit(
  newsRepo: ref.watch(hackerNewsRepoProvider), 
  historyRepo: ref.watch(storyHistoryRepoProvider),
));

final favoritesCubitProvider = Provider((ref) => FavoritesCubit(
  repo: ref.watch(favoritesRepoProvider),
));
