import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/features/favorites/di/providers.dart';
import 'package:hacker_news/features/stories/data/models/item_model.dart';
import 'package:hacker_news/features/stories/di/providers.dart';
import 'package:hacker_news/features/stories/ui/blocs/like_button/like_button_cubit.dart';
import 'package:hacker_news/features/stories/ui/widgets/add_favorite_button.dart';
import 'package:hacker_news/features/stories/ui/widgets/remove_favorite_button.dart';
import 'package:hacker_news/l10n/l10n.dart';

class StoryListTile extends ConsumerWidget {
  const StoryListTile({super.key, required this.story, this.onFavoriteRemoved});

  final ItemModel story;
  final VoidCallback? onFavoriteRemoved;

  @override
  Widget build(BuildContext context, WidgetRef ref) => BlocProvider(
    create: (context) =>
        LikeButtonCubit(ref.read(favoritesRepoProvider), story),
    child: _tile(context, ref),
  );

  Widget _tile(BuildContext context, WidgetRef ref) => ListTile(
    title: _title,
    subtitle: _subtitle(context),
    trailing: _favButton,
    onTap: () => _showStory(ref),
  );

  Widget get _title => Text(story.title);

  Widget _subtitle(BuildContext context) {
    final diff = story.formattedDifference(context);
    final authority = story.urlAuthority;
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

      return gap0;
    },
  );

  void _addToFavorites(BuildContext context) {
    context.read<LikeButtonCubit>().add();
  }

  void _removeFromFavorites(BuildContext context) {
    context.read<LikeButtonCubit>().remove();

    _showUndoSnackbar(context);
  }

  void _showStory(WidgetRef ref) {
    final showStoryUseCase = ref.read(showStoryUseCaseProvider);
    showStoryUseCase.execute(story);
  }

  void _showUndoSnackbar(BuildContext context) => ScaffoldMessenger.of(context)
      .showSnackBar(
        SnackBar(
          content: Text(context.l10n.setToRemoveFromFavorites),
          action: SnackBarAction(
            label: context.l10n.undo,
            onPressed: () => _addToFavorites(context),
          ),
        ),
      )
      .closed
      .then((value) => onFavoriteRemoved?.call());
}
