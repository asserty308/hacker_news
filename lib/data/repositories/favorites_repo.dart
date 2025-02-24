import 'package:hacker_news/data/datasources/favorites_cache.dart';
import 'package:hacker_news/data/models/item_model.dart';

class FavoritesRepository {
  FavoritesRepository({required this.cache});

  final FavoritesCache cache;

  Future<void> addStory(ItemModel item) async {
    await cache.add(item);
  }

  Future<void> removeStory(int id) => cache.remove(id);

  bool contains(int id) => cache.contains(id);

  List<ItemModel> getAll() => cache.getAll();
}
