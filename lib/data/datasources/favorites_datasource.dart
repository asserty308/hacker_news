import 'package:hacker_news/data/models/item_model.dart';
import 'package:hive/hive.dart';

// TODO: Find a new database as hive becomes unsupported 
//   - candidates: 
//     - sembast, 
//     - cloud firestore (sync with max 1gb across all projects), 
//     - isar (hive successor)
class FavoritesDatasource {
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
    final items = <ItemModel>[];

    for (int i = 0; i < _box.length; i++) {
      final entry = Map<String, dynamic>.from(_box.getAt(i));
      items.add(ItemModel.fromJSON(entry));
    }

    return items;
  }
}
