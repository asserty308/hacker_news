import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/favorites/favorites_cubit.dart';
import 'package:hacker_news/data/repositories/favorites_repo.dart';
import 'package:hacker_news/router/router.dart';
import 'package:hacker_news/ui/widgets/stories_listview.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({super.key});

  final _bloc = FavoritesCubit(favoritesRepository);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Favorites'),
      actions: [
        IconButton(icon: const Icon(Icons.list), onPressed: () => appRouter.go('/')),
        IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () => appRouter.go('/settings')),
      ],
    ),
    body: _body,
  );

  Widget get _body => BlocBuilder(
    bloc: _bloc,
    builder: (context, state) {
      if (state is FavoritesLoaded) {
        return StoriesListView(stories: state.stories);
      }

      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}