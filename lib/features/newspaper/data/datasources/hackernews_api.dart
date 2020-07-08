import 'package:hacker_news/features/newspaper/data/models/item_model.dart';
import 'package:http/http.dart' as http;

class HackernewsApi {
  final String _baseUrl = 'https://hacker-news.firebaseio.com/v0';

  Future<dynamic> _getEndpoint(String endpoint) async {
    return await http.get('$_baseUrl/$endpoint.json');
  }

  Future<List<int>> _getTopstories() async {
    return await _getEndpoint('topstories');
  }

  Future<ItemModel> getItem(int id) async {
    final Map<String, dynamic> response = await _getEndpoint('item/$id');

    if (response == null) {
      return null;
    }

    return ItemModel.fromJSON(response);
  }

  Future<List<ItemModel>> getTopstories() async {
    final storyIds = await _getTopstories();

    final stories = <ItemModel>[];
    for (final id in storyIds) {
      final item = await getItem(id);
      stories.add(item);
    }

    return stories;
  }
}