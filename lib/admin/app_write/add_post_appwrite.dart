import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'app_write_post_controller.dart';
import 'app_write_service.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller with AppwriteService dependency
    final AppWritePostController postController =
        Get.put(AppWritePostController(Get.find<AppwriteService>()));

    return Scaffold(
      appBar: AppBar(title: const Text('Add Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                TextFormField(
                  controller: postController.titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextFormField(
                  controller: postController.subtitleController,
                  decoration: const InputDecoration(labelText: 'Subtitle'),
                ),
                TextFormField(
                  controller: postController.detailsController,
                  decoration: const InputDecoration(labelText: 'Details'),
                ),
                Row(
                  children: [
                    Obx(() {
                      return Checkbox(
                        value: postController.isDone.value,
                        onChanged: (bool? value) {
                          postController.toggleDone(value ?? false);
                        },
                      );
                    }),
                    Obx(() {
                      return Text(
                          postController.isDone.value ? "Done" : "Not done");
                    }),
                  ],
                ),
                Obx(() {
                  return postController.selectedImage.value == null
                      ? TextButton.icon(
                          onPressed: () {
                            Get.dialog(AlertDialog(
                              title: const Text('Select Image Source'),
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      leading:
                                          const Icon(Icons.camera_alt_outlined),
                                      title: const Text('Camera'),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        await postController
                                            .pickImage(ImageSource.camera);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      leading: const Icon(Icons.photo),
                                      title: const Text('Gallery'),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        await postController
                                            .pickImage(ImageSource.gallery);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ));
                          },
                          icon: const Icon(Icons.add_a_photo),
                          label: const Text('Add Image'),
                        )
                      : Image.file(
                          postController.selectedImage.value!,
                          height: 500,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        );
                }),
                const SizedBox(height: 20),
                Obx(() {
                  return postController.isUploading.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: postController.addPost,
                          child: const Text('Submit'),
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
