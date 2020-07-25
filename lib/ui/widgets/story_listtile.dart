import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/favorites_button/favorites_button_cubit.dart';
import 'package:hacker_news/bloc/favorites_screen/favorites_screen_cubit.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/bloc/app/app_cubit.dart';
import 'package:hacker_news/data/repositories/favorites_repository.dart';

class StoryListTile extends StatelessWidget {
  const StoryListTile({
    Key key,
    @required this.story,
  }) : super(key: key);

  final ItemModel story;

  @override
  Widget build(BuildContext context) => _cubitProvider;

  Widget get _cubitProvider => BlocProvider(
    create: (context) => FavoritesButtonCubit(globalFavoritesRepository, story),
    child: _tile,
  );

  Widget get _tile => Builder(
    builder: (context) => ListTile(
      title: _title,
      trailing: _favButton,
      onTap: () => _showStory(context),
    ),
  );

  Widget get _title => Text(
    story.title ?? 'Unknown title', 
    style: TextStyle(color: Colors.white),
  );

  Widget get _favButton => BlocConsumer<FavoritesButtonCubit, FavoritesButtonState>(
    builder: (context, state) {
      if (state is FavoritesButtonAdded) {
        return IconButton(
          icon: Icon(Icons.favorite), 
          onPressed: () => _removeFromFavorites(context),
        );
      }

      if (state is FavoritesButtonRemoved) {
        return IconButton(
          icon: Icon(Icons.favorite_border), 
          onPressed: () => _addToFavorites(context),
        );
      }

      return Container(width: 0, height: 0,);
    },
    listener: (context, state) {
      // on each update, refresh the favorites list
      BlocProvider.of<FavoritesCubit>(context).loadStories();
    },
  );

  // UI Events

  void _addToFavorites(BuildContext context) {
    BlocProvider.of<FavoritesButtonCubit>(context).add();
  }

  void _removeFromFavorites(BuildContext context) {
    BlocProvider.of<FavoritesButtonCubit>(context).remove();
  }

  void _showStory(BuildContext context) {
    BlocProvider.of<AppCubit>(context).callUrl(story.url);
  }
}