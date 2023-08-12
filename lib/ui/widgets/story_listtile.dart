import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/like_button/like_button_cubit.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/data/repositories/favorites_repo.dart';
import 'package:url_launcher/url_launcher.dart';

class StoryListTile extends StatelessWidget {
  const StoryListTile({
    super.key,
    required this.story,
  });

  final ItemModel story;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => LikeButtonCubit(favoritesRepository, story),
    child: _tile(context),
  );

  Widget _tile(BuildContext context) => ListTile(
    title: _title,
    subtitle: _subtitle,
    trailing: _favButton,
    onTap: () => _showStory(context),
  );

  Widget get _title => Text(
    story.title,
  );

  Widget get _subtitle {
    final diff = story.formattedDifference;
    final authority = Uri.tryParse(story.url ?? '')?.authority ?? '';
    return Text('$diff ${authority.isEmpty ? '' : ' - $authority'}');
  }

  Widget get _favButton => BlocBuilder<LikeButtonCubit, LikeButtonState>(
    builder: (context, state) {
      if (state is LikeButtonAdded) {
        return IconButton(
          icon: const Icon(Icons.favorite), 
          onPressed: () => _removeFromFavorites(context),
        );
      }

      if (state is LikeButtonRemoved) {
        return IconButton(
          icon: const Icon(Icons.favorite_border), 
          onPressed: () => _addToFavorites(context),
        );
      }

      return const SizedBox(width: 0, height: 0,);
    },
  );

  void _addToFavorites(BuildContext context) {
    BlocProvider.of<LikeButtonCubit>(context).add();
  }

  void _removeFromFavorites(BuildContext context) {
    BlocProvider.of<LikeButtonCubit>(context).remove();
  }

  void _showStory(BuildContext context) {
    if (story.url?.isEmpty ?? true) {
      final url = Uri.https('news.ycombinator.com', '/item', {'id':'${story.id}'});
      launchUrl(url);
      return;
    }

    launchUrl(Uri.parse(story.url!));
  }
}