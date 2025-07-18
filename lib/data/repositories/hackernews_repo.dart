import 'package:hacker_news/data/datasources/hackernews_api.dart';
import 'package:hacker_news/data/models/item_model.dart';

class HackernewsRepo {
  HackernewsRepo({required this.api});

  final HackernewsApi api;

  Future<List<int>> getTopstoriesIds(int amount, {int start = 0}) =>
      api.getTopstoriesIds(amount, start: start);

  Future<ItemModel> getItem(int id) => api.getItem(id);

  Future<List<ItemModel>> getLatestStories(int amount) =>
      api.getLatestStories(amount);

  Future<List<ItemModel>> getTopstories(int amount, {int start = 0}) =>
      api.getTopstories(amount, start: start);
}
