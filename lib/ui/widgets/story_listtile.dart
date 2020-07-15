import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:hacker_news/bloc/favorites_button/favorites_button_cubit.dart';
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

  Widget get _cubitProvider => CubitProvider(
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

  Widget get _favButton => CubitBuilder<FavoritesButtonCubit, FavoritesButtonState>(
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
  );

  // UI Events

  void _addToFavorites(BuildContext context) {
    CubitProvider.of<FavoritesButtonCubit>(context).add();
  }

  void _removeFromFavorites(BuildContext context) {
    CubitProvider.of<FavoritesButtonCubit>(context).remove();
  }

  void _showStory(BuildContext context) {
    CubitProvider.of<AppCubit>(context).callUrl(story.url);
  }
}