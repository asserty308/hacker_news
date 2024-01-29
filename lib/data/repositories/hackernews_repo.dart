import 'package:hacker_news/data/datasources/hackernews_api.dart';
import 'package:hacker_news/data/models/item_model.dart';

class HackernewsRepo {
  final _api = HackernewsApi();

  Future<List<int>> getTopstoriesIds(int amount, {int start = 0}) => _api.getTopstoriesIds(amount, start: start);

  Future<ItemModel> getItem(int id) => _api.getItem(id);

  Future<List<ItemModel>> getLatestStories(int amount) => _api.getLatestStories(amount);

  Future<List<ItemModel>> getTopstories(int amount, {int start = 0}) => _api.getTopstories(amount, start: start);
}