import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/data/providers/providers.dart';
import 'package:hacker_news/ui/blocs/favorites/favorites_cubit.dart';
import 'package:hacker_news/l10n/l10n.dart';
import 'package:hacker_news/ui/widgets/stories_listview.dart';

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
  late final _bloc = ref.read(favoritesCubitProvider);

  @override
  void initState() {
    super.initState();

    _bloc.loadStories();
  }
  
  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      physics: const ClampingScrollPhysics(),
      restorationId: 'favorites_list',
      slivers: [
        SliverAppBar(
          title: Text(context.l10n.favorites),
          floating: true,
        ),
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