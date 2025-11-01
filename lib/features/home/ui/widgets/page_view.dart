import 'package:flutter/material.dart';
import 'package:hacker_news/features/home/data/models/item_model.dart';
import 'package:hacker_news/features/home/ui/widgets/story_page_item.dart';

class StoriesPageView extends StatelessWidget {
  const StoriesPageView({
    super.key,
    required this.stories,
    required this.pageController,
  });

  final List<ItemModel> stories;
  final PageController pageController;

  @override
  Widget build(BuildContext context) => PageView.builder(
    itemCount: stories.length,
    controller: pageController,
    scrollDirection: Axis.vertical,
    physics: const ClampingScrollPhysics(),
    itemBuilder: (context, index) {
      final story = stories[index];
      return Padding(
        padding: const EdgeInsets.all(64),
        child: StoryPageItem(story: story),
      );
    },
  );
}
