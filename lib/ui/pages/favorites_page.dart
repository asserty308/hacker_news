import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/favorites/favorites_cubit.dart';
import 'package:hacker_news/data/repositories/favorites_repo.dart';
import 'package:hacker_news/ui/widgets/action_buttons.dart';
import 'package:hacker_news/ui/widgets/stories_listview.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({super.key});

  final _bloc = FavoritesCubit(favoritesRepository);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Favorites'),
      actions: const [
        HomeAction(),
        SettingsAction(),
      ],
    ),
    body: _body,
  );

  Widget get _body => BlocBuilder(
    bloc: _bloc,
    builder: (context, state) {
      if (state is FavoritesLoaded) {
        return StoriesListView(stories: state.stories, storageKey: 1,);
      }

      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}