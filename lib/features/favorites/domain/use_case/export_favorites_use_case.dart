import 'dart:convert';

import 'package:hacker_news/features/favorites/data/repositories/favorites_repo.dart';

class ExportFavoritesUseCase {
  ExportFavoritesUseCase({required this.repository});

  final FavoritesRepository repository;

  String execute() {
    final favorites = repository.getAll();
    final jsonList = favorites.map((item) => item.toJSON()).toList();
    return jsonEncode(jsonList);
  }
}
