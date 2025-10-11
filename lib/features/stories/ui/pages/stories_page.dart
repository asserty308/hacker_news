import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/core/navigation/extensions/navigation_context.dart';
import 'package:hacker_news/features/stories/constants.dart';
import 'package:hacker_news/features/stories/di/providers.dart';
import 'package:hacker_news/features/stories/ui/widgets/topstories_listview.dart';
import 'package:hacker_news/l10n/l10n.dart';

class TopStoriesPage extends ConsumerStatefulWidget {
  const TopStoriesPage({super.key});

  @override
  ConsumerState<TopStoriesPage> createState() => _TopStoriesPageState();
}

class _TopStoriesPageState extends AppConsumerState<TopStoriesPage> {
  late final _bloc = ref.read(topStoriesCubitProvider);

  final _pageController = PageController();

  var _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageListener);
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(body: _keyboardListener, floatingActionButton: _infoButton);

  Widget get _keyboardListener => CallbackShortcuts(
    bindings: {
      const SingleActivator(LogicalKeyboardKey.arrowUp): () =>
          _handleArrowEvents(true),
      const SingleActivator(LogicalKeyboardKey.arrowDown): () =>
          _handleArrowEvents(false),
    },
    child: Focus(autofocus: true, child: _body),
  );

  Widget get _body => TopstoriesListview(
    pageController: _pageController,
    topStoriesCubit: _bloc,
  );

  Widget get _infoButton => Padding(
    padding: const EdgeInsets.all(16),
    child: Align(
      alignment: Alignment.bottomRight,
      child: Semantics(
        label: context.l10n.accessibilitySettings,
        button: true,
        child: InkWell(
          onTap: () => context.pushToSettings(),
          child: const Icon(Icons.info_outline, size: 32),
        ),
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
        duration: kPageAnimationDuration,
        curve: Curves.decelerate,
      );
    } else {
      _pageController.nextPage(
        duration: kPageAnimationDuration,
        curve: Curves.decelerate,
      );
    }
  }

  /// Called multiple times during an page animation.
  void _pageListener() {
    final currentPage = _pageController.page ?? 0.0;
    final wasAnimating = _isAnimating;
    final isAnimating = currentPage % 1.0 != 0.0;

    if (wasAnimating != isAnimating) {
      setState(() {
        _isAnimating = isAnimating;
      });
    }

    if (!isAnimating) {
      _onPageChanged(currentPage.toInt());
    }
  }

  /// Triggered on page changes and adds the stories the user has already seen to the history cache
  void _onPageChanged(int page) {
    if (page == _bloc.storyCount - 1) {
      logger.i('Loading next bunch of stories');
      _bloc.loadNextStories();
    }
  }
}
