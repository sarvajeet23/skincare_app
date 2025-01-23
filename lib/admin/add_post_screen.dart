// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'package:image_picker/image_picker.dart';

// import 'firebase/controllers/post_controller.dart';

// class AddPostScreen extends StatelessWidget {
//   const AddPostScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final PostController postController = Get.put(PostController());

//     return Scaffold(
//       appBar: AppBar(title: const Text('Add Post')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 TextFormField(
//                   controller: postController.titleController,
//                   decoration: const InputDecoration(labelText: 'Title'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a title';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: postController.subtitleController,
//                   decoration: const InputDecoration(labelText: 'Subtitle'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a subtitle';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: postController.detailsController,
//                   decoration: const InputDecoration(labelText: 'Details'),
//                   maxLines: 4,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter details';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 // Obx(() {
//                 //   return postController.selectedImage.value == null
//                 //       ? TextButton.icon(
//                 //           onPressed: () =>
//                 //               postController.pickImage(ImageSource.gallery),
//                 //           icon: const Icon(Icons.add_a_photo),
//                 //           label: const Text('Add Image'),
//                 //         )
//                 //       : Image.file(
//                 //           postController.selectedImage.value!,
//                 //           height: 150,
//                 //           width: double.infinity,
//                 //           fit: BoxFit.cover,
//                 //         );
//                 // }),
//                 const SizedBox(height: 16),
//                 Obx(() {
//                   return postController.isUploading.value
//                       ? const CircularProgressIndicator()
//                       : ElevatedButton(
//                           onPressed: postController.addPost,
//                           child: const Text('Submit'),
//                         );
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
