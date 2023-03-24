import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/top_stories_screen/top_stories_cubit.dart';
import 'package:hacker_news/data/repositories/hackernews_repository.dart';
import 'package:hacker_news/services/router.dart';
import 'package:hacker_news/ui/widgets/stories_listview.dart';

class TopStoriesScreen extends StatelessWidget {
  TopStoriesScreen({super.key});

  final _bloc = TopstoriesCubit(hackernewsRepo);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Top Stories'),
      actions: [
        IconButton(icon: const Icon(Icons.favorite), onPressed: () => appRouter.go('/favorites')),
      ],
    ),
    body: _body,
  );

  Widget get _body => BlocBuilder(
    bloc: _bloc,
    builder: (context, state) {
      if (state is TopStoriesLoaded) {
        return StoriesListView(stories: state.stories);
      }

      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}

