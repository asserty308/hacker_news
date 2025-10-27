import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/features/favorites/di/providers.dart';
import 'package:hacker_news/features/favorites/ui/blocs/favorites/favorites_cubit.dart';
import 'package:hacker_news/features/stories/ui/widgets/stories_listview.dart';
import 'package:hacker_news/l10n/l10n.dart';
import 'package:share_plus/share_plus.dart';

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends AppConsumerState<FavoritesPage> {
  late final _bloc = ref.read(favoritesCubitProvider);

  @override
  void onUIReady() {
    super.onUIReady();

    _bloc.loadStories();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<FavoritesCubit, FavoritesState>(
        bloc: _bloc,
        listener: _handleStateChanges,
        child: Scaffold(
          body: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            restorationId: 'favorites_list',
            slivers: [
              SliverAppBar(
                title: Text(context.l10n.favorites),
                floating: true,
                actions: _buildActions(context),
              ),
              _body,
            ],
          ),
        ),
      );

  List<Widget> _buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.upload_outlined),
      tooltip: context.l10n.exportFavorites,
      onPressed: _handleExport,
    ),
    IconButton(
      icon: const Icon(Icons.download_outlined),
      tooltip: context.l10n.importFavorites,
      onPressed: _handleImport,
    ),
  ];

  void _handleStateChanges(BuildContext context, FavoritesState state) {
    if (state is FavoritesExportSuccess) {
      _saveToFile(context, state.jsonContent);
    } else if (state is FavoritesImportSuccess) {
      _showSnackBar(context, context.l10n.importSuccess(state.count));
    } else if (state is FavoritesOperationError) {
      _showSnackBar(
        context,
        _getErrorMessage(context, state.message),
        isError: true,
      );
    }
  }

  String _getErrorMessage(BuildContext context, String key) {
    switch (key) {
      case 'noFavoritesToExport':
        return context.l10n.noFavoritesToExport;
      case 'exportError':
        return context.l10n.exportError;
      case 'importError':
        return context.l10n.importError;
      default:
        return context.l10n.unexpectedError;
    }
  }

  void _showSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? context.colorScheme.error : null,
      ),
    );
  }

  Future<void> _saveToFile(BuildContext context, String jsonContent) async {
    try {
      // Properly encode as UTF-8
      final bytes = utf8.encode(jsonContent);

      // Share the file using share_plus
      final xFile = XFile.fromData(
        Uint8List.fromList(bytes),
        name: 'favorites.json',
        mimeType: 'application/json',
      );

      await SharePlus.instance.share(ShareParams(files: [xFile]));

      if (context.mounted) {
        _showSnackBar(context, context.l10n.exportSuccess);
      }
    } catch (e) {
      logger.e('Error exporting favorites', error: e);
      if (context.mounted) {
        _showSnackBar(context, context.l10n.exportError, isError: true);
      }
    }
  }

  Future<void> _handleExport() async {
    await _bloc.exportFavorites();
  }

  Future<void> _handleImport() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        dialogTitle: context.l10n.importFavorites,
        withData: true, // Important for web to get bytes
      );

      if (result != null && result.files.single.bytes != null) {
        // Properly decode UTF-8 bytes to string
        final jsonContent = utf8.decode(result.files.single.bytes!);
        await _bloc.importFavorites(jsonContent);
      }
    } catch (e) {
      logger.e('Error importing favorites', error: e);
      if (mounted) {
        _showSnackBar(context, context.l10n.importError, isError: true);
      }
    }
  }

  Widget get _body => BlocBuilder<FavoritesCubit, FavoritesState>(
    bloc: _bloc,
    builder: (context, state) {
      if (state is FavoritesLoaded) {
        if (state.stories.isEmpty) {
          return _emptyListHint(context);
        }

        return SliverStoriesListView(
          stories: state.stories,
          storageKey: 1,
          onFavoriteRemoved: _bloc.loadStories,
        );
      }

      if (state is FavoritesError) {
        return _errorWidget(context);
      }

      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                context.l10n.favoritesLoading,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      );
    },
  );

  Widget _emptyListHint(BuildContext context) => SliverFillRemaining(
    child: Center(child: Text(context.l10n.emptyFavoritesHint)),
  );

  Widget _errorWidget(BuildContext context) => SliverFillRemaining(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: context.colorScheme.error),
          const SizedBox(height: 16),
          Text(
            context.l10n.errorLoadingFavorites,
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _bloc.loadStories,
            child: Text(context.l10n.tryAgain),
          ),
        ],
      ),
    ),
  );
}
