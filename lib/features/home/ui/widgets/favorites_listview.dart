import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/features/favorites/di/providers.dart';
import 'package:hacker_news/features/home/ui/blocs/favorites/favorites_cubit.dart';
import 'package:hacker_news/features/home/ui/widgets/page_view.dart';
import 'package:hacker_news/l10n/l10n.dart';

class FavoritesListView extends ConsumerStatefulWidget {
  const FavoritesListView({super.key});

  @override
  ConsumerState<FavoritesListView> createState() => _FavoritesListViewState();
}

class _FavoritesListViewState extends AppConsumerState<FavoritesListView>
    with AutomaticKeepAliveClientMixin {
  late final _favoritesBloc = ref.read(favoritesCubitProvider);

  final _pageController = PageController();

  @override
  bool get wantKeepAlive => true;

  @override
  void onUIReady() {
    super.onUIReady();
    _favoritesBloc.loadStories();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      bloc: _favoritesBloc,
      builder: (context, state) {
        if (state is FavoritesLoaded) {
          if (state.stories.isEmpty) {
            return _emptyListHint(context);
          }

          return StoriesPageView(
            stories: state.stories,
            pageController: _pageController,
          );
        }

        if (state is FavoritesError) {
          return _errorWidget(context);
        }

        return Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const CircularProgressIndicator(),
              vGap16,
              Text(
                context.l10n.favoritesLoading,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _emptyListHint(BuildContext context) =>
      Center(child: Text(context.l10n.emptyFavoritesHint));

  Widget _errorWidget(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: .center,
      children: [
        Icon(Icons.error_outline, size: 48, color: context.colorScheme.error),
        vGap16,
        Text(
          context.l10n.errorLoadingFavorites,
          style: context.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        vGap16,
        ElevatedButton(
          onPressed: _favoritesBloc.loadStories,
          child: Text(context.l10n.tryAgain),
        ),
      ],
    ),
  );
}
