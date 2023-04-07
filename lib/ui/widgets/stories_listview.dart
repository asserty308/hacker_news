import 'package:flutter/material.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/ui/widgets/story_listtile.dart';

class StoriesListView extends StatelessWidget {
  const StoriesListView({super.key, required this.stories});

  final List<ItemModel> stories;

  @override
  Widget build(BuildContext context) => ListView.builder(
    itemCount: stories.length,
    itemBuilder: (context, index) {
      final story = stories[index]; 
      return StoryListTile(story: story);
    }
  );
}