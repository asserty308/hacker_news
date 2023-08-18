import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/favorites/favorites_cubit.dart';
import 'package:hacker_news/data/repositories/favorites_repo.dart';
import 'package:hacker_news/l10n/l10n.dart';
import 'package:hacker_news/ui/widgets/action_buttons.dart';
import 'package:hacker_news/ui/widgets/stories_listview.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({super.key});

  final _bloc = FavoritesCubit(favoritesRepository);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverAppBar(
          title: Text(context.l10n.favorites),
          floating: true,
          actions: const [
            HomeAction(),
            SettingsAction(),
          ],
        ),
        _body,
      ],
    ),
  );

  Widget get _body => BlocBuilder(
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

      return const SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );

  Widget _emptyListHint(BuildContext context) => SliverFillRemaining(
    child: Center(
      child: Text(context.l10n.emptyFavoritesHint),
    ),
  );
}