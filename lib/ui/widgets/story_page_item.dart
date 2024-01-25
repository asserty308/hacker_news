import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/like_button/like_button_cubit.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/data/repositories/favorites_repo.dart';
import 'package:hacker_news/ui/widgets/add_favorite_button.dart';
import 'package:hacker_news/ui/widgets/remove_favorite_button.dart';
import 'package:url_launcher/url_launcher.dart';

class StoryPageItem extends StatelessWidget {
  const StoryPageItem({
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

  Widget _tile(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _title(context),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: _subtitle(context),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: _favButton
            ),
            TextButton(onPressed: () => _showStory(context), child: const Text('Show'))
          ],
        )
      ],
    ),
  );

  Widget _title(BuildContext context) => Text(
    story.title,
    style: Theme.of(context).textTheme.titleLarge,
    textAlign: TextAlign.center
  );

  Widget _subtitle(BuildContext context) {
    final diff = story.formattedDifference(context);
    final authority = Uri.tryParse(story.url ?? '')?.authority ?? '';
    return Text('$diff ${authority.isEmpty ? '' : ' - $authority'}', textAlign: TextAlign.center,);
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
  }

  void _showStory(BuildContext context) {
    if (story.url?.isEmpty ?? true) {
      final url = Uri.https('news.ycombinator.com', '/item', {'id':'${story.id}'});
      launchUrl(url);
      return;
    }

    launchUrl(Uri.parse(story.url!));
  }
}