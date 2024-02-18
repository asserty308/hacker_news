import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RemoveFavoriteButton extends StatefulWidget {
  const RemoveFavoriteButton({
    super.key,
    required this.onTap,
    this.playAnimation = true,
  });

  final VoidCallback onTap;
  final bool playAnimation;

  @override
  State<RemoveFavoriteButton> createState() => _RemoveFavoriteButtonState();
}

class _RemoveFavoriteButtonState extends State<RemoveFavoriteButton> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.9,
      duration: const Duration(milliseconds: 250),
      value: widget.playAnimation ? 0.9 : 1.0,
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
  Widget build(BuildContext context) => InkWell(
    onTap: () => widget.onTap(),
    child: SizedBox.fromSize(
      size: const Size(40, 40),
      child: Transform.scale(
        scale: 5,
        child: Lottie.asset(
          'assets/favorite_white.json',
          controller: _controller,
          renderCache: RenderCache.raster,
        ),
      ),
    ),
  );
}