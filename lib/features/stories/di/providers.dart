import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/features/stories/data/datasources/hackernews_api.dart';
import 'package:hacker_news/features/stories/data/repositories/hackernews_repo.dart';
import 'package:hacker_news/features/stories/domain/use_cases/get_top_storiy_ids_use_case.dart';
import 'package:hacker_news/features/stories/domain/use_cases/load_story_use_case.dart';
import 'package:hacker_news/features/stories/domain/use_cases/show_story_use_case.dart';
import 'package:hacker_news/features/stories/ui/blocs/top_stories/top_stories_cubit.dart';

// MARK: Datasources

final _hackernewsApiProvider = Provider((ref) => HackernewsApi());

// MARK: Repositories

final hackerNewsRepoProvider = Provider(
  (ref) => HackernewsRepo(api: ref.watch(_hackernewsApiProvider)),
);

// MARK: Use cases

final loadTopStoriesUseCaseProvider = Provider(
  (ref) => LoadStoryUseCase(newsRepo: ref.watch(hackerNewsRepoProvider)),
);

final getTopStoryIdsUseCaseProvider = Provider(
  (ref) => GetTopStoriyIdsUseCase(newsRepo: ref.watch(hackerNewsRepoProvider)),
);

final showStoryUseCaseProvider = Provider((ref) => ShowStoryUseCase());

// MARK: Blocs

final topStoriesCubitProvider = Provider.autoDispose(
  (ref) => TopStoriesCubit(
    getTopStoriyIdsUseCase: ref.watch(getTopStoryIdsUseCaseProvider),
    loadStoryUseCase: ref.watch(loadTopStoriesUseCaseProvider),
  ),
);
