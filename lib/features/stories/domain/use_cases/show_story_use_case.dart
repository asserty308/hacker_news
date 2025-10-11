import 'package:flutter_core/flutter_core.dart';
import 'package:hacker_news/features/stories/data/models/item_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowStoryUseCase {
  Future<void> execute(ItemModel story) async {
    logger.i('Opening story: ${story.realUrl}');
    launchUrl(story.realUrl);
  }
}
