import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:hacker_news/features/newspaper/data/models/item_model.dart';
import 'package:hacker_news/features/newspaper/data/repositories/hackernews_repository.dart';
import 'package:hacker_news/features/newspaper/state/top_stories/top_stories_cubit.dart';
import 'package:page_turn/page_turn.dart';

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
        return _pageTurn(state.stories);
      }

      return Container(color: Colors.white,);
    },
  );

  Widget _pageTurn(List<ItemModel> stories) => PageTurn(
    children: [
      _listView(stories.getRange(0, 10).toList()),
      _listView(stories.getRange(10, 20).toList()),
      _listView(stories.getRange(20, 30).toList()),
    ]
  );

  Widget _listView(List<ItemModel> stories) => ListView.builder(
    itemCount: stories.length,
    itemBuilder: (context, index) {
      final story = stories[index]; 
      return ListTile(title: Text(story.title ?? 'Unknown title', style: TextStyle(color: Colors.black),),);
    }
  );
}