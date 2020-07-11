import 'package:flutter/material.dart';
import 'package:flutter_core/ui/widgets/center_progress_indicator.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:hacker_news/features/newspaper/data/models/item_model.dart';
import 'package:hacker_news/features/newspaper/data/repositories/hackernews_repository.dart';
import 'package:hacker_news/features/newspaper/state/top_stories/top_stories_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

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
        return _listView(state.stories);
      }

      return CenterProgressIndicator();
    },
  );

  Widget _listView(List<ItemModel> stories) => ListView.builder(
    itemCount: stories.length,
    itemBuilder: (context, index) {
      final story = stories[index]; 
      return ListTile(
        title: Text(story.title ?? 'Unknown title', style: TextStyle(color: Colors.white),),
        onTap: () => _showStory(story.url),
      );
    }
  );

  // Functions

  void _showStory(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    }
  }
}