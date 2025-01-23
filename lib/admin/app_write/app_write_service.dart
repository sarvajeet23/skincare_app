import 'dart:developer';
import 'dart:io' as io;
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import '../firebase/model/post_model.dart';
import 'app_config.dart';

class AppwriteService {
  final Databases _databases;
  final Storage _storage;

  AppwriteService(Client client)
      : _databases = Databases(client),
        _storage = Storage(client);

  // Add Post to Appwrite Database
  Future<void> addPost(Post post) async {
    try {
      await _databases.createDocument(
        databaseId: AppConfig.databaseID,
        collectionId: AppConfig.collectionID,
        documentId: 'unique()',
        data: post.toMap(),
      );
      log("Post added successfully.");
    } catch (e, st) {
      log("Error adding post: $e $st");
      rethrow;
    }
  }

  // Upload Image to Appwrite Storage
  Future<String> uploadImage(io.File image) async {
    try {
      final file = await _uploadFile(image);
      return _constructImageUrl(file.$id);
    } catch (e, st) {
      log("Image upload failed: $e $st");
      rethrow;
    }
  }

  // Upload file to Appwrite Storage
  Future<File> _uploadFile(io.File image) async {
    return _storage.createFile(
      bucketId: AppConfig.bucketId,
      fileId: 'image_${DateTime.now().millisecondsSinceEpoch}',
      file: InputFile.fromPath(path: image.path),
    );
  }

  // Construct the URL for the uploaded image
  String _constructImageUrl(String fileId) {
    return '${AppConfig.endpoint}/storage/buckets/${AppConfig.bucketId}/files/$fileId/view?project=${AppConfig.projectID}';
  }
}
