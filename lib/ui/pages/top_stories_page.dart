import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/top_stories/top_stories_cubit.dart';
import 'package:hacker_news/data/repositories/hackernews_repo.dart';
import 'package:hacker_news/l10n/l10n.dart';
import 'package:hacker_news/ui/widgets/action_buttons.dart';
import 'package:hacker_news/ui/widgets/stories_listview.dart';

class TopStoriesPage extends StatefulWidget {
  const TopStoriesPage({super.key});

  @override
  State<TopStoriesPage> createState() => _TopStoriesPageState();
}

class _TopStoriesPageState extends State<TopStoriesPage> {
  final _bloc = TopStoriesCubit(hackernewsRepo);

  @override
  void initState() {
    super.initState();
    _bloc.loadStories();
  }
  
  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      physics: const ClampingScrollPhysics(),
      restorationId: 'top_stories_list',
      slivers: [
        SliverAppBar(
          title: Text(context.l10n.topStories),
          floating: true,
          actions: const [
            FavoritesAction(),
            SettingsAction(),
          ],
        ),
        _body,
      ],
    )
  );

  Widget get _body => BlocBuilder(
    bloc: _bloc,
    builder: (context, state) {
      if (state is TopStoriesLoaded) {
        return SliverStoriesListView(
          stories: state.stories, 
          storageKey: 0,
        );
      }

      return const SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}
