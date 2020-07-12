import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:hacker_news/data/repositories/favorites_repository.dart';
import 'package:hacker_news/data/repositories/hackernews_repository.dart';
import 'package:hacker_news/state/app/app_cubit.dart';
import 'package:hacker_news/state/favorites/favorites_cubit.dart';
import 'package:hacker_news/state/top_stories/top_stories_cubit.dart';
import 'package:hacker_news/ui/screens/top_stories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hacker Today',
      theme: ThemeData.dark(),
      home: MultiCubitProvider(
        providers: [
          CubitProvider(
            create: (context) => AppCubit(),
          ),
          CubitProvider(
            create: (context) => FavoritesCubit(globalFavoritesRepository),
          ),
          CubitProvider(
            create: (context) => TopStoriesCubit(globalHackernewsRepo),
          ),
        ],
        child: TopStoriesScreen(),
      ),
    );
  }
}
