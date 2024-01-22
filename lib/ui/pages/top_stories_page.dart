import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/top_stories/top_stories_cubit.dart';
import 'package:hacker_news/data/repositories/hackernews_repo.dart';
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

  Widget get _pageView => BlocBuilder(
    bloc: _bloc,
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
      _startAnimationTimer();
    } else if (isArrowDown) {
      _pageController.nextPage(duration: _animationDuration, curve: Curves.decelerate);
      _startAnimationTimer();
    }

    return isArrowUp || isArrowDown ? KeyEventResult.handled : KeyEventResult.ignored;
  }

  void _startAnimationTimer() {
    setState(() {
      _isAnimating = true;
    });

    Future.delayed(_animationDuration, () => setState(() {
      _isAnimating = false;
    }));
  }
}
