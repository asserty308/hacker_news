import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:hacker_news/features/newspaper/data/repositories/hackernews_repository.dart';
import 'package:hacker_news/features/newspaper/state/top_stories/top_stories_cubit.dart';

class TopStoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _cubitProvider;
  }

  // State

  Widget get _cubitProvider => CubitProvider(
    create: (context) => TopStoriesCubit(globalHackernewsRepo),
    child: _scaffold,
  );

  // Widgets

  Widget get _scaffold => Scaffold(
    body: _body,
  );

  Widget get _body => CubitBuilder<TopStoriesCubit, TopStoriesState>(
    builder: (context, state) {
      if (state is TopStoriesLoaded) {
        return ListView.builder(
          itemCount: state.stories.length,
          itemBuilder: (context, index) {
            final story = state.stories[index]; 
            return ListTile(title: Text(story.title),);
          }
        );
      }

      return Container(color: Colors.white,);
    },
  );
}