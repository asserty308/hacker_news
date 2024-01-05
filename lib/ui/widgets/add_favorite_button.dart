import 'package:flutter/material.dart';
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

class _AddFavoriteButtonState extends State<AddFavoriteButton> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.38,
      upperBound: 0.9,
      duration: const Duration(milliseconds: 750),
      value: widget.playAnimation ? 0.38 : 0.9
    );

    if (widget.playAnimation) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: () => widget.onTap(),
    icon: Transform.scale(
      scale: 3,
      child: Lottie.asset(
        'assets/favorite_white.json',
        controller: _controller,
      ),
    ),
  );
}