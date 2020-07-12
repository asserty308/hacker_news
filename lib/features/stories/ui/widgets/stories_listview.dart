import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:hacker_news/features/stories/data/models/item_model.dart';
import 'package:hacker_news/features/stories/state/top_stories/top_stories_cubit.dart';

class StoriesListView extends StatelessWidget {
  const StoriesListView({Key key, this.stories}) : super(key: key);

  final List<ItemModel> stories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stories.length,
      itemBuilder: (context, index) {
        final story = stories[index]; 
        return ListTile(
          title: Text(story.title ?? 'Unknown title', style: TextStyle(color: Colors.white),),
          onTap: () => CubitProvider.of<TopStoriesCubit>(context).openStory(story.url),
        );
      }
    );
  }
}