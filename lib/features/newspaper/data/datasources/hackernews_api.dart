import 'package:hacker_news/features/newspaper/data/models/item_model.dart';
import 'package:http/http.dart' as http;

class HackernewsApi {
  final String _baseUrl = 'https://hacker-news.firebaseio.com/v0';

  Future<dynamic> _getEndpoint(String endpoint) async {
    return await http.get('$_baseUrl/$endpoint.json');
  }

  /// The endpoint [topstories] returns an array of ids.
  Future<List<int>> _getTopstoriesIds() async {
    return await _getEndpoint('topstories');
  }

  Future<int> getLatestStoryId() async {
    return await _getEndpoint('maxitem');
  }

  /// The endpoint [item/id] returns a representation of [ItemModel].
  Future<ItemModel> getItem(int id) async {
    final Map<String, dynamic> response = await _getEndpoint('item/$id');

    if (response == null) {
      return null;
    }

    return ItemModel.fromJSON(response);
  }

  Future<List<ItemModel>> getLatestStories(int amount) async {
    final latestId = await getLatestStoryId();
    final stories = <ItemModel>[];

    for (int i = 0; i < amount; i++) {
      stories.add(await getItem(latestId));
    }

    return stories;
  }

  Future<List<ItemModel>> getTopstories() async {
    final storyIds = await _getTopstoriesIds();

    final stories = <ItemModel>[];
    for (final id in storyIds) {
      final item = await getItem(id);
      stories.add(item);
    }

    return stories;
  }
}