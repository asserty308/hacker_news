import 'package:hacker_news/data/datasources/hackernews_api.dart';
import 'package:hacker_news/data/models/item_model.dart';

final hackernewsRepo = HackernewsRepo();

class HackernewsRepo {
  final _api = HackernewsApi();

  Future<List<ItemModel>> getLatestStories(int amount) async {
    return _api.getLatestStories(amount);
  }

  Future<List<ItemModel>> getTopstories(int amount, {int start = 0}) async {
    return _api.getTopstories(amount, start: start);
  }
}