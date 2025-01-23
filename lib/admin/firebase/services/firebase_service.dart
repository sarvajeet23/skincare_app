// import 'dart:developer';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// import '../model/post_model.dart';

// class FirebaseService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   static const String skinCareCollectionRef = "skinCare";

//   /// Add Post to Firestore
//   Future<void> addPost(Post post) async {
//     try {
//       await _firestore.collection(skinCareCollectionRef).add(post.toMap());
//       log("Post added successfully.");
//     } catch (e) {
//       log("Error adding post: $e");
//       rethrow;
//     }
//   }

//   /// Upload Image to Firebase Storage
//   Future<String> uploadImage(File image) async {
//     final storageRef = _storage
//         .ref()
//         .child('post_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

//     try {
//       final uploadTask = storageRef.putFile(image);
//       final snapshot = await uploadTask.whenComplete(() => null);

//       if (snapshot.state == TaskState.success) {
//         final downloadUrl = await snapshot.ref.getDownloadURL();
//         log("Image uploaded successfully. URL: $downloadUrl");
//         return downloadUrl;
//       } else {
//         throw FirebaseException(
//           plugin: 'firebase_storage',
//           message: 'Image upload failed: ${snapshot.state.toString()}',
//         );
//       }
//     } catch (e) {
//       log("Image upload failed with error: $e");
//       rethrow;
//     }
//   }
// }
