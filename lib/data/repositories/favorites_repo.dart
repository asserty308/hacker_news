import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:hacker_news/data/datasources/favorites_api.dart';
import 'package:hacker_news/data/datasources/favorites_cache.dart';
import 'package:hacker_news/data/models/item_model.dart';

class FavoritesRepository {
  FavoritesRepository({
    required this.cache, 
    required this.api,
    required this.account,
  });

  final FavoritesCache cache;
  final FavoritesApi api;
  final Account account;

  Future<void> addStory(ItemModel item) async {
    User? user;

    try {
      user = await account.get();
    } catch (e) {
      log('Error fetching user', error: e);
    }

    await Future.wait([
      cache.add(item),
      if (user?.$id.isNotEmpty ?? false)
        api.createEntry(userId: user!.$id, itemId: item.id),
    ]);
  }

  Future<void> removeStory(int id) => cache.remove(id);

  bool contains(int id) => cache.contains(id);

  List<ItemModel> getAll() => cache.getAll();
}