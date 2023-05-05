import 'package:hacker_news/data/datasources/favorites_cache.dart';
import 'package:hacker_news/data/models/item_model.dart';

final favoritesRepository = FavoritesRepository();

class FavoritesRepository {
  final _datasource = FavoritesCache();

  void addStory(ItemModel item) {
    _datasource.add(item);
  }

  void removeStory(int id) {
    _datasource.remove(id);
  }

  bool contains(int id) {
    return _datasource.contains(id);
  }

  List<ItemModel> getAll() {
    return _datasource.getAll();
  }
}