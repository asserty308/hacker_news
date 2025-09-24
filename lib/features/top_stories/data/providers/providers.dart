import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/features/favorites/data/datasources/favorites_cache.dart';
import 'package:hacker_news/features/favorites/data/repositories/favorites_repo.dart';
import 'package:hacker_news/features/favorites/ui/blocs/favorites/favorites_cubit.dart';
import 'package:hacker_news/features/top_stories/data/datasources/hackernews_api.dart';
import 'package:hacker_news/features/top_stories/data/repositories/hackernews_repo.dart';
import 'package:hacker_news/features/top_stories/data/repositories/story_history_repo.dart';
import 'package:hacker_news/features/top_stories/domain/use_cases/add_story_to_history_use_case.dart';
import 'package:hacker_news/features/top_stories/domain/use_cases/clear_history_use_case.dart';
import 'package:hacker_news/features/top_stories/domain/use_cases/load_top_stories_use_case.dart';
import 'package:hacker_news/features/top_stories/ui/blocs/top_stories/top_stories_cubit.dart';

// Datasources

final _favoritesCacheProvider = Provider((ref) => FavoritesCache());

final _hackernewsApiProvider = Provider((ref) => HackernewsApi());

// Repositories

final hackerNewsRepoProvider = Provider(
  (ref) => HackernewsRepo(api: ref.watch(_hackernewsApiProvider)),
);

final storyHistoryRepoProvider = Provider((ref) => StoryHistoryRepo());
final favoritesRepoProvider = Provider(
  (ref) => FavoritesRepository(cache: ref.watch(_favoritesCacheProvider)),
);

// Use cases

final loadTopStoriesUseCaseProvider = Provider(
  (ref) => LoadTopStoriesUseCase(
    newsRepo: ref.watch(hackerNewsRepoProvider),
    historyRepo: ref.watch(storyHistoryRepoProvider),
  ),
);

final addStoryToHistoryUseCaseProvider = Provider(
  (ref) => AddStoryToHistoryUseCase(
    historyRepo: ref.watch(storyHistoryRepoProvider),
  ),
);

final clearHistoryUseCaseProvider = Provider(
  (ref) => ClearHistoryUseCase(
    storyHistoryRepo: ref.watch(storyHistoryRepoProvider),
    topStoriesCubit: ref.watch(topStoriesCubitProvider),
  ),
);

// Blocs

final topStoriesCubitProvider = Provider(
  (ref) => TopStoriesCubit(
    loadTopStoriesUseCase: ref.watch(loadTopStoriesUseCaseProvider),
    addStoryToHistoryUseCase: ref.watch(addStoryToHistoryUseCaseProvider),
  ),
);

final favoritesCubitProvider = Provider(
  (ref) => FavoritesCubit(repo: ref.watch(favoritesRepoProvider)),
);
