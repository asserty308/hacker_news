import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/app/app_cubit.dart';
import 'package:hacker_news/ui/screens/favorites_screen.dart';
import 'package:hacker_news/ui/screens/top_stories_screen.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => _body;

  Widget get _body => BlocBuilder<AppCubit, AppState>(
    builder: (context, state) {
      if (state is AppTopStories) {
        return const TopStoriesScreen();
      }

      if (state is AppFavorites) {
        return const FavoritesScreen();
      }

      return Container();
    },
  );
}