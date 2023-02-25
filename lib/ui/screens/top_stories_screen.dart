import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/app/app_cubit.dart';
import 'package:hacker_news/bloc/top_stories_screen/top_stories_cubit.dart';
import 'package:hacker_news/ui/widgets/stories_listview.dart';

class TopStoriesScreen extends StatelessWidget {
  const TopStoriesScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Top Stories'),
      actions: [
        IconButton(icon: const Icon(Icons.favorite), onPressed: () => BlocProvider.of<AppCubit>(context).showFavorites())
      ],
    ),
    body: _body,
  );

  Widget get _body => BlocBuilder<TopStoriesCubit, TopStoriesState>(
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

