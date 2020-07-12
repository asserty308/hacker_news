import 'package:hacker_news/data/datasources/hackernews_api.dart';
import 'package:hacker_news/data/models/item_model.dart';

final globalHackernewsRepo = HackernewsRepository();

class HackernewsRepository {
  final _api = HackernewsApi();

  Future<List<ItemModel>> getLatestStories(int amount) async {
    return _api.getLatestStories(amount);
  }

  Future<List<ItemModel>> getTopstories(int amount) async {
    return _api.getTopstories(amount);
  }
}