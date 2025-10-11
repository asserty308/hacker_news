import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/features/stories/ui/blocs/top_stories/top_stories_cubit.dart';
import 'package:hacker_news/features/stories/ui/widgets/story_page_item.dart';
import 'package:hacker_news/l10n/l10n.dart';

class TopstoriesListview extends ConsumerStatefulWidget {
  const TopstoriesListview({
    super.key,
    required this.pageController,
    required this.topStoriesCubit,
  });

  final PageController pageController;
  final TopStoriesCubit topStoriesCubit;

  @override
  ConsumerState<TopstoriesListview> createState() => _TopstoriesListviewState();
}

class _TopstoriesListviewState extends AppConsumerState<TopstoriesListview> {
  @override
  void onUIReady() {
    super.onUIReady();
    widget.topStoriesCubit.loadNextStories();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<TopStoriesCubit, TopStoriesState>(
        bloc: widget.topStoriesCubit,
        listener: (context, state) {
          if (state is TopStoriesLoaded && state.stories.isNotEmpty) {
            if (state.stories.length == 1) {
              widget.topStoriesCubit.loadNextStories();
            }
          }
        },
        builder: (context, state) {
          if (state is TopStoriesLoaded) {
            return PageView.builder(
              itemCount: state.stories.length,
              controller: widget.pageController,
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final story = state.stories[index];
                return Padding(
                  padding: const EdgeInsets.all(64),
                  child: StoryPageItem(story: story),
                );
              },
            );
          }

          if (state is TopStoriesError) {
            return _errorWidget;
          }

          return _loadingWidget;
        },
      );

  Widget get _loadingWidget => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator.adaptive(),
        const SizedBox(height: 16),
        Text(context.l10n.storiesLoading, style: context.textTheme.bodyMedium),
      ],
    ),
  );

  Widget get _errorWidget => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: context.colorScheme.error),
          const SizedBox(height: 16),
          Text(
            context.l10n.errorLoadingStories,
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: widget.topStoriesCubit.loadNextStories,
            child: Text(context.l10n.tryAgain),
          ),
        ],
      ),
    ),
  );
}
