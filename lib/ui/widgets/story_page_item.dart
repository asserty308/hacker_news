import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/data/providers/providers.dart';
import 'package:hacker_news/domain/use_cases/show_story_use_case.dart';
import 'package:hacker_news/ui/blocs/like_button/like_button_cubit.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/ui/widgets/add_favorite_button.dart';
import 'package:hacker_news/ui/widgets/remove_favorite_button.dart';
import 'package:share_plus/share_plus.dart';

class StoryPageItem extends ConsumerWidget {
  const StoryPageItem({super.key, required this.story, this.onFavoriteRemoved});

  final ItemModel story;
  final VoidCallback? onFavoriteRemoved;

  @override
  Widget build(BuildContext context, WidgetRef ref) => BlocProvider(
    create:
        (context) => LikeButtonCubit(ref.read(favoritesRepoProvider), story),
    child: _tile(context),
  );

  Widget _tile(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      _title(context),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: _subtitle(context),
      ),
      Wrap(
        spacing: 32,
        runSpacing: 32,
        children: [_favButton, _shareButton(context)],
      ),
    ],
  );

  Widget _title(BuildContext context) => TextButton(
    onPressed: () => _showStory(context),
    style: TextButton.styleFrom(
      splashFactory: NoSplash.splashFactory,
      overlayColor: Colors.transparent,
    ),
    child: Text(
      story.title,
      maxLines: 5,
      style: Theme.of(
        context,
      ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    ),
  );

  Widget _subtitle(BuildContext context) {
    final diff = story.formattedDifference(context);
    final authority = story.urlAuthority;
    return Text(
      '$diff ${authority.isEmpty ? '' : ' - $authority'}',
      maxLines: 3,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );
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

      return const SizedBox(width: 0, height: 0);
    },
  );

  Widget _shareButton(BuildContext context) => InkWell(
    onTap: () => _shareStory(context),
    child: const Icon(CupertinoIcons.share, size: 36),
  );

  void _addToFavorites(BuildContext context) {
    context.read<LikeButtonCubit>().add();
  }

  void _removeFromFavorites(BuildContext context) {
    context.read<LikeButtonCubit>().remove();
  }

  void _showStory(BuildContext context) {
    final showStoryUseCase = ShowStoryUseCase();
    showStoryUseCase.execute(story);
  }

  void _shareStory(BuildContext context) {
    Share.share(story.realUrl.toString());
  }
}
