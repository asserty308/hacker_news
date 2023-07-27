import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/top_stories/top_stories_cubit.dart';
import 'package:hacker_news/data/repositories/hackernews_repo.dart';
import 'package:hacker_news/ui/widgets/action_buttons.dart';
import 'package:hacker_news/ui/widgets/stories_listview.dart';

final _bloc = TopStoriesCubit(hackernewsRepo);

class TopStoriesPage extends StatelessWidget {
  TopStoriesPage({super.key}) {
    if (_bloc.state is TopStoriesInitial) {
      _bloc.loadStories();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Top Stories'),
      actions: const [
        FavoritesAction(),
        SettingsAction(),
      ],
    ),
    body: _body,
  );

  Widget get _body => BlocBuilder(
    bloc: _bloc,
    builder: (context, state) {
      if (state is TopStoriesLoaded) {
        return RefreshIndicator(
          onRefresh: _bloc.loadStories,
          child: StoriesListView(stories: state.stories)
        );
      }

      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}

