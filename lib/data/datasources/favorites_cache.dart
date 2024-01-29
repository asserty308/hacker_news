import 'package:hacker_news/data/models/item_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// The local datasource for stories marked as favorites
class FavoritesCache {
  static const boxName = 'favorites';

  final _box = Hive.box(boxName);

  /// Adds a story to the favorites box.
  Future<void> add(ItemModel item) => _box.put(item.id, item.toJSON());

  /// Removes the story with the given [id] from the favorites box.
  Future<void> remove(int id) => _box.delete(id);
  
  /// Check whether the story with the given [id] is inside the favorites box.
  bool contains(int id) => _box.containsKey(id);

  /// Returns all entries inside the favorites box.
  List<ItemModel> getAll() => _box.values
    .map((e) => ItemModel.fromJSON(Map<String, dynamic>.from(e)))
    .toList();
}
