import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:hacker_news/core/navigation/extensions/navigation_context.dart';
import 'package:hacker_news/l10n/l10n.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.grey),
          vGap16,
          Text(
            context.l10n.pageNotFoundTitle,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          vGap8,
          Text(context.l10n.pageNotFoundMessage),
          vGap16,
          TextButton(
            onPressed: () => context.goToHome(),
            child: Text(context.l10n.showTopStories),
          ),
        ],
      ),
    ),
  );
}
