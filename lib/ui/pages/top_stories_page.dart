import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/top_stories/top_stories_cubit.dart';
import 'package:hacker_news/data/repositories/hackernews_repo.dart';
import 'package:hacker_news/data/repositories/story_history_repo.dart';
import 'package:hacker_news/router/router.dart';
import 'package:hacker_news/ui/widgets/story_page_item.dart';

class TopStoriesPage extends StatefulWidget {
  const TopStoriesPage({super.key});

  @override
  State<TopStoriesPage> createState() => _TopStoriesPageState();
}

class _TopStoriesPageState extends State<TopStoriesPage> {
  final _bloc = TopStoriesCubit(hackernewsRepo);
  final _pageController = PageController();
  final _focusNode = FocusNode();

  final _animationDuration = const Duration(milliseconds: 250);

  var _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageListener);
    _bloc.loadStories();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) => Scaffold(
    body: _keyboardListener,
  );

  Widget get _keyboardListener => Focus(
    focusNode: _focusNode,
    onKey: _handleKeyEvent,
    child: Stack(
      children: [
        _pageView,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () => appRouter.go('/favorites'), 
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.background
              ),
              child: const Text('Show Favorites'),
            ),
          ),
        )
      ],
    ),
  );

  Widget get _pageView => BlocConsumer(
    bloc: _bloc,
    listener: (context, state) {
      if (state is TopStoriesLoaded && state.stories.isNotEmpty) {
        // add first story to history cache
        historyRepo.add(state.stories.first.id);
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
              padding: const EdgeInsets.all(32),
              child: StoryPageItem(story: story),
            );
          }
        );
      }

      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
  );

  KeyEventResult _handleKeyEvent(FocusNode node, RawKeyEvent event) {
    if (_isAnimating) {
      log('Do not scroll when animating');
      return KeyEventResult.ignored;
    }

    final isArrowUp = event.physicalKey == PhysicalKeyboardKey.arrowUp;
    final isArrowDown = event.physicalKey == PhysicalKeyboardKey.arrowDown;

    if (isArrowUp) {
      _pageController.previousPage(duration: _animationDuration, curve: Curves.decelerate);
    } else if (isArrowDown) {
      _pageController.nextPage(duration: _animationDuration, curve: Curves.decelerate);
    }

    return isArrowUp || isArrowDown ? KeyEventResult.handled : KeyEventResult.ignored;
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
      historyRepo.add((_bloc.state as TopStoriesLoaded).stories[page].id);
    }
  }
}
