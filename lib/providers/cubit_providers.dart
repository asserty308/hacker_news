import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:hacker_news/bloc/app/app_cubit.dart';
import 'package:hacker_news/bloc/favorites_screen/favorites_screen_cubit.dart';
import 'package:hacker_news/bloc/top_stories_screen/top_stories_cubit.dart';
import 'package:hacker_news/data/repositories/favorites_repository.dart';
import 'package:hacker_news/data/repositories/hackernews_repository.dart';

class AppCubitProvider extends StatelessWidget {
  final Widget child;

  const AppCubitProvider({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiCubitProvider(
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
      child: child,
    );
  }
}