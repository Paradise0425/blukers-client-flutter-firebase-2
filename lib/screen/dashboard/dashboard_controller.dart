import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/dashboard/home/home_controller.dart';

class DashBoardController extends GetxController {
  int currentTab = 0;
  void onBottomBarChange(int index) {
    currentTab = index;
    if (index == 0) {
      debugPrint("INDEX IS 0");
      Get.put(HomeController());
      // homeController.init();
    } else if (index == 1) {
      debugPrint("INDEX IS 1");
      // searchController.init();
    } else if (index == 2) {
      debugPrint("INDEX IS 2");
      // messageController.init();
    } else {
      debugPrint("INDEX IS 3");
      // profileController.init();
    }
    update(['bottom_bar']);
  }
}
