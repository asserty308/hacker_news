import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/app/app_cubit.dart';
import 'package:hacker_news/bloc/favorites_screen/favorites_screen_cubit.dart';
import 'package:hacker_news/bloc/top_stories_screen/top_stories_cubit.dart';
import 'package:hacker_news/data/repositories/favorites_repository.dart';
import 'package:hacker_news/data/repositories/hackernews_repository.dart';

class AppBlocProvider extends StatelessWidget {

  const AppBlocProvider({
    super.key, 
    required this.child,
  });
  
  final Widget child;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AppCubit(),
      ),
      BlocProvider(
        create: (context) => FavoritesCubit(globalFavoritesRepository),
      ),
      BlocProvider(
        create: (context) => TopStoriesCubit(globalHackernewsRepo),
      ),
    ],
    child: child,
  );
}