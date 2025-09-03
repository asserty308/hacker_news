import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/data/providers/providers.dart';
import 'package:hacker_news/l10n/l10n.dart';
import 'package:hacker_news/ui/blocs/favorites/favorites_cubit.dart';
import 'package:hacker_news/ui/widgets/stories_listview.dart';

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends AppConsumerState<FavoritesPage> {
  late final _bloc = ref.read(favoritesCubitProvider);

  @override
  void onUIReady() {
    super.onUIReady();

    _bloc.loadStories();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      physics: const ClampingScrollPhysics(),
      restorationId: 'favorites_list',
      slivers: [
        SliverAppBar(title: Text(context.l10n.favorites), floating: true),
        _body,
      ],
    ),
  );

  Widget get _body => BlocBuilder<FavoritesCubit, FavoritesState>(
    bloc: _bloc,
    builder: (context, state) {
      if (state is FavoritesLoaded) {
        if (state.stories.isEmpty) {
          return _emptyListHint(context);
        }

        return SliverStoriesListView(
          stories: state.stories,
          storageKey: 1,
          onFavoriteRemoved: _bloc.loadStories,
        );
      }

      if (state is FavoritesError) {
        return _errorWidget(context);
      }

      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                context.l10n.favoritesLoading,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      );
    },
  );

  Widget _emptyListHint(BuildContext context) => SliverFillRemaining(
    child: Center(child: Text(context.l10n.emptyFavoritesHint)),
  );

  Widget _errorWidget(BuildContext context) => SliverFillRemaining(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.errorLoadingFavorites,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _bloc.loadStories,
            child: Text(context.l10n.tryAgain),
          ),
        ],
      ),
    ),
  );
}
