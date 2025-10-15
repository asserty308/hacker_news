import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:hacker_news/core/navigation/extensions/navigation_context.dart';
import 'package:hacker_news/l10n/l10n.dart';

const double kFabSize = 56.0;
const double kMenuItemSpacing = 72.0;

class FABMenu extends StatefulWidget {
  const FABMenu({super.key});

  @override
  State<FABMenu> createState() => _FABMenuState();
}

class _FABMenuState extends State<FABMenu> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  bool _isExpanded = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _animation,
    builder: (context, child) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildMenuItem(
          icon: Icons.favorite,
          label: context.l10n.favorites,
          onTap: () {
            context.pushToFavorites();
            _toggleMenu();
          },
          offset: 2,
        ),
        _buildMenuItem(
          icon: Icons.settings,
          label: context.l10n.settings,
          onTap: () {
            context.pushToSettings();
            _toggleMenu();
          },
          offset: 1,
        ),
        _infoButton,
      ],
    ),
  );

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required int offset,
  }) {
    final double translation = offset * kMenuItemSpacing;
    final double animatedTranslation = translation * (1 - _animation.value);

    return Transform.translate(
      offset: Offset(animatedTranslation, 0),
      child: Opacity(
        opacity: _animation.value,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                color: context.colorScheme.surface,
                elevation: 2,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Text(label, style: context.textTheme.labelLarge),
                ),
              ),
              hGap8,
              InkWell(onTap: onTap, child: Icon(icon)),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _infoButton => InkWell(
    onTap: _toggleMenu,
    focusColor: Colors.transparent,
    splashColor: Colors.transparent,
    hoverColor: Colors.transparent,
    child: AnimatedRotation(
      turns: _isExpanded ? 0 : -0.125, // 45 degrees when expanded
      duration: const Duration(milliseconds: 300),
      child: Icon(Icons.close),
    ),
  );
}
