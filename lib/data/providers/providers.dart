import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/config/app_config.dart';
import 'package:hacker_news/data/datasources/favorites_api.dart';
import 'package:hacker_news/data/datasources/favorites_cache.dart';
import 'package:hacker_news/data/repositories/favorites_repo.dart';
import 'package:hacker_news/data/repositories/hackernews_repo.dart';
import 'package:hacker_news/data/repositories/story_history_repo.dart';
import 'package:hacker_news/domain/use_cases/clear_history_use_case.dart';
import 'package:hacker_news/ui/blocs/favorites/favorites_cubit.dart';
import 'package:hacker_news/ui/blocs/top_stories/top_stories_cubit.dart';

// Datasources

final _favoritesCacheProvider = Provider((ref) => FavoritesCache());
final _favoritesApiProvider = Provider((ref) => FavoritesApi(
  databases: ref.watch(appwriteDatabasesProvider),
));

// Repositories

final hackerNewsRepoProvider = Provider((ref) => HackernewsRepo());
final storyHistoryRepoProvider = Provider((ref) => StoryHistoryRepo());
final favoritesRepoProvider = Provider((ref) => FavoritesRepository(
  cache: ref.watch(_favoritesCacheProvider),
  api: ref.watch(_favoritesApiProvider),
));

// Use cases

final clearHistoryUseCaseProvider = Provider((ref) => ClearHistoryUseCase(
  storyHistoryRepo: ref.watch(storyHistoryRepoProvider),
  topStoriesCubit: ref.watch(topStoriesCubitProvider),
));

// Blocs

final topStoriesCubitProvider = Provider((ref) => TopStoriesCubit(
  newsRepo: ref.watch(hackerNewsRepoProvider), 
  historyRepo: ref.watch(storyHistoryRepoProvider),
));

final favoritesCubitProvider = Provider((ref) => FavoritesCubit(
  repo: ref.watch(favoritesRepoProvider),
));

// Appwrite

final appwriteClientProvider = Provider((ref) {
  final client = Client();
  client.setProject(kAppwriteProjectID);
  return client;
});

final appwriteAccountProvider = Provider((ref) => Account(ref.watch(appwriteClientProvider)));

final appwriteDatabasesProvider = Provider((ref) => Databases(ref.watch(appwriteClientProvider)));
