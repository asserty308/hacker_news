import 'package:hacker_news/data/models/item_model.dart';
import 'package:hive/hive.dart';

// TODO: Find a new database as hive becomes unsupported 
//   - candidates: 
//     - sembast, 
//     - cloud firestore (sync with max 1gb across all projects), 
//     - isar (hive successor)
class FavoritesDatasource {
  Future<Box> initBox() async {
    return await Hive.openBox('favorites');
  }

  /// Adds a story to the favorites box.
  void add(ItemModel item) async {
    final _box = await initBox();
    _box.put(item.id, item.toMap());
  }

  /// Removes the story with the given [id] from the favorites box.
  void remove(int id) async {
    final _box = await initBox();
    _box.delete(id);
  }
  
  Future<bool> contains(int id) async {
    final _box = await initBox();
    return _box.containsKey(id);
  }

  Future<List<ItemModel>> getAll() async {
    final _box = await initBox();
    final items = <ItemModel>[];

    for (int i = 0; i < _box.length; i++) {
      items.add(ItemModel.fromJSON(_box.getAt(i)));
    }

    return items;
  }

  
}