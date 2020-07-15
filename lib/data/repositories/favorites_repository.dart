import 'package:hacker_news/data/datasources/favorites_datasource.dart';
import 'package:hacker_news/data/models/item_model.dart';

final globalFavoritesRepository = FavoritesRepository();

class FavoritesRepository {
  final _datasource = FavoritesDatasource();

  void addStory(ItemModel item) {
    _datasource.add(item);
  }

  void removeStory(int id) {
    _datasource.remove(id);
  }

  Future<bool> contains(int id) async {
    return await _datasource.contains(id);
  }

  Future<List<ItemModel>> getAll() async {
    return await _datasource.getAll();
  }
}