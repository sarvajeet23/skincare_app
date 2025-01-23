import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skincare_app/admin/app_write/app_config.dart';
import 'admin/app_write/app_write_service.dart';
import 'modules/dasboard/dash_board.dart';
import 'modules/routine/controller/routine_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final client = Client();
  client.setEndpoint(AppConfig.endpoint).setProject(AppConfig.projectID);

  final appwriteService = AppwriteService(client);

  Get.put(appwriteService);
  Get.put(RoutineController);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
