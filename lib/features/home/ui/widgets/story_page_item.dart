import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/features/favorites/di/providers.dart';
import 'package:hacker_news/features/home/data/models/item_model.dart';
import 'package:hacker_news/features/home/domain/use_cases/show_story_use_case.dart';
import 'package:hacker_news/features/home/ui/blocs/like_button/like_button_cubit.dart';
import 'package:hacker_news/features/home/ui/widgets/add_favorite_button.dart';
import 'package:hacker_news/features/home/ui/widgets/remove_favorite_button.dart';
import 'package:hacker_news/l10n/l10n.dart';
import 'package:share_plus/share_plus.dart';

class StoryPageItem extends ConsumerStatefulWidget {
  const StoryPageItem({super.key, required this.story, this.onFavoriteRemoved});

  final ItemModel story;
  final VoidCallback? onFavoriteRemoved;

  @override
  ConsumerState<StoryPageItem> createState() => _StoryPageItemState();
}

class _StoryPageItemState extends AppConsumerState<StoryPageItem> {
  late final _likeButtonCubit = LikeButtonCubit(
    ref.read(favoritesRepoProvider),
    widget.story,
  );

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: .center,
    mainAxisSize: .max,
    children: [
      _title(context),
      Padding(
        padding: const .symmetric(vertical: 32),
        child: _subtitle(context),
      ),
      Wrap(
        spacing: 32,
        runSpacing: 32,
        children: [_favButton, _shareButton(context)],
      ),
    ],
  );

  Widget _title(BuildContext context) => Semantics(
    label: context.l10n.accessibilityOpenStory,
    button: true,
    child: TextButton(
      onPressed: _showStory,
      style: TextButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        overlayColor: Colors.transparent,
      ),
      child: Text(
        widget.story.title,
        maxLines: 5,
        style: context.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w900,
        ),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );

  Widget _subtitle(BuildContext context) {
    final diff = widget.story.formattedDifference(context);
    final authority = widget.story.urlAuthority;
    return Text(
      '$diff ${authority.isEmpty ? '' : ' - $authority'}',
      maxLines: 3,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget get _favButton => BlocBuilder(
    bloc: _likeButtonCubit,
    builder: (context, state) {
      if (state is LikeButtonIsFavorite) {
        return AddFavoriteButton(
          onTap: _removeFromFavorites,
          playAnimation: false,
        );
      }

      if (state is LikeButtonIsNotFavorite) {
        return RemoveFavoriteButton(
          onTap: _addToFavorites,
          playAnimation: false,
        );
      }

      if (state is LikeButtonAdded) {
        return AddFavoriteButton(onTap: _removeFromFavorites);
      }

      if (state is LikeButtonRemoved) {
        return RemoveFavoriteButton(onTap: _addToFavorites);
      }

      return const SizedBox(width: 0, height: 0);
    },
  );

  Widget _shareButton(BuildContext context) => Semantics(
    label: context.l10n.accessibilityShareStory,
    button: true,
    child: InkWell(
      onTap: _shareStory,
      child: const Icon(CupertinoIcons.share, size: 36),
    ),
  );

  Future<void> _addToFavorites() async {
    await _likeButtonCubit.add();
    ref.read(favoritesCubitProvider).loadStories();
  }

  Future<void> _removeFromFavorites() async {
    await _likeButtonCubit.remove();
    ref.read(favoritesCubitProvider).loadStories();
  }

  void _showStory() {
    final showStoryUseCase = ShowStoryUseCase();
    showStoryUseCase.execute(widget.story);
  }

  void _shareStory() => SharePlus.instance.share(
    ShareParams(uri: widget.story.realUrl, subject: widget.story.title),
  );
}
