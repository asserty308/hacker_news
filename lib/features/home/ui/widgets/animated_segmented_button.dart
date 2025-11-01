import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:hacker_news/l10n/l10n.dart';

class AnimatedSegmentedButton extends StatelessWidget {
  const AnimatedSegmentedButton({
    super.key,
    required this.currentPage,
    required this.onPageSelected,
  });

  final double currentPage;
  final ValueChanged<int> onPageSelected;

  @override
  Widget build(BuildContext context) {
    const kButtonHeight = 40.0;
    const kButtonRadius = 20.0;
    const kPadding = 4.0;

    return Container(
      height: kButtonHeight,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(kButtonRadius),
      ),
      padding: const EdgeInsets.all(kPadding),
      child: Stack(
        children: [
          // Animated selection indicator
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
            left: _calculateIndicatorPosition(context, currentPage),
            top: 0,
            bottom: 0,
            child: Container(
              width: _calculateButtonWidth(context),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(kButtonRadius - kPadding),
              ),
            ),
          ),
          // Buttons row
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildButton(context, context.l10n.topStories, 0, currentPage),
              _buildButton(context, context.l10n.favorites, 1, currentPage),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String label,
    int index,
    double currentPage,
  ) {
    final isSelected = (currentPage - index).abs() < 0.5;

    return GestureDetector(
      onTap: () => onPageSelected(index),
      child: Container(
        width: _calculateButtonWidth(context),
        alignment: Alignment.center,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: context.textTheme.labelLarge!.copyWith(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
          child: Text(label),
        ),
      ),
    );
  }

  double _calculateButtonWidth(BuildContext context) {
    // Calculate based on screen width with padding
    const kMinButtonWidth = 120.0;
    const kMaxButtonWidth = 160.0;
    const kTotalPadding = 8.0; // 4.0 padding on each side

    final availableWidth =
        MediaQuery.of(context).size.width -
        kTotalPadding -
        32; // 32 for margins
    final buttonWidth = (availableWidth / 2).clamp(
      kMinButtonWidth,
      kMaxButtonWidth,
    );

    return buttonWidth;
  }

  double _calculateIndicatorPosition(BuildContext context, double currentPage) {
    final buttonWidth = _calculateButtonWidth(context);
    return currentPage * buttonWidth;
  }
}
