import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:hacker_news/features/favorites/domain/use_case/export_favorites_use_case.dart';
import 'package:hacker_news/features/favorites/domain/use_case/get_favorites_use_case.dart';
import 'package:hacker_news/features/favorites/domain/use_case/import_favorites_use_case.dart';
import 'package:hacker_news/features/stories/data/models/item_model.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({
    required this.getFavoritesUseCase,
    required this.exportFavoritesUseCase,
    required this.importFavoritesUseCase,
  }) : super(FavoritesInitial()) {
    loadStories();
  }

  final GetFavoritesUseCase getFavoritesUseCase;
  final ExportFavoritesUseCase exportFavoritesUseCase;
  final ImportFavoritesUseCase importFavoritesUseCase;

  void loadStories() {
    emit(FavoritesLoading());

    try {
      final stories = getFavoritesUseCase.execute();
      emit(FavoritesLoaded(stories));
    } catch (e) {
      logger.e('FavoritesCubit::loadStories ERROR $e');
      emit(FavoritesError());
    }
  }

  Future<void> exportFavorites() async {
    try {
      final stories = getFavoritesUseCase.execute();
      if (stories.isEmpty) {
        emit(FavoritesOperationError('noFavoritesToExport'));
        loadStories();
        return;
      }

      final jsonContent = exportFavoritesUseCase.execute();
      emit(FavoritesExportSuccess(jsonContent));
      loadStories();
    } catch (e) {
      logger.e('FavoritesCubit::exportFavorites ERROR $e');
      emit(FavoritesOperationError('exportError'));
      loadStories();
    }
  }

  Future<void> importFavorites(String jsonContent) async {
    try {
      final count = await importFavoritesUseCase.execute(jsonContent);
      emit(FavoritesImportSuccess(count));
      loadStories();
    } catch (e) {
      logger.e('FavoritesCubit::importFavorites ERROR $e');
      emit(FavoritesOperationError('importError'));
      loadStories();
    }
  }
}
