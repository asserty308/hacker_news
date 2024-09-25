import 'package:hacker_news/data/models/item_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowStoryUseCase {
  Future<void> execute(ItemModel story) async {
    launchUrl(story.realUrl);
  }
}