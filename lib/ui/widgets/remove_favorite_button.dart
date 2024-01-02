import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RemoveFavoriteButton extends StatefulWidget {
  const RemoveFavoriteButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

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
    );

    _controller.forward();
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