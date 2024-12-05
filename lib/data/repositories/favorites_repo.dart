import 'package:hacker_news/data/datasources/favorites_api.dart';
import 'package:hacker_news/data/datasources/favorites_cache.dart';
import 'package:hacker_news/data/models/item_model.dart';

class FavoritesRepository {
  FavoritesRepository({
    required this.cache, 
    required this.api,
  });

  final FavoritesCache cache;
  final FavoritesApi api;

  Future<void> addStory(ItemModel item) async {
    await Future.wait([
      cache.add(item),
      api.createEntry(userId: 'test-user', itemId: item.id),
    ]);
  }

  Future<void> removeStory(int id) => cache.remove(id);

  bool contains(int id) => cache.contains(id);

  List<ItemModel> getAll() => cache.getAll();
}