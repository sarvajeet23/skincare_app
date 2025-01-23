import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skincare_app/modules/routine/components/detail_page.dart';
import '../../admin/app_write/app_write_post_controller.dart';
import 'controller/routine_controller.dart';

class RoutinePage extends StatelessWidget {
  const RoutinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final RoutineController controller = Get.put(RoutineController());
    final AppWritePostController postController =
        Get.put(AppWritePostController(Get.find()));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Daily Skincare Routine'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.posts.isEmpty) {
          return const Center(child: Text('No posts available.'));
        }

        return ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            var model = controller.posts[index];
            return ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailPage(
                    model: model,
                  );
                }));
              },
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: model.isDone == true
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: model.isDone == true
                    ? const Icon(Icons.check)
                    : const Icon(Icons.close),
              ),
              title: Text(
                model.title ?? "Unknown Title",
              ),
              subtitle: Text(model.subtitle ?? "Unknown Subtitle"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Center(child: Text('Select Source')),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListTile(
                                    leading:
                                        const Icon(Icons.camera_alt_outlined),
                                    title: const Text('Camera'),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      await postController.imageAutomaticUpload(
                                          ImageSource.camera);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    leading: const Icon(Icons.photo),
                                    title: const Text('Gallery'),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      await postController.imageAutomaticUpload(
                                          ImageSource.gallery);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Icon(Icons.camera_alt_outlined),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    model.time != null
                        ? DateFormat('h:mm a').format(model.time!)
                        : "Unknown Time",
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
