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
  Future<List<int>> _getTopstoriesIds(int amount, {int start = 0}) async {
    final response = await _getEndpoint('topstories') as List;

    return response
      .map((id) => id as int)
      .skip(start)
      .take(amount)
      .toList();
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
    final futures = List.generate(amount, (index) => getItem(latestId - index));
    return Future.wait(futures);
  }

  /// Builds a list of [amount] [ItemModel] which represent the 
  /// current top stories published on hackernews. 
  /// Uses Future.wait to fetch all items concurrently. 
  /// This will reduce the overall time taken to fetch all the items.
  Future<List<ItemModel>> getTopstories(int amount, {int start = 0}) async {
    final storyIds = await _getTopstoriesIds(amount, start: start);

    final futures = storyIds
      .map(getItem)
      .toList();

    return Future.wait(futures);
  }
}