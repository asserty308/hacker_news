import 'package:hacker_news/features/favorites/data/datasources/favorites_cache.dart';
import 'package:hacker_news/features/home/data/models/item_model.dart';

class FavoritesRepository {
  FavoritesRepository({required this.cache});

  final FavoritesCache cache;

  Future<void> addStory(ItemModel item) async {
    await cache.add(item);
  }

  Future<void> removeStory(int id) => cache.remove(id);

  bool contains(int id) => cache.contains(id);

  List<ItemModel> getAll() => cache.allItems
      .map((e) => ItemModel.fromJSON(Map<String, dynamic>.from(e)))
      .toList();

  Future<void> importStories(List<ItemModel> items) async {
    for (final item in items) {
      await cache.add(item);
    }
  }

  Future<void> clearAll() async {
    final allItems = getAll();
    for (final item in allItems) {
      await cache.remove(item.id);
    }
  }
}
