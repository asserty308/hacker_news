import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/favorites/favorites_cubit.dart';
import 'package:hacker_news/bloc/top_stories/top_stories_cubit.dart';
import 'package:hacker_news/data/repositories/favorites_repo.dart';
import 'package:hacker_news/data/repositories/hackernews_repo.dart';
import 'package:hacker_news/data/repositories/story_history_repo.dart';
import 'package:hacker_news/l10n/l10n.dart';
import 'package:hacker_news/router/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hacker_news/styles/theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();

    // Initialize the AppLifecycleListener class and pass callbacks
    _listener = AppLifecycleListener(
      onResume: _onResume,
    );
  }

  @override
  void dispose() {
    _listener.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (context) => HackernewsRepo()),
      RepositoryProvider(create: (context) => StoryHistoryRepo()),
      RepositoryProvider(create: (context) => FavoritesRepository()),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TopStoriesCubit(
            newsRepo: RepositoryProvider.of<HackernewsRepo>(context), 
            historyRepo: RepositoryProvider.of<StoryHistoryRepo>(context)
          ),
        ),
        BlocProvider(
          create: (context) => FavoritesCubit(
            RepositoryProvider.of<FavoritesRepository>(context),
          ),
        )
      ],
      child: MaterialApp.router(
        restorationScopeId: 'app',
        onGenerateTitle: (context) => context.l10n.appTitle,
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    ),
  );

  void _onResume() => BlocProvider.of<TopStoriesCubit>(context).refresh();
}
