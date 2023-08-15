import 'package:flutter/material.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/ui/widgets/story_listtile.dart';

class StoriesListView extends StatelessWidget {
  const StoriesListView({
    super.key, 
    required this.stories,
    required this.storageKey,
  });

  final List<ItemModel> stories;
  final int storageKey;

  @override
  Widget build(BuildContext context) => ListView.builder(
    key: PageStorageKey(storageKey),
    itemCount: stories.length,
    itemBuilder: (context, index) {
      final story = stories[index]; 
      return StoryListTile(story: story);
    }
  );
}

class SliverStoriesListView extends StatelessWidget {
  const SliverStoriesListView({
    super.key, 
    required this.stories,
    required this.storageKey,
  });

  final List<ItemModel> stories;
  final int storageKey;

  @override
  Widget build(BuildContext context) => SliverList.builder(
    key: PageStorageKey(storageKey),
    itemCount: stories.length,
    itemBuilder: (context, index) {
      final story = stories[index]; 
      return StoryListTile(story: story);
    }
  );
}