import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/like_button/like_button_cubit.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/data/repositories/favorites_repo.dart';
import 'package:hacker_news/l10n/l10n.dart';
import 'package:hacker_news/ui/widgets/add_favorite_button.dart';
import 'package:hacker_news/ui/widgets/remove_favorite_button.dart';
import 'package:url_launcher/url_launcher.dart';

class StoryListTile extends StatelessWidget {
  const StoryListTile({
    super.key,
    required this.story,
    this.onFavoriteRemoved,
  });

  final ItemModel story;
  final VoidCallback? onFavoriteRemoved;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => LikeButtonCubit(favoritesRepository, story),
    child: _tile(context),
  );

  Widget _tile(BuildContext context) => ListTile(
    title: _title,
    subtitle: _subtitle(context),
    trailing: _favButton,
    onTap: () => _showStory(context),
  );

  Widget get _title => Text(
    story.title,
  );

  Widget _subtitle(context) {
    final diff = story.formattedDifference(context);
    final authority = Uri.tryParse(story.url ?? '')?.authority ?? '';
    return Text('$diff ${authority.isEmpty ? '' : ' - $authority'}');
  }

  Widget get _favButton => BlocBuilder<LikeButtonCubit, LikeButtonState>(
    builder: (context, state) {
      if (state is LikeButtonIsFavorite) {
        return AddFavoriteButton(
          onTap: () => _removeFromFavorites(context), 
          playAnimation: false,
        );
      }

      if (state is LikeButtonIsNotFavorite) {
        return RemoveFavoriteButton(
          onTap: () => _addToFavorites(context), 
          playAnimation: false,
        );
      }

      if (state is LikeButtonAdded) {
        return AddFavoriteButton(onTap: () => _removeFromFavorites(context));
      }

      if (state is LikeButtonRemoved) {
        return RemoveFavoriteButton(onTap: () => _addToFavorites(context));
      }

      return const SizedBox(width: 0, height: 0,);
    },
  );

  void _addToFavorites(BuildContext context) {
    BlocProvider.of<LikeButtonCubit>(context).add();
  }

  void _removeFromFavorites(BuildContext context) {
    BlocProvider.of<LikeButtonCubit>(context).remove();

    _showUndoSnackbar(context);
  }

  void _showStory(BuildContext context) {
    if (story.url?.isEmpty ?? true) {
      final url = Uri.https('news.ycombinator.com', '/item', {'id':'${story.id}'});
      launchUrl(url);
      return;
    }

    launchUrl(Uri.parse(story.url!));
  }

  void _showUndoSnackbar(BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(context.l10n.setToRemoveFromFavorites), 
      action: SnackBarAction(
        label: context.l10n.undo, 
        onPressed: () => _addToFavorites(context),
      ),
    ),
  ).closed.then((value) => onFavoriteRemoved?.call());
}