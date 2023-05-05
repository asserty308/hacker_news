import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/top_stories/top_stories_cubit.dart';
import 'package:hacker_news/data/repositories/hackernews_repo.dart';
import 'package:hacker_news/router/router.dart';
import 'package:hacker_news/ui/widgets/stories_listview.dart';

class TopStoriesPage extends StatelessWidget {
  TopStoriesPage({super.key}) {
    _bloc.loadStories();
  }

  final _bloc = TopStoriesCubit(hackernewsRepo);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Top Stories'),
      actions: [
        IconButton(icon: const Icon(Icons.favorite), onPressed: () => appRouter.go('/favorites')),
        IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () => appRouter.go('/settings')),
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

