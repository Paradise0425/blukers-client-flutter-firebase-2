import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/screen/manager_section/Profile/profile_controller.dart';

class ManagerDashBoardScreenController extends GetxController
    implements GetxService {
  RxInt currentTab = 0.obs;
  var args = Get.arguments;

  @override
  void onInit() {
    if (args != null) {
      currentTab.value = int.parse(args["index"]);
    }

    super.onInit();
  }

  void onBottomBarChange(int index) {
    currentTab.value = index;
    if (index == 0) {
      debugPrint("INDEX IS 0");
      /* Get.put(ManagerHomeScreen());*/
      // homeController.init();
    } else if (index == 1) {
      debugPrint("INDEX IS 1");
      // searchController.init();
    } else if (index == 2) {
      debugPrint("INDEX IS 2");
      // messageController.init();
    } else {
      debugPrint("INDEX IS 3");
      ProfileController controller = Get.put(ProfileController());
      controller.init();
    }
    update(['bottom_bar']);
  }
}
