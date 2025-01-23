import 'dart:developer';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import '../../../admin/app_write/app_config.dart';
import '../../../admin/firebase/model/post_model.dart';
import '../service/client_service.dart';

class RoutineController extends GetxController {
  final RetrieveDataService _retrieveDataService;
  var posts = <Post>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  RoutineController()
      : _retrieveDataService = RetrieveDataService(
          Client()
            ..setEndpoint(AppConfig.endpoint)
            ..setProject(AppConfig.projectID)
            ..setSelfSigned(status: true),
        );

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() async {
    try {
      isLoading.value = true;
      posts.value = await _retrieveDataService.getPosts();
      log("messages: posts: $posts");
    } catch (e) {
      log("Error fetching posts: $e");
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
