import 'dart:convert';

import 'package:flutter_core/flutter_core.dart';
import 'package:hacker_news/features/favorites/data/repositories/favorites_repo.dart';
import 'package:hacker_news/features/stories/data/models/item_model.dart';

class ImportFavoritesUseCase {
  ImportFavoritesUseCase({required this.repository});

  final FavoritesRepository repository;

  Future<int> execute(String jsonString) async {
    try {
      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      int count = 0;

      for (final json in jsonList) {
        final item = ItemModel.fromJSON(Map<String, dynamic>.from(json));
        if (!repository.contains(item.id)) {
          await repository.addStory(item);
          count++;
        }
      }

      return count;
    } catch (e, stackTrace) {
      logger.e('Import error: $e', error: e, stackTrace: stackTrace);
      throw Exception('Invalid import file format: $e');
    }
  }
}
