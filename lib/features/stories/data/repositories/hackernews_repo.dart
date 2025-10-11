import 'package:hacker_news/core/utils/web_util.dart';
import 'package:hacker_news/features/stories/data/datasources/hackernews_api.dart';
import 'package:hacker_news/features/stories/data/models/item_model.dart';

class HackernewsRepo {
  HackernewsRepo({required this.api});

  final HackernewsApi api;

  Future<List<int>> getTopstories() async {
    final response = await api.getTopstories();
    return response.cast<int>();
  }

  Future<ItemModel> getItem(int id) async {
    final response = await api.getItem(id);
    return _parseItem(response);
  }

  ItemModel _parseItem(JSONObject json) => ItemModel.fromJSON(json);

  List<ItemModel> parseItems(List<JSONObject> jsonList) =>
      jsonList.map(_parseItem).toList();
}
