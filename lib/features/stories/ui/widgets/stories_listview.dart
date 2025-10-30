import 'package:flutter/material.dart';
import 'package:hacker_news/features/stories/data/models/item_model.dart';
import 'package:hacker_news/features/stories/ui/widgets/story_listtile.dart';

class StoriesListView extends StatelessWidget {
  const StoriesListView({
    super.key,
    required this.stories,
    required this.storageKey,
    this.onFavoriteRemoved,
  });

  final List<ItemModel> stories;
  final int storageKey;
  final VoidCallback? onFavoriteRemoved;

  @override
  Widget build(BuildContext context) => ListView.builder(
    key: PageStorageKey(storageKey),
    padding: const EdgeInsets.only(top: 72),
    itemCount: stories.length,
    itemBuilder: (context, index) {
      final story = stories[index];
      return StoryListTile(story: story, onFavoriteRemoved: onFavoriteRemoved);
    },
  );
}

class SliverStoriesListView extends StatelessWidget {
  const SliverStoriesListView({
    super.key,
    required this.stories,
    required this.storageKey,
    this.onFavoriteRemoved,
  });

  final List<ItemModel> stories;
  final int storageKey;
  final VoidCallback? onFavoriteRemoved;

  @override
  Widget build(BuildContext context) => SliverList.builder(
    key: PageStorageKey(storageKey),
    itemCount: stories.length,
    itemBuilder: (context, index) {
      final story = stories[index];
      return StoryListTile(story: story, onFavoriteRemoved: onFavoriteRemoved);
    },
  );
}
