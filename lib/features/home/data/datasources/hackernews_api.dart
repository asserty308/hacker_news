import 'dart:convert';

import 'package:hacker_news/core/utils/web_util.dart';
import 'package:hacker_news/features/home/data/models/item_model.dart';
import 'package:http/http.dart' as http;

class HackernewsApi {
  final _baseUrl = 'https://hacker-news.firebaseio.com/v0/';

  /// Calls [endpoint] on the hackernews api
  Future<T> _getEndpoint<T>(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl$endpoint.json'));
    return jsonDecode(response.body) as T;
  }

  /// The endpoint [topstories] returns the current 500 top stories ids.
  Future<List> getTopstories() => _getEndpoint<List>('topstories');

  /// The maxitem endpoint contains the latest news id.
  /// It can be used to iterate through proevious news.
  Future<int> getMaxItem() => _getEndpoint<int>('maxitem');

  /// The endpoint [item/id] returns a representation of [ItemModel].
  Future<JSONObject> getItem(int id) => _getEndpoint<JSONObject>('item/$id');
}
