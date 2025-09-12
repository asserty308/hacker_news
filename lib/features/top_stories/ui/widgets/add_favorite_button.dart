import 'package:flutter/material.dart';
import 'package:hacker_news/l10n/l10n.dart';
import 'package:lottie/lottie.dart';

class AddFavoriteButton extends StatefulWidget {
  const AddFavoriteButton({
    super.key,
    required this.onTap,
    this.playAnimation = true,
  });

  final VoidCallback onTap;
  final bool playAnimation;

  @override
  State<AddFavoriteButton> createState() => _AddFavoriteButtonState();
}

class _AddFavoriteButtonState extends State<AddFavoriteButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.38,
      upperBound: 0.9,
      duration: const Duration(milliseconds: 750),
      value: widget.playAnimation ? 0.38 : 0.9,
    );

    if (widget.playAnimation) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Semantics(
    label: context.l10n.accessibilityRemoveFromFavorites,
    button: true,
    child: InkWell(
      onTap: () => widget.onTap(),
      child: SizedBox.fromSize(
        size: const Size(40, 40),
        child: Transform.scale(
          scale: 5,
          child: Lottie.asset(
            'assets/favorite${Theme.of(context).colorScheme.brightness == Brightness.dark ? '_white' : ''}.json',
            controller: _controller,
            renderCache: RenderCache.raster,
          ),
        ),
      ),
    ),
  );
}
