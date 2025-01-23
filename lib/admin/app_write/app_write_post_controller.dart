import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../firebase/model/post_model.dart';
import 'app_write_service.dart';

class AppWritePostController extends GetxController {
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final detailsController = TextEditingController();

  Rx<File?> selectedImage = Rx<File?>(null);
  RxBool isUploading = false.obs;
  RxBool isDone = false.obs; // Track the checkbox state

  final AppwriteService _appwriteService;

  AppWritePostController(this._appwriteService);

  // Pick Image from Camera or Gallery
  Future<void> imageAutomaticUpload(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path,);
      isUploading.value = true; // Start upload
      try {
        // Automatically upload the image to the server
        String imageUrl =
            await _appwriteService.uploadImage(selectedImage.value!);
        Get.snackbar("Success", "Image uploaded successfully!",
            snackPosition: SnackPosition.BOTTOM);

        // Do something with the uploaded image URL (optional)
        log("Uploaded Image URL: $imageUrl");
      } catch (e) {
        Get.snackbar("Error", "Failed to upload image: $e",
            snackPosition: SnackPosition.BOTTOM);
        log("message: $e");
      } finally {
        isUploading.value = false; // End upload
      }
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> addPost() async {
    if (titleController.text.trim().isEmpty) {
      Get.snackbar("Error", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isUploading.value = true;

    try {
      String imageUrl = '';
      if (selectedImage.value != null) {
        imageUrl = await _appwriteService.uploadImage(selectedImage.value!);
      }

      final post = Post(
        title: titleController.text.trim(),
        subtitle: subtitleController.text.trim(),
        details: detailsController.text.trim(),
        image: imageUrl,
        time: DateTime.now(),
        isDone: isDone.value,
      );

      await _appwriteService.addPost(post);

      Get.snackbar("Success", "Post added successfully!",
          snackPosition: SnackPosition.BOTTOM);
      clearForm();
    } catch (e) {
      debugPrint("Error adding post: $e");
      Get.snackbar("Error", "Failed to add post: $e",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isUploading.value = false;
    }
  }

  void toggleDone(bool value) {
    isDone.value = value;
  }

  void clearForm() {
    titleController.clear();
    subtitleController.clear();
    detailsController.clear();
    selectedImage.value = null;
    isDone.value = false;
    selectedImage.value = null;
  }
}
