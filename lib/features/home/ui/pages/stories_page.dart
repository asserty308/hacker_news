import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/features/home/ui/widgets/favorites_listview.dart';
import 'package:hacker_news/features/home/constants.dart';
import 'package:hacker_news/features/home/di/providers.dart';
import 'package:hacker_news/features/home/ui/widgets/animated_segmented_button.dart';
import 'package:hacker_news/features/home/ui/widgets/topstories_listview.dart';

class StoriesPage extends ConsumerStatefulWidget {
  const StoriesPage({super.key});

  @override
  ConsumerState<StoriesPage> createState() => _TopStoriesPageState();
}

class _TopStoriesPageState extends AppConsumerState<StoriesPage> {
  late final _bloc = ref.read(topStoriesCubitProvider);

  final _verticalPageController = PageController();
  final _horizontalPageController = PageController();

  var _isAnimating = false;
  var _currentHorizontalPage = 0.0;

  @override
  void initState() {
    super.initState();
    _verticalPageController.addListener(_verticalPageListener);
    _horizontalPageController.addListener(_horizontalPageListener);
  }

  @override
  void dispose() {
    _verticalPageController.removeListener(_verticalPageListener);
    _verticalPageController.dispose();
    _horizontalPageController.removeListener(_horizontalPageListener);
    _horizontalPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: _keyboardListener);

  Widget get _keyboardListener => CallbackShortcuts(
    bindings: {
      const SingleActivator(LogicalKeyboardKey.arrowUp): () =>
          _handleArrowEvents(true),
      const SingleActivator(LogicalKeyboardKey.arrowDown): () =>
          _handleArrowEvents(false),
      const SingleActivator(LogicalKeyboardKey.arrowLeft): () =>
          _handleHorizontalSwipe(true),
      const SingleActivator(LogicalKeyboardKey.arrowRight): () =>
          _handleHorizontalSwipe(false),
    },
    child: Focus(autofocus: true, child: _body),
  );

  Widget get _body => Stack(
    children: [
      _horizontalPageView,
      Align(
        alignment: Alignment.topCenter,
        child: IgnorePointer(
          child: Container(
            height: context.mediaSize.height * 0.3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(
                    context,
                  ).scaffoldBackgroundColor.withValues(alpha: 0.5),
                  Theme.of(
                    context,
                  ).scaffoldBackgroundColor.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: IgnorePointer(
          child: Container(
            height: context.mediaSize.height * 0.3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(
                    context,
                  ).scaffoldBackgroundColor.withValues(alpha: 0.5),
                  Theme.of(
                    context,
                  ).scaffoldBackgroundColor.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: AnimatedSegmentedButton(
              currentPage: _currentHorizontalPage,
              onPageSelected: _handlePageSelected,
            ),
          ),
        ),
      ),
    ],
  );

  Widget get _horizontalPageView => PageView(
    controller: _horizontalPageController,
    children: [_topStoriesView, _favoritesView],
  );

  Widget get _topStoriesView => TopstoriesListView(
    pageController: _verticalPageController,
    topStoriesCubit: _bloc,
  );

  Widget get _favoritesView => const FavoritesListView();

  void _handleArrowEvents(bool isArrowUp) {
    if (_isAnimating) {
      logger.i('Do not scroll when animating');
      return;
    }

    if (isArrowUp) {
      _verticalPageController.previousPage(
        duration: kPageAnimationDuration,
        curve: Curves.decelerate,
      );
    } else {
      _verticalPageController.nextPage(
        duration: kPageAnimationDuration,
        curve: Curves.decelerate,
      );
    }
  }

  void _handleHorizontalSwipe(bool isLeft) {
    if (isLeft) {
      _horizontalPageController.previousPage(
        duration: kPageAnimationDuration,
        curve: Curves.easeInOut,
      );
    } else {
      _horizontalPageController.nextPage(
        duration: kPageAnimationDuration,
        curve: Curves.easeInOut,
      );
    }
  }

  void _handlePageSelected(int page) {
    _horizontalPageController.animateToPage(
      page,
      duration: kPageAnimationDuration,
      curve: Curves.easeInOut,
    );
  }

  /// Called multiple times during a vertical page animation.
  void _verticalPageListener() {
    final currentPage = _verticalPageController.page ?? 0.0;
    final wasAnimating = _isAnimating;
    final isAnimating = currentPage % 1.0 != 0.0;

    if (wasAnimating != isAnimating) {
      setState(() {
        _isAnimating = isAnimating;
      });
    }

    if (!isAnimating) {
      _onVerticalPageChanged(currentPage.toInt());
    }
  }

  /// Called multiple times during a horizontal page animation.
  void _horizontalPageListener() {
    final currentPage = _horizontalPageController.page ?? 0.0;

    if (_currentHorizontalPage != currentPage) {
      setState(() {
        _currentHorizontalPage = currentPage;
      });
    }
  }

  /// Triggered on page changes and adds the stories the user has already seen to the history cache
  void _onVerticalPageChanged(int page) {
    if (page == _bloc.storyCount - 1) {
      logger.i('Loading next bunch of stories');
      _bloc.loadNextStories();
    }
  }
}
