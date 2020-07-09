import 'package:hacker_news/features/newspaper/data/datasources/hackernews_api.dart';
import 'package:hacker_news/features/newspaper/data/models/item_model.dart';

class HackernewsRepository {
  final _api = HackernewsApi();

  Future<List<ItemModel>> getLatestStories(int amount) async {
    return _api.getLatestStories(amount);
  }

  Future<List<ItemModel>> getTopstories() async {
    return _api.getTopstories();
  }
}