import 'package:hacker_news/features/favorites/data/repositories/favorites_repo.dart';
import 'package:hacker_news/features/home/data/models/item_model.dart';

class GetFavoritesUseCase {
  GetFavoritesUseCase({required this.favoritesRepository});

  final FavoritesRepository favoritesRepository;

  List<ItemModel> execute() {
    final all = favoritesRepository.getAll();
    all.sort((a, b) => b.id.compareTo(a.id));
    return all;
  }
}
