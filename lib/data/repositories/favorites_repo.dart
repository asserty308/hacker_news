import 'package:hacker_news/data/datasources/favorites_cache.dart';
import 'package:hacker_news/data/models/item_model.dart';

class FavoritesRepository {
  final _cache = FavoritesCache();

  Future<void> addStory(ItemModel item) => _cache.add(item);

  Future<void> removeStory(int id) => _cache.remove(id);

  bool contains(int id) => _cache.contains(id);

  List<ItemModel> getAll() => _cache.getAll();
}