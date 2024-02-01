import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/favorites/favorites_cubit.dart';
import 'package:hacker_news/l10n/l10n.dart';
import 'package:hacker_news/ui/widgets/stories_listview.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();

    context.read<FavoritesCubit>().loadStories();
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
    builder: (context, state) {
      if (state is FavoritesLoaded) {
        if (state.stories.isEmpty) {
          return _emptyListHint(context);
        }
        
        return SliverStoriesListView(
          stories: state.stories, 
          storageKey: 1,
          onFavoriteRemoved: context.read<FavoritesCubit>().loadStories,
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