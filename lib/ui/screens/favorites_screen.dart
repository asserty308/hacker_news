import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/app/app_cubit.dart';
import 'package:hacker_news/bloc/favorites_screen/favorites_screen_cubit.dart';
import 'package:hacker_news/ui/widgets/stories_listview.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Favories'),
      actions: [
        IconButton(icon: const Icon(Icons.list), onPressed: () => BlocProvider.of<AppCubit>(context).showTopStories())
      ],
    ),
    body: _body,
  );

  Widget get _body => BlocBuilder<FavoritesCubit, FavoritesState>(
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