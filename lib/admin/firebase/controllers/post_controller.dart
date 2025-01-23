// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// import '../model/post_model.dart';
// import '../services/firebase_service.dart';

// class PostController extends GetxController {
//   final titleController = TextEditingController();
//   final subtitleController = TextEditingController();
//   final detailsController = TextEditingController();

//   Rx<File?> selectedImage = Rx<File?>(null);
//   RxBool isUploading = false.obs;

//   final FirebaseService _firebaseService = FirebaseService();

//   // Pick Image from Camera or Gallery
//   Future<void> pickImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);

//     if (pickedFile != null) {
//       selectedImage.value = File(pickedFile.path);
//     }
//   }

//   // Add Post to Firestore
//   Future<void> addPost() async {
//     if (titleController.text.trim().isEmpty ||
//         subtitleController.text.trim().isEmpty ||
//         detailsController.text.trim().isEmpty) {
//       Get.snackbar("Error", "Please fill in all fields",
//           snackPosition: SnackPosition.BOTTOM);
//       return;
//     }

//     isUploading.value = true;

//     try {
//       String imageUrl = '';
//       if (selectedImage.value != null) {
//         // Upload the image and get the URL
//         imageUrl = await _firebaseService.uploadImage(selectedImage.value!);
//       }

//       // Create the Post object
//       final post = Post(
//         title: titleController.text.trim(),
//         subtitle: subtitleController.text.trim(),
//         details: detailsController.text.trim(),
//         image: imageUrl,
//         time: DateTime.now(),
//       );

//       // Save the Post to Firestore
//       await _firebaseService.addPost(post);

//       Get.snackbar("Success", "Post added successfully!",
//           snackPosition: SnackPosition.BOTTOM);
//       clearForm();
//     } catch (e) {
//       Get.snackbar("Error", "Failed to add post: $e",
//           snackPosition: SnackPosition.BOTTOM);
//     } finally {
//       isUploading.value = false;
//     }
//   }

//   // Clear Form
//   void clearForm() {
//     titleController.clear();
//     subtitleController.clear();
//     detailsController.clear();
//     selectedImage.value = null;
//   }
// }
