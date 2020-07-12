import 'package:hacker_news/data/models/item_model.dart';
import 'package:hive/hive.dart';

class FavoritesDatasource {
  final _box = Hive.box('favorites');

  /// Adds a story to the favorites box.
  void addStory(ItemModel item) {
    _box.put(item.id, item.toMap());
  }

  /// Removes the story with the given [id] from the favorites box.
  void removeStory(int id) {
    _box.delete(id);
  }

  List<ItemModel> getAll() {
    final items = <ItemModel>[];

    for (int i = 0; i < _box.length; i++) {
      items.add(ItemModel.fromJSON(_box.getAt(i)));
    }

    return items;
  }
}