import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/features/home/ui/blocs/top_stories/top_stories_cubit.dart';
import 'package:hacker_news/features/home/ui/widgets/page_view.dart';
import 'package:hacker_news/l10n/l10n.dart';

class TopstoriesListView extends ConsumerStatefulWidget {
  const TopstoriesListView({
    super.key,
    required this.pageController,
    required this.topStoriesCubit,
  });

  final PageController pageController;
  final TopStoriesCubit topStoriesCubit;

  @override
  ConsumerState<TopstoriesListView> createState() => _TopstoriesListviewState();
}

class _TopstoriesListviewState extends AppConsumerState<TopstoriesListView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void onUIReady() {
    super.onUIReady();
    widget.topStoriesCubit.loadNextStories();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return BlocConsumer<TopStoriesCubit, TopStoriesState>(
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
          return StoriesPageView(
            stories: state.stories,
            pageController: widget.pageController,
          );
        }

        if (state is TopStoriesError) {
          return _errorWidget;
        }

        return _loadingWidget;
      },
    );
  }

  Widget get _loadingWidget => Center(
    child: Column(
      mainAxisAlignment: .center,
      children: [
        const CircularProgressIndicator.adaptive(),
        const SizedBox(height: 16),
        Text(context.l10n.storiesLoading, style: context.textTheme.bodyMedium),
      ],
    ),
  );

  Widget get _errorWidget => Center(
    child: Padding(
      padding: const .all(32),
      child: Column(
        mainAxisAlignment: .center,
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
