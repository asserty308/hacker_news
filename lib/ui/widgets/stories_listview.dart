import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/state/app/app_cubit.dart';

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
          onTap: () => CubitProvider.of<AppCubit>(context).callUrl(story.url),
        );
      }
    );
  }
}