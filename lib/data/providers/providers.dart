import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/data/datasources/favorites_cache.dart';
import 'package:hacker_news/data/repositories/favorites_repo.dart';
import 'package:hacker_news/data/repositories/hackernews_repo.dart';
import 'package:hacker_news/data/repositories/story_history_repo.dart';
import 'package:hacker_news/domain/use_cases/clear_history_use_case.dart';
import 'package:hacker_news/ui/blocs/favorites/favorites_cubit.dart';
import 'package:hacker_news/ui/blocs/top_stories/top_stories_cubit.dart';

// Datasources

final _favoritesCacheProvider = Provider((ref) => FavoritesCache());

// Repositories

final hackerNewsRepoProvider = Provider((ref) => HackernewsRepo());
final storyHistoryRepoProvider = Provider((ref) => StoryHistoryRepo());
final favoritesRepoProvider = Provider(
  (ref) => FavoritesRepository(cache: ref.watch(_favoritesCacheProvider)),
);

// Use cases

final clearHistoryUseCaseProvider = Provider(
  (ref) => ClearHistoryUseCase(
    storyHistoryRepo: ref.watch(storyHistoryRepoProvider),
    topStoriesCubit: ref.watch(topStoriesCubitProvider),
  ),
);

// Blocs

final topStoriesCubitProvider = Provider(
  (ref) => TopStoriesCubit(
    newsRepo: ref.watch(hackerNewsRepoProvider),
    historyRepo: ref.watch(storyHistoryRepoProvider),
  ),
);

final favoritesCubitProvider = Provider(
  (ref) => FavoritesCubit(repo: ref.watch(favoritesRepoProvider)),
);
