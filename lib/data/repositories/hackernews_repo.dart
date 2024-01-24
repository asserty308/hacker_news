import 'package:hacker_news/data/datasources/hackernews_api.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/data/repositories/story_history_repo.dart';

final hackernewsRepo = HackernewsRepo();

class HackernewsRepo {
  final _api = HackernewsApi();

  Future<List<int>> getTopstoriesIds(int amount, {int start = 0}) async {
    final all = await _api.getTopstoriesIds(amount, start: start);
    // TODO: Fetch more when response is empty
    return all
      .where((e) => !historyRepo.allIds.contains(e))
      .toList();
  }

  Future<ItemModel> getItem(int id) async {
    return _api.getItem(id);
  }

  Future<List<ItemModel>> getLatestStories(int amount) async {
    return _api.getLatestStories(amount);
  }

  Future<List<ItemModel>> getTopstories(int amount, {int start = 0}) async {
    return _api.getTopstories(amount, start: start);
  }
}