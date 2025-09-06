import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/config/router.dart';
import 'package:hacker_news/data/providers/providers.dart';
import 'package:hacker_news/l10n/l10n.dart';
import 'package:hacker_news/ui/blocs/top_stories/top_stories_cubit.dart';
import 'package:hacker_news/ui/widgets/story_page_item.dart';

class TopStoriesPage extends ConsumerStatefulWidget {
  const TopStoriesPage({super.key});

  @override
  ConsumerState<TopStoriesPage> createState() => _TopStoriesPageState();
}

class _TopStoriesPageState extends AppConsumerState<TopStoriesPage> {
  final _pageController = PageController();
  final _animationDuration = const Duration(milliseconds: 250);

  var _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageListener);
  }

  @override
  void onUIReady() {
    super.onUIReady();
    _bloc.loadStories();
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: _keyboardListener);

  Widget get _keyboardListener => CallbackShortcuts(
    bindings: {
      const SingleActivator(LogicalKeyboardKey.arrowUp): () =>
          _handleArrowEvents(true),
      const SingleActivator(LogicalKeyboardKey.arrowDown): () =>
          _handleArrowEvents(false),
    },
    child: Focus(autofocus: true, child: _body),
  );

  Widget get _body =>
      SafeArea(child: Stack(children: [_pageView, _infoButton]));

  Widget get _pageView => BlocConsumer<TopStoriesCubit, TopStoriesState>(
    bloc: _bloc,
    listener: (context, state) {
      if (state is TopStoriesLoaded && state.stories.isNotEmpty) {
        // add first story to history cache
        _bloc.addToHistory(state.stories.first.id);

        if (state.stories.length == 1) {
          _bloc.loadStories();
        }
      }
    },
    builder: (context, state) {
      if (state is TopStoriesLoaded) {
        return PageView.builder(
          itemCount: state.stories.length,
          controller: _pageController,
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

  Widget get _infoButton => Padding(
    padding: const EdgeInsets.all(16),
    child: Align(
      alignment: Alignment.bottomRight,
      child: Semantics(
        label: context.l10n.accessibilitySettings,
        button: true,
        child: InkWell(
          onTap: () => appRouter.push('/settings'),
          child: Icon(Icons.info_outline, size: 32),
        ),
      ),
    ),
  );

  Widget get _loadingWidget => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator.adaptive(),
        const SizedBox(height: 16),
        Text(
          context.l10n.storiesLoading,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    ),
  );

  Widget get _errorWidget => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.errorLoadingStories,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _bloc.loadStories,
            child: Text(context.l10n.tryAgain),
          ),
        ],
      ),
    ),
  );

  void _handleArrowEvents(bool isArrowUp) {
    if (_isAnimating) {
      logger.i('Do not scroll when animating');
      return;
    }

    if (isArrowUp) {
      _pageController.previousPage(
        duration: _animationDuration,
        curve: Curves.decelerate,
      );
    } else {
      _pageController.nextPage(
        duration: _animationDuration,
        curve: Curves.decelerate,
      );
    }
  }

  /// Called multiple times during an page animation.
  void _pageListener() {
    setState(() {
      _isAnimating = true;
    });

    if ((_pageController.page ?? 0.0) % 1.0 == 0.0) {
      final page = _pageController.page?.toInt() ?? 0;
      _onPageChanged(page);
    }
  }

  /// Triggered on page changes and adds the stories the user has already seen to the history cache
  void _onPageChanged(int page) {
    setState(() {
      _isAnimating = false;
    });

    if (_bloc.state is TopStoriesLoaded) {
      _bloc.addToHistory((_bloc.state as TopStoriesLoaded).stories[page].id);
    }

    if (page == _bloc.storyCount - 1) {
      logger.i('Loading next bunch of stories');
      Timer.run(_bloc.loadStories);
    }
  }

  TopStoriesCubit get _bloc => ref.read(topStoriesCubitProvider);
}
