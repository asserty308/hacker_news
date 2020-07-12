import 'package:hacker_news/data/datasources/favorites_datasource.dart';
import 'package:hacker_news/data/models/item_model.dart';

final globalFavoritesRepository = FavoritesRepository();

class FavoritesRepository {
  final _datasource = FavoritesDatasource();

  void addStory(ItemModel item) {
    _datasource.addStory(item);
  }

  void removeStory(int id) {
    _datasource.removeStory(id);
  }

  List<ItemModel> getAll() {
    return _datasource.getAll();
  }
}