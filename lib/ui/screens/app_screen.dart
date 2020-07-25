import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/app/app_cubit.dart';
import 'package:hacker_news/ui/screens/favorites_screen.dart';
import 'package:hacker_news/ui/screens/top_stories_screen.dart';

class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _body;

  Widget get _body => BlocBuilder<AppCubit, AppState>(
    builder: (context, state) {
      if (state is AppTopStories) {
        return TopStoriesScreen();
      }

      if (state is AppFavorites) {
        return FavoritesScreen();
      }

      return Container();
    },
  );
}