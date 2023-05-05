import 'package:hacker_news/data/models/item_model.dart';
import 'package:hive/hive.dart';

class FavoritesCache {
  final _box = Hive.box('favorites');

  /// Adds a story to the favorites box.
  void add(ItemModel item) {
    _box.put(item.id, item.toMap());
  }

  /// Removes the story with the given [id] from the favorites box.
  void remove(int id) {
    _box.delete(id);
  }
  
  bool contains(int id) {
    return _box.containsKey(id);
  }

  List<ItemModel> getAll() {
    return _box.values
      .map((e) => ItemModel.fromJSON(Map<String, dynamic>.from(e)))
      .toList();
  }
}
