import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:hacker_news/config/app_config.dart';

class FavoritesApi {
  FavoritesApi({required this.databases});

  final Databases databases;

  Future<Document?> createEntry({
    required String userId,
    required int itemId,
  }) async {
    try {
      final data = {
        'user_id': userId,
        'item_id': itemId,
      };
      
      return await databases.createDocument(
          databaseId: kAppwriteDatabaseID,
          collectionId: kAppwriteFavoritesCollectionID,
          documentId: ID.unique(),
          data: data,
      );
    } catch (e) {
      log('Error creating favorites entry', error: e);
      return null;
    }
  }
}