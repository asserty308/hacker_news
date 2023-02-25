import 'dart:convert';

import 'package:hacker_news/data/models/item_model.dart';
import 'package:http/http.dart' as http;

class HackernewsApi {
  final _baseUrl = 'https://hacker-news.firebaseio.com/v0/';

  /// Calls [endpoint] on the hackernews api
  Future<dynamic> _getEndpoint(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl$endpoint.json'));
    return jsonDecode(response.body);
  }

  /// The endpoint [topstories] returns an array of ids.
  Future<List<int>> _getTopstoriesIds(int amount) async {
    final response = await _getEndpoint('topstories');

    final ids = <int>[];

    for (final id in response) {
      ids.add(id);
    }

    return ids.getRange(0, amount).toList();
  }

  /// The maxitem endpoint contains the latest news id. 
  /// It can be used to iterate through proevious news.
  Future<int> getLatestStoryId() async {
    return await _getEndpoint('maxitem');
  }

  /// The endpoint [item/id] returns a representation of [ItemModel].
  Future<ItemModel> getItem(int id) async {
    final response = await _getEndpoint('item/$id');
    return ItemModel.fromJSON(response);
  }

  /// Builds a list of [amount] [ItemModel] which represent the 
  /// latest stories published on hackernews. 
  Future<List<ItemModel>> getLatestStories(int amount) async {
    final latestId = await getLatestStoryId();
    final stories = <ItemModel>[];

    for (int i = 0; i < amount; i++) {
      stories.add(await getItem(latestId - i));
    }

    return stories;
  }

  /// Builds a list of [amount] [ItemModel] which represent the 
  /// current top stories published on hackernews. 
  Future<List<ItemModel>> getTopstories(int amount) async {
    final storyIds = await _getTopstoriesIds(amount);

    final stories = Stream.fromIterable(storyIds)
      .asyncMap(getItem)
      .toList();

  return stories;
  }
}