import 'package:get/get.dart';

import '../modules/routine/controller/routine_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RoutineController());
  }
}
