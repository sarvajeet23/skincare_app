import 'dart:developer';
import 'package:appwrite/appwrite.dart';
import '../../../admin/app_write/app_config.dart';
import '../../../admin/firebase/model/post_model.dart';

class RetrieveDataService {
  final Databases _databases;

  RetrieveDataService(Client client) : _databases = Databases(client);

  /// Fetches all posts from the Appwrite database.
  /// Returns a list of `Post` objects or throws an exception in case of errors.
  Future<List<Post>> getPosts() async {
    try {
      final response = await _databases.listDocuments(
        databaseId: AppConfig.databaseID,
        collectionId: AppConfig.collectionID,
      );

      log("Successfully retrieved documents: ${response.documents.length}");

      // Safely map the documents to Post objects
      final posts = response.documents
          .map((doc) {
            if (doc.data == null) {
              log("Warning: Document ${doc.$id} has no data.");
              return null;
            }
            try {
              return Post.fromMap(doc.data!);
            } catch (e) {
              log("Error parsing document ${doc.$id}: $e");
              return null;
            }
          })
          .whereType<Post>()
          .toList(); // Filter out null values

      return posts;
    } catch (e, st) {
      log("Error retrieving posts: $e", error: e, stackTrace: st);
      rethrow;
    }
  }
}
