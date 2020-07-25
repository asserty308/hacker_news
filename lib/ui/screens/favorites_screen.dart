import 'package:flutter/material.dart';
import 'package:flutter_core/ui/widgets/center_progress_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/app/app_cubit.dart';
import 'package:hacker_news/bloc/favorites_screen/favorites_screen_cubit.dart';
import 'package:hacker_news/ui/widgets/stories_listview.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Favories'),
      actions: [
        IconButton(icon: Icon(Icons.list), onPressed: () => BlocProvider.of<AppCubit>(context).showTopStories())
      ],
    ),
    body: _body,
  );

  Widget get _body => BlocBuilder<FavoritesCubit, FavoritesState>(
    builder: (context, state) {
      if (state is FavoritesLoaded) {
        return StoriesListView(stories: state.stories);
      }

      return CenterProgressIndicator();
    },
  );
}