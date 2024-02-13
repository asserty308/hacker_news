import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/favorites/favorites_cubit.dart';
import 'package:hacker_news/bloc/top_stories/top_stories_cubit.dart';
import 'package:hacker_news/data/repositories/favorites_repo.dart';
import 'package:hacker_news/data/repositories/hackernews_repo.dart';
import 'package:hacker_news/data/repositories/story_history_repo.dart';
import 'package:hacker_news/data/services/app_session.dart';
import 'package:hacker_news/ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupSession();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => HackernewsRepo()),
        RepositoryProvider(create: (context) => StoryHistoryRepo()),
        RepositoryProvider(create: (context) => FavoritesRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TopStoriesCubit(
              newsRepo: context.read<HackernewsRepo>(), 
              historyRepo: context.read<StoryHistoryRepo>(),
            ),
          ),
          BlocProvider(
            create: (context) => FavoritesCubit(
              repo: context.read<FavoritesRepository>(),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}
