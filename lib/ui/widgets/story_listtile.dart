import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/favorites_button/favorites_button_cubit.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/data/repositories/favorites_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class StoryListTile extends StatelessWidget {
  const StoryListTile({
    super.key,
    required this.story,
  });

  final ItemModel story;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => FavoritesButtonCubit(favoritesRepository, story),
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
    story.title, 
    style: const TextStyle(color: Colors.white),
  );

  Widget get _favButton => BlocBuilder<FavoritesButtonCubit, FavoritesButtonState>(
    builder: (context, state) {
      if (state is FavoritesButtonAdded) {
        return IconButton(
          icon: const Icon(Icons.favorite), 
          onPressed: () => _removeFromFavorites(context),
        );
      }

      if (state is FavoritesButtonRemoved) {
        return IconButton(
          icon: const Icon(Icons.favorite_border), 
          onPressed: () => _addToFavorites(context),
        );
      }

      return const SizedBox(width: 0, height: 0,);
    },
  );

  void _addToFavorites(BuildContext context) {
    BlocProvider.of<FavoritesButtonCubit>(context).add();
  }

  void _removeFromFavorites(BuildContext context) {
    BlocProvider.of<FavoritesButtonCubit>(context).remove();
  }

  void _showStory(BuildContext context) {
    if (story.url == null) {
      log('Story has no url: ${story.id}');
      return;
    }

    launchUrl(Uri.parse(story.url!));
  }
}