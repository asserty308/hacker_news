import 'package:flutter/material.dart';
import 'package:flutter_core/ui/widgets/center_progress_indicator.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:hacker_news/bloc/app/app_cubit.dart';
import 'package:hacker_news/bloc/top_stories_screen/top_stories_cubit.dart';
import 'package:hacker_news/ui/widgets/stories_listview.dart';

class TopStoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Top Stories'),
      actions: [
        IconButton(icon: Icon(Icons.favorite), onPressed: () => CubitProvider.of<AppCubit>(context).showFavorites())
      ],
    ),
    body: _body,
  );

  Widget get _body => CubitBuilder<TopStoriesCubit, TopStoriesState>(
    builder: (context, state) {
      if (state is TopStoriesLoaded) {
        return StoriesListView(stories: state.stories);
      }

      return CenterProgressIndicator();
    },
  );
}

