import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/features/favorites/data/datasources/favorites_cache.dart';
import 'package:hacker_news/features/favorites/data/repositories/favorites_repo.dart';
import 'package:hacker_news/features/favorites/domain/use_case/get_favorites_use_case.dart';
import 'package:hacker_news/features/favorites/ui/blocs/favorites/favorites_cubit.dart';

final _favoritesCacheProvider = Provider((ref) => FavoritesCache());

final favoritesRepoProvider = Provider(
  (ref) => FavoritesRepository(cache: ref.watch(_favoritesCacheProvider)),
);

final getFavoritesUseCaseProvider = Provider(
  (ref) => GetFavoritesUseCase(
    favoritesRepository: ref.watch(favoritesRepoProvider),
  ),
);

final favoritesCubitProvider = Provider(
  (ref) => FavoritesCubit(
    getFavoritesUseCase: ref.watch(getFavoritesUseCaseProvider),
  ),
);
